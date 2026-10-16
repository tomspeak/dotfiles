import { chmodSync, existsSync } from "node:fs";
import { SessionManager, type ExtensionAPI } from "@earendil-works/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  let opening = false;

  pi.registerCommand("fork-tmux", {
    description: "Fork the current branch into a right-hand tmux split",
    handler: async (args, ctx) => {
      const pane = process.env.TMUX_PANE;
      if (args.trim()) {
        ctx.ui.notify("Usage: /fork-tmux", "error");
        return;
      }
      if (ctx.mode !== "tui" || !process.env.TMUX || !pane) {
        ctx.ui.notify("/fork-tmux requires an interactive Pi session inside tmux.", "error");
        return;
      }
      if (opening || !ctx.isIdle()) {
        ctx.ui.notify("Wait for Pi to finish before forking.", "warning");
        return;
      }
      const source = ctx.sessionManager.getSessionFile();
      const leaf = ctx.sessionManager.getLeafId();
      if (!source || !leaf || !existsSync(source)) {
        ctx.ui.notify("There is no saved conversation to fork yet.", "error");
        return;
      }
      if (!ctx.model) {
        ctx.ui.notify("Select a model before forking.", "error");
        return;
      }

      opening = true;
      let fork: string | undefined;
      try {
        // Branching mutates its manager, so never use the live session's manager.
        const copy = SessionManager.open(source, ctx.sessionManager.getSessionDir(), ctx.cwd);
        fork = copy.createBranchedSession(leaf);
        if (!fork || !existsSync(fork)) throw new Error("The fork could not be saved.");
        chmodSync(fork, 0o600);

        const env: string[] = [];
        for (const name of [
          "PATH",
          "PI_CODING_AGENT_DIR",
          "PI_OFFLINE",
          "PI_TELEMETRY",
        ]) {
          const value = process.env[name];
          if (value !== undefined) env.push("-e", `${name}=${value}`);
        }
        const result = await pi.exec(
          "tmux",
          [
            "split-window",
            "-h",
            "-p",
            "50",
            "-P",
            "-F",
            "#{pane_id}",
            "-t",
            pane,
            "-c",
            ctx.cwd,
            ...env,
            "pi",
            "--session",
            fork,
            "--session-dir",
            copy.getSessionDir(),
            "--provider",
            ctx.model.provider,
            "--model",
            ctx.model.id,
            "--thinking",
            ctx.thinkingLevel,
          ],
          { timeout: 10000 },
        );
        if (result.code !== 0)
          throw new Error(result.stderr.trim() || "tmux could not open the split.");
        ctx.ui.notify(`Fork opened in tmux pane ${result.stdout.trim()}.`, "info");
      } catch (error) {
        ctx.ui.notify(
          `Fork failed: ${String(error)}${fork ? `\nFork session: ${fork}` : ""}`,
          "error",
        );
      } finally {
        opening = false;
      }
    },
  });
}
