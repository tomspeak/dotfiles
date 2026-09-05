import assert from "node:assert/strict";
import { basename } from "node:path";
import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";

export default function title(pi: ExtensionAPI) {
  let waiting = false;
  function update(ctx: ExtensionContext) {
    if (ctx.mode !== "tui") return;
    const state = waiting ? "waiting" : ctx.isIdle() ? "ready" : "running";
    const project = basename(ctx.cwd).replace(/[\x00-\x1f\x7f-\x9f#]/g, "_");
    ctx.ui.setTitle(`π ${state} - ${project}`);
  }
  for (const event of ["agent_start", "agent_settled"] as const) {
    pi.on(event, (_event, ctx) => update(ctx));
  }
  pi.on("ui_prompt_start", (_event, ctx) => { waiting = true; update(ctx); });
  pi.on("ui_prompt_end", (_event, ctx) => { waiting = false; update(ctx); });
  pi.on("session_shutdown", (_event, ctx) => {
    if (ctx.mode === "tui") ctx.ui.setTitle("");
  });
}

// Run with: node pi/extensions/title.ts
if (import.meta.main) {
  const handlers = new Map();
  const titles: string[] = [];
  let idle = true;
  const ctx = { mode: "tui", cwd: "/tmp/project", isIdle: () => idle,
    ui: { setTitle: (title: string) => titles.push(title) } };
  const pi = { on: (name: string, handler: unknown) => handlers.set(name, handler) };
  title(pi as unknown as ExtensionAPI);
  handlers.get("agent_settled")({}, ctx);
  idle = false;
  handlers.get("agent_start")({}, ctx);
  handlers.get("ui_prompt_start")({}, ctx);
  handlers.get("ui_prompt_end")({}, ctx);
  idle = true;
  handlers.get("agent_settled")({}, ctx);
  handlers.get("session_shutdown")({}, ctx);
  handlers.get("agent_start")({}, { ...ctx, mode: "print" });
  assert.deepEqual(titles, ["π ready - project", "π running - project", "π waiting - project",
    "π running - project", "π ready - project", ""]);
  console.log("Title lifecycle check passed");
}
