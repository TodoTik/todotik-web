#!/bin/sh
# SessionStart hook — activate the repo's git hooks in this clone.
#
# core.hooksPath is per-clone configuration; fresh clones (including
# Claude Code web sessions) do not have it set, so the org-policy
# commit-msg hook in .githooks/ would silently not run.  Setting it
# here is idempotent and instant.
git -C "$CLAUDE_PROJECT_DIR" config core.hooksPath .githooks
