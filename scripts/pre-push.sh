#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
#
# pre-push hook: main only changes through pull requests, and every pushed
# commit must pass the authorship check.
set -euo pipefail

branch="$(git branch --show-current)"
if [[ "$branch" == "main" ]]; then
  echo "error: do not push to main, open a pull request from a feature/ or fix/ branch" >&2
  exit 1
fi

git fetch --quiet origin main
scripts/check-authorship.sh origin/main..HEAD
