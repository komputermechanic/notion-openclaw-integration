---
name: notion-workspace
description: Access a connected Notion workspace through the official Notion API. Use when the user wants to read from or write to Notion, search pages or databases, append content, create pages, or verify workspace access from an OpenClaw workspace.
---

# Notion Workspace

Created by **Komputer Mechanic** — <https://komputermechanic.com/>

Use the bundled helper script for all Notion API interactions.

## Core workflow

1. Verify access with `scripts/notion_api.py me`
2. Discover targets with `scripts/notion_api.py search "query"` when IDs are unknown
3. Read before writing
4. Keep writes small and explicit — prefer appending over large rewrites
5. If a page or database is missing from search, tell the user it needs to be shared with the integration in Notion

## Commands

| Command | Description |
|---------|-------------|
| `scripts/notion_api.py me` | Verify token and workspace access |
| `scripts/notion_api.py search "query"` | Search pages and databases |
| `scripts/notion_api.py page <page-id>` | Read a page by ID |
| `scripts/notion_api.py page-blocks <page-id>` | Read a page's content blocks |
| `scripts/notion_api.py database-query <database-id> '{...}'` | Query a database |
| `scripts/notion_api.py append-blocks <block-id> '<json>'` | Append content blocks |
| `scripts/notion_api.py create-page <parent-id> <title> [json]` | Create a new page |

## Credential handling

- Token is stored at `~/.openclaw/credentials/notion-workspace.env` as `NOTION_API_KEY=...`
- Do not ask the user to paste the Notion secret into chat
- Do not print the token back to the user
- If a secret appeared in chat, treat it as exposed and recommend rotation

## References

- `references/install.md` — installation paths and storage locations
- `references/usage.md` — command examples
- `references/security.md` — security notes
