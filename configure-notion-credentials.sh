#!/usr/bin/env bash
set -euo pipefail

ENV_DIR="${HOME}/.openclaw/credentials"
ENV_FILE="$ENV_DIR/notion-workspace.env"
SKILL_DIR="/root/.openclaw/workspace/skills/notion-workspace"

mkdir -p "$ENV_DIR"

if [[ ! -f "$SKILL_DIR/scripts/notion_api.py" ]]; then
  echo "Notion skill files were not found yet."
  echo "Run install-notion-workspace.sh first, then run this script."
  exit 1
fi

echo "Configure Notion credentials"
echo ""
echo "This stores your Notion API key at:"
echo "  $ENV_FILE"
echo ""
echo "Do not paste your Notion secret into chat. Paste it here in the terminal only."
echo ""

read -r -s -p "Paste your Notion secret key: " NOTION_KEY
echo ""

if [[ -z "$NOTION_KEY" ]]; then
  echo "No key entered. Aborting."
  exit 1
fi

printf 'NOTION_API_KEY=%s\n' "$NOTION_KEY" > "$ENV_FILE"
chmod 600 "$ENV_FILE"

echo ""
echo "Saved credentials to:"
echo "  $ENV_FILE"

echo "Verifying access..."
python3 "$SKILL_DIR/scripts/notion_api.py" me

echo ""
echo "Credentials configured successfully."
