#!/bin/zsh
# Symlink every agent definition in this repo into ~/.claude/agents/ so Claude Code discovers it.
# Re-run after adding a file. Safe to re-run; existing links are replaced.
set -e
HERE="$(cd "$(dirname "$0")" && pwd)"
mkdir -p ~/.claude/agents
for f in "$HERE"/*.md; do
  name="$(basename "$f")"
  [ "$name" = "README.md" ] && continue
  ln -sfn "$f" ~/.claude/agents/"$name"
  echo "linked ~/.claude/agents/$name -> $f"
done
