#!/usr/bin/env bash
# Create a new tmux session for a chosen worktree.
#
# TODO:
# - Nice preview of branches
# - Idempotent worktree switching --> if select worktree already in use, just
#   switch to it
# - Display remote branches as well in picker, and if selected, it "just works"
#   --> set up refs behind the scenes

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

# Store worktrees in a separate directory alongside the git repo
WORKTREES_DIR="$GIT_DIR/../$REPO_NAME-worktrees/"
mkdir -p "$WORKTREES_DIR"

WORKTREE_PATH="$WORKTREES_DIR/$WORKTREE_NAME"

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
