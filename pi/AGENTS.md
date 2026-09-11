# Tools

- `rg`: content search; `fd`: file discovery (Pi's grep/find use these).
- `jq`: JSON; `gh`: GitHub PRs, issues, and CI (`--json` preferred).
- `shellcheck` / `shfmt`: shell lint / format; `stylua`: Lua; `taplo`: TOML.
- `uv`: Python environments and scripts; respect existing project tooling.
- `hyperfine`: benchmarks; `ffmpeg` / `yt-dlp`: media processing / downloads.
- `web_search` / `fetch_content`: web research and documentation.

# Fabric agents

- Use `agents.run` or `agents.spawn` inside `fabric_exec`; put the complete task and any role-specific instructions in each call.
- Use individual agents for ordinary delegation. Use recursive agents, councils, meshes, or workflows only when the user explicitly requests multi-agent orchestration.
- Set `runner: "pi"`, an exact model key from Pi's current `enabledModels`, and an appropriate thinking level for every agent call. `agents.models()` is a catalog, not an allowlist.
- Never use fuzzy model selectors, Claude or Veda runners, `extensions: false`, recursive agents, or Git worktrees.
