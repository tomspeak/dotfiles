import assert from "node:assert/strict";
import { pathToFileURL } from "node:url";
import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

const dangerousCommands = [
	/\brm\b[^\n;&|]*(?:--recursive|-[a-z]*r[a-z]*)/i,
	/\b(?:sudo|doas)\b/i,
	/\b(?:chmod|chown)\b[^\n;&|]*\b777\b/i,
	/\bgit\s+(?:reset\s+--hard|clean\b[^\n;&|]*(?:--force|-[a-z]*f[a-z]*)|push\b[^\n;&|]*(?:--force(?:-with-lease)?|-f(?:\s|$)))/i,
];

export function isDangerousCommand(command: string): boolean {
	return dangerousCommands.some((pattern) => pattern.test(command));
}

export function isProtectedPath(path: string): boolean {
	const normalized = path.replaceAll("\\", "/");
	return /(^|\/)(?:\.git|node_modules)(\/|$)/.test(normalized)
		|| /(^|\/)\.env(?:\.[^/]*)?$/.test(normalized)
		|| /(^|\/)(?:\.pi\/agent|pi)\/(?:auth\.json|models-store\.json|sessions|missions|npm|web-search-cache)(?:\/|$)/.test(normalized);
}

export default function (pi: ExtensionAPI) {
	pi.on("tool_call", async (event, ctx) => {
		if (event.toolName === "bash") {
			const command = String(event.input.command ?? "");
			if (!isDangerousCommand(command)) return;
			if (!ctx.hasUI) return { block: true, reason: "Dangerous command blocked without interactive confirmation" };

			const choice = await ctx.ui.select(`Dangerous command:\n\n${command}\n\nAllow?`, ["No", "Yes"]);
			if (choice !== "Yes") return { block: true, reason: "Blocked by user" };
		}

		if (event.toolName === "write" || event.toolName === "edit") {
			const path = String(event.input.path ?? "");
			if (!isProtectedPath(path)) return;
			if (ctx.hasUI) ctx.ui.notify(`Blocked write to protected path: ${path}`, "warning");
			return { block: true, reason: `Path "${path}" is protected` };
		}
	});
}

if (process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href) {
	assert.equal(isDangerousCommand("rm file"), false);
	assert.equal(isDangerousCommand("rm -rf build"), true);
	assert.equal(isDangerousCommand("git push --force-with-lease"), true);
	assert.equal(isProtectedPath("src/sessions/index.ts"), false);
	assert.equal(isProtectedPath("~/.pi/agent/auth.json"), true);
	assert.equal(isProtectedPath("/Users/me/dotfiles/pi/sessions/run.jsonl"), true);
	console.log("guardrails self-check passed");
}
