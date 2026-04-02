# OpenClaw Notion Integration

Created by **Komputer Mechanic**  
<https://komputermechanic.com/>

Connect a Notion workspace to OpenClaw through the official Notion API.

## Recommended setup

Do **not** paste your Notion secret into chat.

### Step 1: install the skill files

**Cautious path (recommended): download first, then run**

```bash
wget -O install-notion-workspace.sh https://raw.githubusercontent.com/komputermechanic/notion-openclaw-integration/main/install-notion-workspace.sh
bash install-notion-workspace.sh
```

**Fast path: stream directly to bash**

```bash
curl -fsSL https://raw.githubusercontent.com/komputermechanic/notion-openclaw-integration/main/install-notion-workspace.sh | bash
```

If an agent already installed the skill files for you, start at Step 2.

### Step 2: configure credentials securely in the terminal

**Cautious path (recommended): download first, then run**

```bash
wget -O configure-notion-credentials.sh https://raw.githubusercontent.com/komputermechanic/notion-openclaw-integration/main/configure-notion-credentials.sh
bash configure-notion-credentials.sh
```

**Fast path: stream directly to bash**

```bash
curl -fsSL https://raw.githubusercontent.com/komputermechanic/notion-openclaw-integration/main/configure-notion-credentials.sh | bash
```

### Step 3: give the final prompt to your OpenClaw agent

After setup, use the prompt printed by the installer/configuration flow.

## What each script does

### `install-notion-workspace.sh`
- installs the skill into `/root/.openclaw/workspace/skills/notion-workspace/`
- does not require the secret in chat
- can be used in agent-guided setup

### `configure-notion-credentials.sh`
- asks for the Notion secret in the terminal only
- stores it in `~/.openclaw/credentials/notion-workspace.env`
- verifies the Notion connection

## Verify manually

```bash
python3 /root/.openclaw/workspace/skills/notion-workspace/scripts/notion_api.py me
```

## Important Notion step

If pages or databases do not show up, share them with the Notion integration inside Notion.

## Common errors

### Missing `NOTION_API_KEY`
Run:

```bash
bash configure-notion-credentials.sh
```

### Notion page or database not found
The integration usually has not been shared to that resource yet.
