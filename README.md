# Notion Workspace Skill for OpenClaw

Created by **Komputer Mechanic**  
Website: <https://komputermechanic.com/>

This skill lets an OpenClaw agent work with a connected Notion workspace.

It supports:
- searching Notion
- reading pages
- reading page blocks
- querying databases
- appending blocks
- creating pages

## Files in this package

- `SKILL.md` — skill instructions
- `scripts/notion_api.py` — the Notion API helper
- `install-notion-workspace.sh` — one-file installer
- `uninstall-notion-workspace.sh` — uninstall helper

## Install

Run:

```bash
bash install-notion-workspace.sh
```

The installer will:
- install the skill into `/root/.openclaw/workspace/skills/notion-workspace/`
- ask for the user's Notion secret key
- optionally ask for specific page IDs separated by commas
- save credentials to `~/.openclaw/credentials/notion-workspace.env`
- verify the Notion connection
- print a ready-to-copy prompt for the OpenClaw agent

## Optional page IDs

If the user already knows specific Notion page IDs they want the agent to use, they can paste them during installation.

- multiple page IDs should be separated with commas
- this step is optional
- pressing Enter skips it

If provided, they are stored in:

```text
/root/.openclaw/workspace/skills/notion-workspace/page_ids.txt
```

## After install

The installer prints a prompt the user can paste into OpenClaw so the agent knows:
- Notion is configured
- where the skill is installed
- where credentials are stored
- where optional page IDs are stored

## Uninstall

Run:

```bash
bash uninstall-notion-workspace.sh
```

The uninstall script asks for explicit `yes` before proceeding.

## Credentials

The Notion integration secret is stored at:

```text
~/.openclaw/credentials/notion-workspace.env
```

Format:

```text
NOTION_API_KEY=your_secret_here
```

## Safety notes

- This skill only uses the Notion API.
- It does not require browser automation.
- If a page or database does not appear in search, the Notion integration likely has not been shared to that resource yet.
- Users should protect their Notion secret key and rotate it if it was exposed.
