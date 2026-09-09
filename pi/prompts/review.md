---
description: Review current working-tree changes without modifying files
argument-hint: "[focus]"
---
Review the current working-tree changes as a code reviewer. Do not modify files.

1. Read the repository instructions.
2. Inspect `git status --short`, `git diff`, and `git diff --cached`.
3. Trace the affected execution paths and relevant tests.
4. Report only actionable findings, ordered by severity, with file and line references.
5. For each finding, explain the impact and the smallest reasonable fix.
6. If there are no findings, say so and identify any residual testing or coverage risks.

Additional focus: ${ARGUMENTS:-none}
