# OpenClaw Notion Integration

Created by **Komputer Mechanic**  
<https://komputermechanic.com/>

Connect a Notion workspace to OpenClaw through the official Notion API.

## Recommended install

Do **not** paste your Notion secret into chat.

Best path: save the secret locally in your terminal first, then run the installer.

### Step 1: save your Notion key locally in the terminal

```bash
mkdir -p ~/.openclaw/credentials
printf 'NOTION_API_KEY=your_secret_here
' > ~/.openclaw/credentials/notion-workspace.env
chmod 600 ~/.openclaw/credentials/notion-workspace.env
```

### Step 2: run the installer

```bash
wget -O install-notion-workspace.sh https://raw.githubusercontent.com/komputermechanic/notion-openclaw-integration/main/install-notion-workspace.sh
bash install-notion-workspace.sh
```

## What the installer does

- installs the skill into `/root/.openclaw/workspace/skills/notion-workspace/`
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

## Safe agent prompt

If you want an OpenClaw agent to help, give it this kind of instruction:

```text
Help me install and configure the Notion integration from this GitHub repo:
https://github.com/komputermechanic/notion-openclaw-integration

Do not ask me to paste my Notion secret into chat. Instead, tell me the exact terminal commands to run locally, and I will enter the secret in the terminal only. After that, tell me the final prompt I should give you so you know Notion is configured in this workspace.
```

## After installation

After the installer finishes, it prints the prompt you should give your OpenClaw agent so it knows the Notion integration is available in your workspace.

You usually do **not** need the agent to perform the installation itself.
