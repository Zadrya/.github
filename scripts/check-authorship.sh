#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Fails if any commit in a range is not authored and committed by Sklyvan,
# or if its message carries AI attribution lines.
# Usage: scripts/check-authorship.sh [<range>]   (default: origin/main..HEAD)
set -euo pipefail

range="${1:-origin/main..HEAD}"
allowed_name='Sklyvan'
allowed_emails='joangraciataribo@gmail.com 37016233+Sklyvan@users.noreply.github.com'
pattern='co-authored-by:|claude-session:|generated with \[?claude code'

email_allowed() {
  local candidate
  for candidate in $allowed_emails; do
    [[ "$1" == "$candidate" ]] && return 0
  done
  return 1
}

failed=0
count=0
while read -r sha; do
  [[ -z "$sha" ]] && continue
  count=$((count + 1))
  short="${sha:0:9}"
  for role in a c; do
    name="$(git show -s --format="%${role}n" "$sha")"
    email="$(git show -s --format="%${role}e" "$sha")"
    if [[ "$name" != "$allowed_name" ]] || ! email_allowed "$email"; then
      [[ "$role" == a ]] && label=author || label=committer
      echo "error: $short has $label '$name <$email>', expected $allowed_name" >&2
      failed=1
    fi
  done
  if git show -s --format=%B "$sha" | grep -Eiq "$pattern"; then
    echo "error: $short carries a forbidden attribution line:" >&2
    git show -s --format=%B "$sha" | grep -Ei "$pattern" >&2
    failed=1
  fi
done < <(git rev-list "$range")

if [[ "$failed" -ne 0 ]]; then
  echo "authorship check failed for $range" >&2
  exit 1
fi
echo "authorship check passed: $count commit(s) in $range"
