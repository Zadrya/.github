#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-3.0-or-later
#
# Fails if a tracked text file contains the em dash (U+2014).
# Project style uses commas, colons or parentheses instead.
set -euo pipefail

em_dash="$(printf '\xe2\x80\x94')"

if git grep -nI "$em_dash" -- . ':!LICENSE' ':!LICENSES' ':!CODE_OF_CONDUCT.md'; then
  echo "error: em dash (U+2014) found, use a comma, a colon or parentheses" >&2
  exit 1
fi
