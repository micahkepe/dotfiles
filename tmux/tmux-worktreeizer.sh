#!/usr/bin/env bash

# Auto-magical tmux session creation for a chosen worktree.
#
# Usage:
#   $ tmux-worktreeizer.sh
#
# Description:
#
#   For ease of use, symlink this script to a directory in your PATH, e.g.:
#
#   $ ln -s ~/path/to/tmux-worktreeizer ~/.local/bin/tmux-worktreeizer
#
#   Then you can simply run with `tmux-worktreeizer`
#
# Effects:
#   - prompted with fzf menu to select the target branch
#   - a new tmux session will be created with the truncated branch name as the
#     name
#
# Example:
#
#   Say we are currently in the repo root at ~/my-repo and we are on `main`
#   branch.
#
#   $ tmux-worktreeizer
#
#   You will then be prompted with fzf to select the branch you want to work on:
#
#   ```
#   main
#   feature/foo
#   feature/bar
#   ...
#   worktree branch> ▮
#   ```
#
#   You can then select the branch you want to work on, and a new tmux session
#   will be created with the truncated branch name as the name.
#
#   The worktree will be created in a directory next to the repo root, e.g.:
#   ~/my-repo/my-repo-worktrees/main
#
#   If the worktree already exists, it will be reused (idempotent switching).

if ! (git rev-parse --is-inside-worktree) >/dev/null 2>&1; then
  echo "Error: Not inside of a git directory."
  exit 1
fi

# Update/cleanup refs
git fetch --quiet --prune

# Stable base: the common git dir (shared across worktrees)
COMMON_GIT_DIR="$(git rev-parse --path-format=absolute --git-common-dir)"

# Repo "root" is the parent of the common .git dir
REPO_ROOT="$(cd "$COMMON_GIT_DIR/.." && pwd)"
REPO_NAME="$(basename "$REPO_ROOT")"

# ---- Build branch list: local + remote-only ----
# Single-pass: collect local and remote branches, diff them with comm
local_branches="$(git branch --format='%(refname:short)' || true)"

remote_only="$(
  comm -23 \
    <(git branch -r --format='%(refname:short)' |
      sed 's|^[^/]*/||' |
      grep -v '^HEAD$' |
      sort -u) \
    <(git branch --format='%(refname:short)' | sort -u)
)"

branches="$(
  {
    printf '%s\n' "$local_branches"
    if [[ -n "$remote_only" ]]; then
      printf '%s\n' "$remote_only" | sed 's/^/remote: /'
    fi
  } | grep -v '^$'
)"

selection="$(printf '%s\n' "$branches" | fzf --prompt="worktree branch> ")"

if [[ -z $selection ]]; then
  exit 0
fi

# Strip the "remote: " prefix if present
if [[ "$selection" == remote:\ * ]]; then
  branch="${selection#remote: }"
else
  branch="$selection"
fi

if [[ -z $branch ]]; then
  exit 0
fi

# Setup the worktree name
base="${branch##*/}"

# Grab a leading ticket like ENG-1234 / eng-1234
ticket="$(printf '%s\n' "$base" | grep -oE '^[[:alpha:]]+-[0-9]+' || true)"

if [[ -n "$ticket" ]]; then
  # Remove "<ticket>-" prefix
  rest="${base#"$ticket"-}"

  # Take first 3 dash-separated words
  short_rest="$(printf '%s\n' "$rest" | cut -d- -f1-3)"

  WORKTREE_NAME="${ticket}-${short_rest}"
else
  # No ticket: just take first 4 words of base (or cap length)
  WORKTREE_NAME="$(printf '%s\n' "$base" | cut -d- -f1-4)"
fi

# Normalize to lowercase
WORKTREE_NAME="$(printf '%s\n' "$WORKTREE_NAME" | tr '[:upper:]' '[:lower:]')"

# Truncate to 40 characters
WORKTREE_NAME="${WORKTREE_NAME:0:40}"

# Store worktrees next to the repo root (stable across worktrees)
WORKTREES_DIR="$(cd "$REPO_ROOT/.." && pwd)/${REPO_NAME}-worktrees"
mkdir -p "$WORKTREES_DIR"

CANONICAL_WORKTREE_PATH="$WORKTREES_DIR/$WORKTREE_NAME"

# ---- Idempotent worktree switching ----
# If a worktree already exists for this branch, reuse it.
# git worktree list --porcelain has repeated blocks like:
# worktree <path>
# HEAD <sha>
# branch refs/heads/<name>
existing_path="$(
  git worktree list --porcelain |
    awk -v want="refs/heads/$branch" '
      $1=="worktree" { wt=$2 }
      $1=="branch" && $2==want { print wt; exit }
    '
)"

if [[ -n "$existing_path" ]]; then
  WORKTREE_PATH="$existing_path"
else
  WORKTREE_PATH="$CANONICAL_WORKTREE_PATH"

  # If directory exists but isn't a registered worktree, fail loudly to avoid clobbering.
  if [[ -e "$WORKTREE_PATH" ]]; then
    echo "Error: $WORKTREE_PATH exists but is not an existing worktree for $branch."
    echo "Move/remove it, or pick a different naming scheme."
    exit 1
  fi

  OUTPUT=$(git worktree add "$WORKTREE_PATH" "$branch" 2>&1) || {
    echo "Error: unable to create worktree."
    echo ""
    echo "$OUTPUT"
    exit 1
  }
fi

# ---- Find or create tmux session for this worktree ----

# Check if any existing tmux session is already rooted at this worktree path.
# This handles the case where e.g. main is checked out at REPO_ROOT itself.
existing_session="$(
  tmux list-sessions -F '#{session_name}:#{session_path}' 2>/dev/null |
    while IFS=: read -r sname spath; do
      if [[ "$(cd "$spath" 2>/dev/null && pwd)" == "$(cd "$WORKTREE_PATH" 2>/dev/null && pwd)" ]]; then
        printf '%s' "$sname"
        break
      fi
    done
)" || true

SESSION_NAME="${existing_session:-$WORKTREE_NAME}"

tmux_running=$(pgrep tmux || true)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
  tmux new-session -s "$SESSION_NAME" -c "$WORKTREE_PATH"
  exit 0
fi

if ! tmux has-session -t="$SESSION_NAME" 2>/dev/null; then
  tmux new-session -ds "$SESSION_NAME" -c "$WORKTREE_PATH"
fi

if [[ -n $TMUX ]]; then
  tmux switch-client -t "$SESSION_NAME"
else
  tmux attach-session -t "$SESSION_NAME"
fi
