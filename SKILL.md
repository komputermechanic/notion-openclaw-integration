---
name: notion-workspace
description: Access a connected Notion workspace through the Notion API for search, page lookup, simple database queries, and appending blocks. Use when the user wants to read from or write to Notion, inspect workspace access, find a page/database, or update an existing Notion page from this OpenClaw workspace.
---

Created by **Komputer Mechanic**  
Website: <https://komputermechanic.com/>

# Notion Workspace

Use the bundled script for deterministic Notion API access.

## Quick start

- Use `scripts/notion_api.py me` to verify the integration token works.
- Use `scripts/notion_api.py search "query"` to find pages and databases the integration can access.
- Use `scripts/notion_api.py page <page-id>` to inspect a page.
- Use `scripts/notion_api.py database-query <database-id> '[...]'` only when you already know the database id and need structured results.
- Use `scripts/notion_api.py append-blocks <block-id> '<json>'` for small, explicit content appends.

Run commands from this skill directory or use the full script path.

## Credential handling

- Expect the token in `~/.openclaw/credentials/notion-workspace.env` as `NOTION_API_KEY=...`.
- Do not print the token back to the user.
- If the user pasted the token in chat, treat it as exposed and recommend rotating it after setup.

## Workflow

1. Verify access with `me`.
2. Discover targets with `search`.
3. Read before writing.
4. For writes, keep operations small and explicit.
5. Show the user what succeeded and what still needs Notion-side sharing permissions, if any.

## Writing guidance

- Prefer appending blocks to an existing page over large destructive rewrites.
- If a page or database is missing from search results, the integration usually has not been shared to that resource in Notion yet.
- When the user asks for broad sync behavior, explain that this skill currently provides direct API operations, not a full background sync engine.
