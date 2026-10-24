import assert from "node:assert/strict";
import { test } from "node:test";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";
import rexQuestions from "../extensions/rex-questions.ts";

function harness(options: {
  mode?: string;
  isTTY?: boolean;
  env?: NodeJS.ProcessEnv;
  failWrite?: boolean;
  idle?: boolean;
} = {}) {
  const handlers = new Map<string, (...args: any[]) => void>();
  const listeners = new Set<(data: unknown) => void>();
  const output: string[] = [];
  const pi = {
    on: (name: string, handler: (...args: any[]) => void) => handlers.set(name, handler),
    events: {
      on: (channel: string, listener: (data: unknown) => void) => {
        assert.equal(channel, "rpiv:ask-user:blocked");
        listeners.add(listener);
        return () => { listeners.delete(listener); };
      },
    },
  };
  rexQuestions(pi as unknown as ExtensionAPI, {
    env: { TERM_PROGRAM: "rex", ...options.env },
    isTTY: options.isTTY ?? true,
    write: (text) => {
      if (options.failWrite) throw new Error("terminal closed");
      output.push(text);
    },
  });
  const fire = (name: string) => handlers.get(name)?.({}, {
    mode: options.mode ?? "tui", isIdle: () => options.idle ?? false,
  });
  const emit = (data: unknown) => { for (const listener of listeners) listener(data); };
  fire("session_start");
  return { fire, emit, output, listeners };
}

test("reports the root as blocked, then restores working without clearing other records", () => {
  const h = harness();
  assert.deepEqual(h.output, []);
  h.emit({ active: true, toolCallId: "question-1", extra: "ignored" });
  assert.equal(h.output[0], "\x1b]7501;app=pi:state=blocked:kind=question:msg="
    + Buffer.from("Pi needs your answer").toString("base64") + "\x1b\\");
  h.emit({ active: false, toolCallId: "question-1" });
  assert.equal(h.output[1], "\x1b]7501;app=pi:state=working\x1b\\");
});

test("parallel questions and duplicate events do not clear or re-alert early", () => {
  const h = harness();
  h.emit({ active: true, toolCallId: "a" });
  h.emit({ active: true, toolCallId: "a" });
  h.emit({ active: true, toolCallId: "b" });
  h.emit({ active: false, toolCallId: "unknown" });
  h.emit({ active: false, toolCallId: "a" });
  assert.equal(h.output.length, 1);
  h.emit({ active: false, toolCallId: "b" });
  h.emit({ active: false, toolCallId: "b" });
  assert.equal(h.output.length, 2);
});

test("cancellation/error finalizers and legacy events clear the waiting state", () => {
  const h = harness();
  h.emit({ active: true });
  h.emit({ active: false });
  assert.equal(h.output.length, 2);
  for (const invalid of [null, undefined, false, {}, { active: "true" }]) h.emit(invalid);
  assert.equal(h.output.length, 2);
});

test("idle questions restore idle; settled native done/error reports are left alone", () => {
  const h = harness({ idle: true });
  h.emit({ active: true });
  h.emit({ active: false });
  assert.equal(h.output[1], "\x1b]7501;app=pi:state=idle\x1b\\");
  h.fire("agent_settled");
  assert.equal(h.output.length, 2);
});

test("shutdown and session replacement clean up idempotently", () => {
  const h = harness();
  h.emit({ active: true, toolCallId: "a" });
  h.emit({ active: false, toolCallId: "a" });
  h.emit({ active: true, toolCallId: "b" });
  h.fire("session_shutdown");
  h.fire("session_shutdown");
  assert.equal(h.output.length, 4);
  assert.equal(h.output[3], "\x1b]7501;app=pi:state=idle\x1b\\");
  assert.equal(h.listeners.size, 0);
  h.emit({ active: true, toolCallId: "ignored" });
  assert.equal(h.output.length, 4);
  h.fire("session_start");
  h.fire("session_start");
  assert.equal(h.listeners.size, 1);
  h.emit({ active: true, toolCallId: "new" });
  assert.equal(h.output.length, 5);
  h.fire("session_start");
  assert.equal(h.output.length, 6);
});

test("only direct interactive Rex sessions report; explicit opt-out is respected", () => {
  for (const options of [
    { mode: "rpc" }, { mode: "print" }, { mode: "json" }, { isTTY: false },
    { env: { TERM_PROGRAM: "ghostty" } }, { env: { TMUX: "/tmp/tmux,1,0" } },
    { env: { STY: "screen" } }, { env: { PI_PROGRAM_STATUS: "0" } },
  ]) {
    const h = harness(options);
    h.emit({ active: true });
    h.fire("agent_settled");
    h.fire("session_shutdown");
    assert.equal(h.listeners.size, 0);
    assert.deepEqual(h.output, []);
  }
});

test("terminal write failures never block the questionnaire lifecycle", () => {
  const h = harness({ failWrite: true });
  assert.doesNotThrow(() => {
    h.emit({ active: true });
    h.emit({ active: false });
    h.fire("session_shutdown");
  });
});
