# OpenClaw Notion Integration

Created by **Komputer Mechanic**  
<https://komputermechanic.com/>

Connect a Notion workspace to OpenClaw through the official Notion API.

## Quick install

```bash
wget -O install-notion-workspace.sh https://raw.githubusercontent.com/komputermechanic/notion-openclaw-integration/main/install-notion-workspace.sh
bash install-notion-workspace.sh
```

## What the installer does

- installs the skill into `/root/.openclaw/workspace/skills/notion-workspace/`
- asks for the Notion secret key
- stores credentials in `~/.openclaw/credentials/notion-workspace.env`
- verifies the connection
- prints the final prompt to give the OpenClaw agent

## Verify

```bash
python3 /root/.openclaw/workspace/skills/notion-workspace/scripts/notion_api.py me
```

## Important Notion step

If pages or databases do not show up, share them with the Notion integration inside Notion.

## Common errors

### Notion page or database not found
Usually the integration has not been shared to that resource yet.

### Missing NOTION_API_KEY
Make sure the installer completed and saved:

`~/.openclaw/credentials/notion-workspace.env`

## Manual fallback

If needed, copy the skill files into:

`/root/.openclaw/workspace/skills/notion-workspace/`

Then store the API key in:

`~/.openclaw/credentials/notion-workspace.env`
