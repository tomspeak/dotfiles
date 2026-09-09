# Tools

- `rg`: content search; `fd`: file discovery (Pi's grep/find use these).
- `jq`: JSON; `gh`: GitHub PRs, issues, and CI (`--json` preferred).
- `shellcheck` / `shfmt`: shell lint / format; `stylua`: Lua; `taplo`: TOML.
- `uv`: Python environments and scripts; respect existing project tooling.
- `hyperfine`: benchmarks; `ffmpeg` / `yt-dlp`: media processing / downloads.
- `web_search` / `fetch_content`: web research and documentation.

# Subagents

- Use `general-purpose`; put the task and any role-specific instructions in the call prompt.
- Choose an explicit model from `enabledModels` and an appropriate thinking level for each call.
