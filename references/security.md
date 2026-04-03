# Security Notes

## API key handling

- Never ask the user to paste their Notion secret into chat
- Always direct credential entry to the terminal via `configure-notion-credentials.sh`
- Do not print the token back to the user in any response
- The credentials file is stored with `chmod 600` — readable only by the current user

## Exposed secrets

- If a Notion secret appeared in chat logs, treat it as compromised
- Recommend rotating the key immediately in Notion under **Settings → Connections → My integrations**
- After rotation, re-run `configure-notion-credentials.sh` with the new secret

## API usage

- Use the official Notion API only (`https://api.notion.com/v1`)
- Keep write operations small and explicit — prefer appending blocks over destructive rewrites
- Always read before writing to confirm you are targeting the correct page or database

## Access issues

- If a page or database does not appear in search results, the Notion integration has not been shared to it yet
- Direct the user to open the page in Notion → click **...** → **Connections** → add the integration
