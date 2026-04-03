# OpenClaw Notion Integration

Created by **Komputer Mechanic** — <https://komputermechanic.com/>

Connect a Notion workspace to OpenClaw through the official Notion API. Supports reading pages and databases, appending content, creating pages, and verifying access — all from within your OpenClaw agent.

---

## Installation

A single interactive script handles install, key updates, and uninstall:

```bash
wget -O setup-notion-workspace.sh https://raw.githubusercontent.com/komputermechanic/notion-openclaw-integration/main/setup-notion-workspace.sh && bash setup-notion-workspace.sh
```

---

## What the script does

On launch, the script shows a disclaimer then asks you to choose one of three actions:

| Option | Description |
|--------|-------------|
| **1) Install** | Fetch skill files from GitHub, collect your Notion API key, and verify the connection |
| **2) Update key** | Replace your Notion API key and re-verify — without reinstalling skill files |
| **3) Uninstall** | Remove the skill folder and optionally remove your API key |

---

## Install flow

1. If the skill is already installed, asks whether to reinstall the files
2. If a key already exists, asks whether to replace it
3. Collects your Notion secret **in the terminal only** — never in chat
4. Saves the key to `~/.openclaw/credentials/notion-workspace.env` with `chmod 600`
5. Verifies the connection against the Notion API
6. Prints a ready-to-paste message to send to your agent

---

## Update key flow

Use this when you have rotated your Notion secret or entered the wrong key during setup.

1. Checks the skill is installed before proceeding
2. Collects the new key in the terminal
3. Saves and verifies immediately
4. Prints the agent prompt on success

---

## Uninstall flow

1. Shows what will be removed before doing anything
2. Asks for confirmation
3. Removes the skill folder at `~/.openclaw/workspace/skills/notion-workspace/`
4. Asks separately whether to also remove the API key

---

## What gets configured

| Item | Location |
|------|----------|
| Skill files | `~/.openclaw/workspace/skills/notion-workspace/` |
| Notion API key | `~/.openclaw/credentials/notion-workspace.env` |

---

## What the agent can do

Once configured, your OpenClaw agent can:

| Command | Description |
|---------|-------------|
| `notion_api.py me` | Verify the integration token and check workspace access |
| `notion_api.py search "query"` | Search for pages and databases |
| `notion_api.py page <id>` | Read a page by ID |
| `notion_api.py page-blocks <id>` | Read the content blocks of a page |
| `notion_api.py database-query <id> '{...}'` | Query a database with optional filters |
| `notion_api.py append-blocks <id> '<json>'` | Append content blocks to a page |
| `notion_api.py create-page <parent-id> <title> [json]` | Create a new page |

---

## Important: share pages with your integration

If a page or database does not appear in search results, it has not been shared with the Notion integration yet. Open the page in Notion → click **...** → **Connections** → add your integration.

---

## Troubleshooting

| Error | Fix |
|-------|-----|
| `Missing NOTION_API_KEY` | Run the script and choose **Update key** |
| Verification failed | Check the key is correct and the integration is active in Notion |
| Page or database not found | Share it with the integration inside Notion |

---

## Requirements

- OpenClaw must be installed
- `wget` must be available
- `python3` and `requests` must be available (`pip install requests`)
