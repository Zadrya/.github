#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Tests for scripts/check-attribution.sh.
set -euo pipefail

cd "$(dirname "$0")/.."
tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT
failures=0

expect() {
  local want="$1" name="$2" message="$3" got=accept
  printf '%b\n' "$message" > "$tmp/msg"
  scripts/check-attribution.sh "$tmp/msg" 2> /dev/null || got=reject
  if [[ "$got" == "$want" ]]; then
    echo "ok: $name"
  else
    echo "FAIL: $name (wanted $want, got $got)"
    failures=$((failures + 1))
  fi
}

expect accept 'plain conventional commit' 'feat: add a thing\n\nBody text.'
expect reject 'co-author trailer' 'feat: add a thing\n\nCo-Authored-By: Claude <noreply@anthropic.com>'
expect reject 'co-author trailer, lower case' 'feat: add a thing\n\nco-authored-by: Someone <someone@example.com>'
expect reject 'session trailer' 'feat: add a thing\n\nClaude-Session: https://example.com/session'
expect reject 'generated-with footer' 'feat: add a thing\n\nGenerated with Claude Code'
expect reject 'generated-with footer, markdown link' 'feat: add a thing\n\nGenerated with [Claude Code](https://example.com)'

if [[ "$failures" -ne 0 ]]; then
  echo "$failures test(s) failed"
  exit 1
fi
echo "all hook tests passed"
