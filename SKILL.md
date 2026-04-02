---
name: notion-workspace
description: Access a connected Notion workspace through the Notion API for search, page lookup, page block reads, simple database queries, page creation, and explicit block appends. Use when the user wants to read from or write to Notion, inspect workspace access, find a page or database, work with a known page ID, or update an existing Notion page from this OpenClaw workspace.
---

# Notion Workspace

Created by **Komputer Mechanic**  
Website: <https://komputermechanic.com/>

Use the bundled script for deterministic Notion API access.

## Core workflow

1. Verify access with `scripts/notion_api.py me`.
2. Discover targets with `scripts/notion_api.py search "query"` when IDs are not known.
3. Read before writing.
4. Keep writes small and explicit.
5. Tell the user when a Notion page or database is missing because the integration has not been shared to it yet.

## Commands

- `scripts/notion_api.py me`
- `scripts/notion_api.py search "query"`
- `scripts/notion_api.py page <page-id>`
- `scripts/notion_api.py page-blocks <page-id>`
- `scripts/notion_api.py database-query <database-id> '{...}'`
- `scripts/notion_api.py append-blocks <block-id> '<json>'`
- `scripts/notion_api.py create-page <parent-page-id> <title> [json-children]`

## Credential handling

- Expect the token in `~/.openclaw/credentials/notion-workspace.env` as `NOTION_API_KEY=...`.
- Do not print the token back to the user.
- Treat pasted Notion secrets as exposed and recommend rotation if they appeared in chat logs.

## Additional references

- Read `references/install.md` for installation and storage paths.
- Read `references/usage.md` for examples.
- Read `references/security.md` for safety notes.
