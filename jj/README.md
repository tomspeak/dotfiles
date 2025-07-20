# Jujutsu (jj) Configuration

This directory contains Jujutsu VCS configuration that mirrors your Git setup.

## Installation

jj is installed via Homebrew:
```bash
brew install jj
```

## Configuration Files

- `config.toml` - Main jj configuration matching your git settings
- `ignore` - Global ignore patterns (mirrors gitignore_global)
- `README.md` - This documentation

## Quick Start

### Convert existing Git repo to jj:
```bash
cd your-git-repo
jj git init --git-repo .
```

### Start fresh jj repo:
```bash
jj init my-new-repo
cd my-new-repo
```

## Command Mapping (Git → jj)

| Git Command | jj Equivalent | Alias |
|-------------|---------------|-------|
| `git status` | `jj status` | `js`, `jst` |
| `git log` | `jj log` | `jl`, `jlog` |
| `git diff` | `jj diff` | `jd` |
| `git checkout` | `jj edit` | `jco` |
| `git commit` | `jj commit` | `jci` |
| `git commit -m` | `jj commit -m` | `jcim` |
| `git commit --amend` | `jj commit --amend` | `jca` |
| `git push` | `jj git push` | `jp` |
| `git push --force-with-lease` | `jj git push --force-with-lease` | `jpf` |
| `git fetch` | `jj git fetch` | `jf` |
| `git branch` | `jj bookmark list` | `jb` |
| `git checkout -b` | `jj bookmark create` | `jnb` |
| `git rebase` | `jj rebase` | `jrebase` |

## Key Differences from Git

1. **Working Copy is a Commit**: Your working directory is always a commit that gets automatically amended
2. **Change IDs**: Each change has a stable ID that persists through rewrites
3. **Bookmarks vs Branches**: jj uses "bookmarks" instead of branches
4. **No Staging Area**: Changes are automatically tracked
5. **Conflict Resolution**: Conflicts don't block other operations

## Custom Functions

- `jjr` - Interactive bookmark selector with fzf (like git `br` alias)
- `jjpr <name> [description]` - Create bookmark, push, and open GitHub PR

## Workflow Examples

### Basic workflow:
```bash
# Start working on a feature
jj new main
jj describe -m "Add new feature"

# Make changes...
# Changes are automatically tracked

# Commit current state
jj commit -m "Implement feature logic"

# Create a bookmark for GitHub
jj bookmark create feature-branch

# Push to GitHub
jj git push --bookmark feature-branch
```

### Working with existing changes:
```bash
# See your recent changes
jj log

# Edit a specific change
jj edit <change-id>

# Squash changes together
jj squash -r <change-id>

# Split a change
jj split
```

## Prompt Integration

Your zsh prompt shows both git and jj status:
- Git: ` (branch*)`  
- jj: ` [jj:change_id*]`

The `*` indicates uncommitted changes in both cases.

## Configuration Details

The `config.toml` mirrors your git configuration:
- Same user name/email
- Similar color scheme
- Matching diff algorithm (histogram)
- Auto-fetch from origin/upstream
- nvim as editor
- Delta for diffs (if available)

## Tips

1. Use `jj undo` to undo any operation (very powerful!)
2. `jj op log` shows all operations - great for debugging
3. `jj split` is excellent for breaking up large changes
4. Conflicts can be committed and resolved later
5. Use `jj workspace` for multiple working copies of the same repo