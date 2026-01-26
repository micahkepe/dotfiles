#!/usr/bin/env bash
# Create a new tmux session for a chosen worktree.

if ! (git rev-parse --is-inside-worktree) >/dev/null 2>&1; then
  echo "Error: Not inside of a git directory."
  exit 1
fi

GIT_DIR=$(git rev-parse --show-toplevel)
REPO_NAME=$(basename "$GIT_DIR")

# Update from the remote to ensure up-to-date
git fetch --quiet

current_branch=$(git branch --show-current)
branch=$(
  FZF_TMUX=1 git branch --format='%(refname:short)' |
    grep -v "^$current_branch$" |
    fzf
)

if [[ -z $branch ]]; then
  exit 0
fi

WORKTREE_NAME="$REPO_NAME-$(echo "$branch" | tr / -)"
WORKTREE_PATH="$GIT_DIR/../$WORKTREE_NAME"

OUTPUT=$(git worktree add "$WORKTREE_PATH" "$branch" 2>&1) || {
  echo "Error: unable to create worktree."
  echo ""
  echo "$OUTPUT"
  exit 1
}

tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
  tmux new-session -s "$WORKTREE_NAME" -c "$WORKTREE_PATH"
  exit 0
fi

# create new session if name doesn't exist
if ! tmux has-session -t="$WORKTREE_NAME" 2>/dev/null; then
  tmux new-session -ds "$WORKTREE_NAME" -c "$WORKTREE_PATH"
fi

if [[ -n $TMUX ]]; then
  tmux switch-client -t "$WORKTREE_NAME"
else
  # if running outside of tmux, attach to the new session
  tmux attach-session -t "$WORKTREE_NAME"
fi
