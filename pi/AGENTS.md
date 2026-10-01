# Tools

- `rg`: content search; `fd`: file discovery (Pi's grep/find use these).
- `jq`: JSON; `gh`: GitHub PRs, issues, and CI (`--json` preferred).
- `shellcheck` / `shfmt`: shell lint / format; `stylua`: Lua; `taplo`: TOML.
- `uv`: Python environments and scripts; respect existing project tooling.
- `hyperfine`: benchmarks; `ffmpeg` / `yt-dlp`: media processing / downloads.
- `web_search` / `fetch_content`: web research and documentation.

# Native Pi subagents

- Use the installed `pi-subagents` tools and bundled skill; do not add custom runners or Codemode bridges.
- Native Pi children have Codemode enabled alongside their role's tool allowlist. Research roles explicitly load `pi-web-access`.
- Subagents must use only `openai-codex/*` models through the OpenAI subscription. The default is `openai-codex/gpt-6.1-sol`; native strict model-scope enforcement rejects other providers. Never weaken this policy, enable external runners, or bypass it through other model APIs. Project settings must preserve this restriction.
- Use focused native agents, give them complete briefs, and keep overlapping writes sequential.
