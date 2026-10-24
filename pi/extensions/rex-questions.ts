import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

interface TerminalOutput {
  env: NodeJS.ProcessEnv;
  isTTY: boolean;
  write: (text: string) => void;
}

// Bridge rpiv's questionnaire lifecycle to Rex's native activity system.
// Rex 1408 did not notify for a child blocked record alongside a working root.
// Temporarily report the root as blocked, then restore working/idle ourselves:
// Pi deduplicates its own reports, so it may not re-emit an unchanged working state.
// No question text leaves the TUI; Rex owns notification policy and delivery.
const blocked = `\x1b]7501;app=pi:state=blocked:kind=question:msg=${Buffer.from("Pi needs your answer").toString("base64")}\x1b\\`;

export default function rexQuestions(
  pi: ExtensionAPI,
  terminal: TerminalOutput = {
    env: process.env,
    isTTY: process.stdout.isTTY === true,
    write: (text) => { process.stdout.write(text); },
  },
) {
  const pending = new Set<string>();
  let reported = false;
  let unsubscribe: (() => void) | undefined;

  function report(waiting: boolean, resting: "working" | "idle" = "idle") {
    if (waiting === reported) return;
    try {
      terminal.write(waiting ? blocked : `\x1b]7501;app=pi:state=${resting}\x1b\\`);
      reported = waiting;
    } catch {
      // Attention reporting must never prevent answering or cancelling a question.
    }
  }

  function cleanup() {
    unsubscribe?.();
    unsubscribe = undefined;
    pending.clear();
    report(false);
  }

  pi.on("session_start", (_event, ctx) => {
    cleanup();
    const env = terminal.env;
    if (ctx.mode !== "tui" || !terminal.isTTY || env.TERM_PROGRAM !== "rex"
      || env.TMUX || env.STY || env.PI_PROGRAM_STATUS === "0") return;

    unsubscribe = pi.events.on("rpiv:ask-user:blocked", (data) => {
      if (!data || typeof data !== "object" || !("active" in data)
        || typeof data.active !== "boolean") return;
      const id = "toolCallId" in data && typeof data.toolCallId === "string"
        ? data.toolCallId : "legacy";
      if (data.active) pending.add(id);
      else pending.delete(id);
      report(pending.size > 0, ctx.isIdle() ? "idle" : "working");
    });
  });

  // rpiv emits active:false in finally on answer, cancellation, and errors.
  // Pi retains ownership of settled done/error states. Shutdown/reload restores
  // idle only if this extension still has an unanswered question.
  pi.on("session_shutdown", cleanup);
}
