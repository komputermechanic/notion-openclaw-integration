#!/bin/bash

# ============================================
# OpenClaw Notion Integration Setup Script
# By Komputer Mechanic
# ============================================

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

SKILL_DIR="$HOME/.openclaw/workspace/skills/notion-workspace"
CREDENTIALS_DIR="$HOME/.openclaw/credentials"
ENV_FILE="$CREDENTIALS_DIR/notion-workspace.env"
REPO_RAW="https://raw.githubusercontent.com/komputermechanic/notion-openclaw-integration/main"

echo ""
echo -e "${CYAN}============================================${NC}"
echo -e "${CYAN}  OpenClaw Notion Integration Setup${NC}"
echo -e "${CYAN}  By Komputer Mechanic${NC}"
echo -e "${CYAN}============================================${NC}"
echo ""
echo -e "${YELLOW}Disclaimer:${NC}"
echo "Use this setup script at your own risk."
echo "Komputer Mechanic is not liable for mistakes, misconfiguration,"
echo "downtime, or any errors caused by using this script."
echo "For help and tutorials, visit: https://komputermechanic.com/"
echo ""
read -p "Do you want to proceed? (y/n): " PROCEED_SETUP
echo ""
if [ "$PROCEED_SETUP" != "y" ]; then
  echo -e "${YELLOW}Setup cancelled.${NC}"
  exit 0
fi

# ============================================
# WHAT DO YOU WANT TO DO?
# ============================================
echo -e "${BOLD}What do you want to do?${NC}"
echo ""
echo "  1) Install        — Set up Notion integration from scratch"
echo "  2) Update key     — Replace your Notion API key and re-verify"
echo "  3) Uninstall      — Remove Notion integration from OpenClaw"
echo ""
read -p "Enter 1, 2 or 3: " ACTION_CHOICE
echo ""

if [ "$ACTION_CHOICE" != "1" ] && [ "$ACTION_CHOICE" != "2" ] && [ "$ACTION_CHOICE" != "3" ]; then
  echo -e "${RED}❌ Invalid choice. Exiting.${NC}"
  exit 1
fi

# ============================================
# SHARED FUNCTIONS
# ============================================
print_agent_prompt() {
  echo -e "${CYAN}============================================${NC}"
  echo -e "${CYAN}  Copy and send this to your agent:${NC}"
  echo -e "${CYAN}============================================${NC}"
  echo ""
  echo "Notion is configured in this workspace."
  echo ""
  echo "The Notion skill is located at:"
  echo "  $SKILL_DIR"
  echo ""
  echo "Credentials are stored at:"
  echo "  $ENV_FILE"
  echo ""
  echo "When I ask you to read from or write to Notion, use this skill and its helper script."
  echo ""
  echo "Main helper script:"
  echo "  $SKILL_DIR/scripts/notion_api.py"
  echo ""
  echo -e "${CYAN}============================================${NC}"
  echo ""
}

collect_api_key() {
  echo "Do not paste your Notion secret into chat. Enter it here in the terminal only."
  echo ""
  read -r -s -p "Paste your Notion secret key: " NOTION_KEY
  echo ""
  echo ""

  if [ -z "$NOTION_KEY" ]; then
    echo -e "${RED}❌ No key entered. Exiting.${NC}"
    exit 1
  fi

  mkdir -p "$CREDENTIALS_DIR"
  printf 'NOTION_API_KEY=%s\n' "$NOTION_KEY" > "$ENV_FILE"
  chmod 600 "$ENV_FILE"
  echo -e "${GREEN}✅ Credentials saved${NC}"
  echo ""
}

verify_connection() {
  echo -e "${YELLOW}Verifying Notion connection...${NC}"
  if ! python3 "$SKILL_DIR/scripts/notion_api.py" me > /dev/null 2>&1; then
    echo -e "${RED}❌ Verification failed. Check that your key is correct, your Notion integration is active, and you have network access.${NC}"
    exit 1
  fi
  echo -e "${GREEN}✅ Connection verified${NC}"
  echo ""
}

