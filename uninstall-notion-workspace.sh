#!/usr/bin/env bash
set -euo pipefail

WORKSPACE="/root/.openclaw/workspace"
SKILL_DIR="$WORKSPACE/skills/notion-workspace"
ENV_FILE="${HOME}/.openclaw/credentials/notion-workspace.env"


echo "This will uninstall the Notion Workspace skill."
echo ""
echo "It will remove:"
echo "  $SKILL_DIR"
echo ""
if [[ -f "$ENV_FILE" ]]; then
  echo "Credentials file found:"
  echo "  $ENV_FILE"
  echo ""
fi

echo "Type yes to continue."
read -r confirm

if [[ "$confirm" != "yes" ]]; then
  echo "Aborted."
  exit 0
fi

if [[ -d "$SKILL_DIR" ]]; then
  rm -rf "$SKILL_DIR"
  echo "Removed skill directory: $SKILL_DIR"
else
  echo "Skill directory not found: $SKILL_DIR"
fi

if [[ -f "$ENV_FILE" ]]; then
  echo ""
  echo "Do you also want to delete the Notion credentials file?"
  echo "Type yes to delete it, or press Enter to keep it."
  read -r delete_creds
  if [[ "$delete_creds" == "yes" ]]; then
    rm -f "$ENV_FILE"
    echo "Removed credentials file: $ENV_FILE"
  else
    echo "Kept credentials file: $ENV_FILE"
  fi
fi

echo ""
echo "Notion Workspace skill uninstall complete."
