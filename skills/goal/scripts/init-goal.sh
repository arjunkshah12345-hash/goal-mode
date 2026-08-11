#!/usr/bin/env bash
# init-goal.sh <slug> "<title>"
set -euo pipefail

SLUG="${1:-}"
TITLE="${2:-}"
if [[ -z "$SLUG" || -z "$TITLE" ]]; then
  echo "Usage: init-goal.sh <slug> \"<title>\"" >&2
  exit 1
fi

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DEST="docs/goals/${SLUG}"
mkdir -p "${DEST}/notes"

sed -e "s/<Goal Title>/${TITLE//\//\\/}/g" -e "s/<slug>/${SLUG}/g" \
  "${ROOT}/templates/goal.md" > "${DEST}/goal.md"

sed -e "s/<Goal title>/${TITLE//\//\\/}/g" -e "s/<goal-slug>/${SLUG}/g" \
  "${ROOT}/templates/state.yaml" > "${DEST}/state.yaml"

echo "Created ${DEST}/"
echo "/goal Follow docs/goals/${SLUG}/goal.md."