fetch_skill_files() {
  echo -e "${YELLOW}Fetching skill files from GitHub...${NC}"
  mkdir -p "$SKILL_DIR/scripts"

  if ! wget -q -O "$SKILL_DIR/SKILL.md" "$REPO_RAW/SKILL.md"; then
    echo -e "${RED}❌ Failed to download SKILL.md. Check your internet connection.${NC}"
    exit 1
  fi
  echo -e "${GREEN}✅ SKILL.md${NC}"

  if ! wget -q -O "$SKILL_DIR/scripts/notion_api.py" "$REPO_RAW/scripts/notion_api.py"; then
    echo -e "${RED}❌ Failed to download notion_api.py. Check your internet connection.${NC}"
    exit 1
  fi
  chmod +x "$SKILL_DIR/scripts/notion_api.py"
  echo -e "${GREEN}✅ scripts/notion_api.py${NC}"
  echo ""
}

# ============================================
# INSTALL FLOW
# ============================================
if [ "$ACTION_CHOICE" = "1" ]; then

  if [ -d "$SKILL_DIR" ]; then
    echo -e "${YELLOW}⚠️  Notion skill is already installed at $SKILL_DIR${NC}"
    read -p "Reinstall skill files? (y/n): " REINSTALL
    echo ""
    if [ "$REINSTALL" = "y" ]; then
      fetch_skill_files
    else
      echo "Keeping existing skill files."
      echo ""
    fi
  else
    fetch_skill_files
  fi

  if [ -f "$ENV_FILE" ]; then
    echo -e "${YELLOW}⚠️  An existing Notion API key was found.${NC}"
    read -p "Do you want to replace it? (y/n): " REPLACE_KEY
    echo ""
    if [ "$REPLACE_KEY" = "y" ]; then
      collect_api_key
    else
      echo "Keeping existing key."
      echo ""
    fi
  else
    collect_api_key
  fi

  verify_connection

  echo -e "${GREEN}============================================${NC}"
  echo -e "${GREEN}  Installation complete!${NC}"
  echo -e "${GREEN}============================================${NC}"
  echo ""
  print_agent_prompt
  exit 0
fi

# ============================================
# UPDATE KEY FLOW
# ============================================
if [ "$ACTION_CHOICE" = "2" ]; then

  if [ ! -f "$SKILL_DIR/scripts/notion_api.py" ]; then
    echo -e "${RED}❌ Notion skill is not installed yet.${NC}"
    echo "Run this script again and choose option 1 to install first."
    exit 1
  fi

  echo -e "${BOLD}Replacing Notion API key...${NC}"
  echo ""
  collect_api_key
  verify_connection

  echo -e "${GREEN}============================================${NC}"
  echo -e "${GREEN}  API key updated successfully!${NC}"
  echo -e "${GREEN}============================================${NC}"
  echo ""
  print_agent_prompt
  exit 0
fi

# ============================================
# UNINSTALL FLOW
# ============================================
if [ "$ACTION_CHOICE" = "3" ]; then

  echo -e "${YELLOW}This will remove:${NC}"
  echo "  - Notion skill folder at $SKILL_DIR"
  if [ -f "$ENV_FILE" ]; then
    echo "  - Optionally your Notion API key at $ENV_FILE"
  fi
  echo ""
  read -p "Are you sure you want to uninstall? (y/n): " CONFIRM_UNINSTALL
  echo ""
  if [ "$CONFIRM_UNINSTALL" != "y" ]; then
    echo -e "${YELLOW}Uninstall cancelled.${NC}"
    exit 0
  fi

  if [ -d "$SKILL_DIR" ]; then
    rm -rf "$SKILL_DIR"
    echo -e "${GREEN}✅ Removed skill folder${NC}"
  else
    echo -e "${YELLOW}⚠️  Skill folder not found — skipping${NC}"
  fi

  if [ -f "$ENV_FILE" ]; then
    echo ""
    read -p "Do you also want to remove your Notion API key? (y/n): " REMOVE_KEY
    echo ""
    if [ "$REMOVE_KEY" = "y" ]; then
      rm -f "$ENV_FILE"
      echo -e "${GREEN}✅ Removed API key${NC}"
    else
      echo "Kept credentials at $ENV_FILE"
    fi
  fi

  echo ""
  echo -e "${GREEN}============================================${NC}"
  echo -e "${GREEN}  Uninstall complete!${NC}"
  echo -e "${GREEN}============================================${NC}"
  echo ""
  echo "The Notion integration has been removed from your OpenClaw setup."
  echo "Run this script again anytime to reinstall."
  echo ""
  exit 0
fi
