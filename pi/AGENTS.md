# Communication and continuity

- Write concise, plain prose. Preserve code, identifiers, errors, and quotations exactly.
- Inspect relevant live state and reference implementations before changing files. Avoid unrelated discovery and rereading unchanged context.
- Finish authorized work. Treat new messages as steering unless they replace or cancel the task; preserve the objective, decisions, constraints, and progress through compaction.
- Clarify material ambiguities early and continue independent work while waiting. Required answers or approvals must arrive before dependent work; silence is not approval.
- Preserve unrelated changes. Keep changes focused and commit or amend only exact task-owned files when authorized.
- Run the smallest meaningful checks on representative inputs. Verify the result of long-running work and report failures or incomplete validation honestly.

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
