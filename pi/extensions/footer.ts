import { basename } from "node:path";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import { truncateToWidth, visibleWidth } from "@earendil-works/pi-tui";

export default function (pi: ExtensionAPI) {
  let model = "no-model", thinking = "off", redraw = () => {};

  pi.on("session_start", (_event, ctx) => {
    if (ctx.mode !== "tui") return;
    model = ctx.model?.id.replace(/^gpt-/, "") ?? model;
    thinking = ctx.thinkingLevel;
    ctx.ui.setFooter((tui, theme, footer) => ({
      invalidate() {},
      dispose: footer.onBranchChange(() => tui.requestRender()),
      render(width: number) {
        redraw = () => tui.requestRender();
        const sep = theme.fg("dim", " │ ");
        const percent = ctx.getContextUsage()?.percent;
        const left = ` ${theme.bold(basename(ctx.cwd))}${sep}${theme.fg("muted", footer.getGitBranch() ?? "no-git")}`;
        const right = `${theme.fg("accent", model)}${sep}${theme.fg("muted", thinking)}${sep}${theme.fg("muted", `ctx ${percent == null ? "—" : `${Math.round(percent)}%`}`)} `;
        const shownLeft = truncateToWidth(left, Math.max(0, width - visibleWidth(right) - 1), "");
        return [truncateToWidth(shownLeft + " ".repeat(Math.max(1, width - visibleWidth(shownLeft) - visibleWidth(right))) + right, width, "")];
      },
    }));
  });

  pi.on("model_select", ({ model: next }) => { model = next.id.replace(/^gpt-/, ""); redraw(); });
  pi.on("thinking_level_select", ({ level }) => { thinking = level; redraw(); });
}
