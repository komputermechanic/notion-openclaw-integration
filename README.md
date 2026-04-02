# OpenClaw Notion Integration

Created by **Komputer Mechanic**  
<https://komputermechanic.com/>

Connect a Notion workspace to OpenClaw through the official Notion API.

## Agent-assisted setup options

If you prefer, you can give this GitHub repo to your OpenClaw agent and let it guide the setup.

Repo URL:

```text
https://github.com/komputermechanic/notion-openclaw-integration
```

### Option 1: agent-guided install (recommended)

Prompt:

```text
Please help me install the Notion integration from this GitHub repo:
https://github.com/komputermechanic/notion-openclaw-integration

Install the skill files first. Do not ask me to paste my Notion secret into chat. Instead, tell me the exact terminal command I should run locally to configure my Notion credentials securely. After that, tell me the final prompt I should give you so you know Notion is configured in this workspace.
```

What to expect:
- the agent installs or guides installation of the skill files
- the agent tells you to run the credential setup locally in terminal
- you enter the secret in terminal, not chat
- the agent then tells you the final Notion-ready prompt

### Option 2: agent-guided full walkthrough

Prompt:

```text
Help me set up the Notion integration from this GitHub repo:
https://github.com/komputermechanic/notion-openclaw-integration

Guide me step by step. Do not ask me to paste my Notion secret into chat. If you need my secret, tell me the local terminal command to run instead.
```

What to expect:
- the agent explains the steps more conversationally
- the agent may ask you to run one or two terminal commands
- the agent should not ask for the secret in chat
- once setup is complete, the agent can start using the integration


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
