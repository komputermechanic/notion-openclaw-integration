# Installation

## Script

```bash
wget -O setup-notion-workspace.sh https://raw.githubusercontent.com/komputermechanic/notion-openclaw-integration/main/setup-notion-workspace.sh && bash setup-notion-workspace.sh
```

The script is interactive. Choose from:
- **1) Install** — fetch skill files, collect API key, verify
- **2) Update key** — replace key and re-verify
- **3) Uninstall** — remove skill and optionally remove credentials

## Skill location

`~/.openclaw/workspace/skills/notion-workspace/`

## Credentials location

`~/.openclaw/credentials/notion-workspace.env`

Format:

```text
NOTION_API_KEY=your_secret_here
```

The credentials file is created with `chmod 600` — readable only by the current user.

## Notes

- Do not ask the user to paste their Notion secret into chat — the script handles this securely in the terminal
- If asked where the integration is stored, point to the skill directory and credentials file above
- All paths use `$HOME` — works for any user, not just root
