import { CustomEditor, type ExtensionAPI, type ExtensionContext } from "@earendil-works/pi-coding-agent";
import { truncateToWidth, type TuiMouseEvent } from "@earendil-works/pi-tui";

export class RailEditor extends CustomEditor {
  private above = 0;
  private below = 0;
  private sourceRows: number[] = [];
  private sourceHeight = 0;

  protected renderTopBorder(_width: number, hidden: number): string {
    this.above = hidden;
    return "";
  }

  protected renderBottomBorder(_width: number, hidden: number): string {
    this.below = hidden;
    return "";
  }

  render(width: number): string[] {
    this.sourceRows = [];
    if (width < 1) return [];
    // Native wrapping needs room for a double-width glyph plus padding.
    const lines = super.render(Math.max(4, width));
    this.sourceHeight = lines.length;
    // Our empty border slots delimit the padded input; autocomplete follows them.
    // ponytail: relies on Pi's native row layout; revisit if its border slots change.
    const bottom = lines.indexOf("", 1);
    if (bottom < 2) {
      this.sourceRows = lines.map((_line, index) => index);
      return lines.map((line) => truncateToWidth(line, width, ""));
    }
    return lines.flatMap((line, index) => {
      if (index === 0 || index === bottom) {
        const hidden = index === 0 ? this.above : this.below;
        if (!hidden) return [];
        line = this.borderColor(` ${index === 0 ? "↑" : "↓"} ${hidden} more`);
      } else if (index < bottom && width >= 3 && this.getPaddingX() > 0 && line.startsWith(" ")) {
        // Replace padding, not text: wrapping and cursor columns stay native.
        line = this.borderColor("▎") + line.slice(1);
      }
      this.sourceRows.push(index);
      return [truncateToWidth(line, width, "")];
    });
  }

  handleMouse(event: TuiMouseEvent) {
    const y = this.sourceRows[event.y];
    if (y === undefined) return undefined;
    return super.handleMouse({ ...event, y, width: Math.max(4, event.width), height: this.sourceHeight });
  }
}

export default function (pi: ExtensionAPI) {
  const indicator = (_event: unknown, ctx: ExtensionContext) => {
    if (ctx.mode !== "tui") return;
    ctx.ui.setWorkingIndicator({
      frames: ["·", "•"].map((frame) => ctx.ui.theme.fg("muted", frame)),
      intervalMs: 500,
    });
  };
  pi.on("session_start", (event, ctx) => {
    if (ctx.mode !== "tui") return;
    ctx.ui.setEditorComponent((tui, theme, keybindings) => new RailEditor(tui, theme, keybindings));
    indicator(event, ctx);
  });
  pi.on("agent_start", indicator);
  pi.on("session_shutdown", (_event, ctx) => {
    if (ctx.mode !== "tui") return;
    ctx.ui.setEditorComponent(undefined);
    ctx.ui.setWorkingIndicator();
  });
}
