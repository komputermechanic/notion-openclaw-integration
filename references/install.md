# Installation

## Skill location

`/root/.openclaw/workspace/skills/notion-workspace/`

## Credentials location

`~/.openclaw/credentials/notion-workspace.env`

Format:

```text
NOTION_API_KEY=your_secret_here
```

The credentials file is created with `chmod 600` — readable only by the current user.

## Setup scripts

**Step 1 — Install skill files:**

```bash
wget -O install-notion-workspace.sh https://raw.githubusercontent.com/komputermechanic/notion-openclaw-integration/main/install-notion-workspace.sh && bash install-notion-workspace.sh
```

**Step 2 — Configure credentials:**

```bash
wget -O configure-notion-credentials.sh https://raw.githubusercontent.com/komputermechanic/notion-openclaw-integration/main/configure-notion-credentials.sh && bash configure-notion-credentials.sh
```

**Uninstall:**

```bash
wget -O uninstall-notion-workspace.sh https://raw.githubusercontent.com/komputermechanic/notion-openclaw-integration/main/uninstall-notion-workspace.sh && bash uninstall-notion-workspace.sh
```

## Notes

- Do not ask the user to paste their Notion secret into chat — always direct them to run the credential script in the terminal
- If asked where the integration is stored, point to the skill directory and credentials file above
