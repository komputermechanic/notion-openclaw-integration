# Usage

## Helper script

`scripts/notion_api.py`

Run from the skill directory or use the full path:

`/root/.openclaw/workspace/skills/notion-workspace/scripts/notion_api.py`

## Commands

| Command | Description |
|---------|-------------|
| `notion_api.py me` | Verify the integration token and check workspace access |
| `notion_api.py search "query"` | Search for pages and databases the integration can access |
| `notion_api.py page <page-id>` | Read a page by ID |
| `notion_api.py page-blocks <page-id>` | Read the content blocks of a page |
| `notion_api.py database-query <database-id> '{...}'` | Query a database with optional JSON filters |
| `notion_api.py append-blocks <block-id> '<json>'` | Append content blocks to a page or block |
| `notion_api.py create-page <parent-page-id> <title> [json-children]` | Create a new page under a parent |

## Recommended workflow

1. Run `me` first to confirm the token works
2. Use `search` to find pages or databases when IDs are not known
3. Use `page` or `page-blocks` to read content before writing
4. Use `append-blocks` for adding content — avoid large destructive overwrites
5. Use `database-query` only when you already have the database ID

## Notes

- `search` returns up to 10 results by default
- `database-query` accepts an optional JSON filter in Notion API format
- `create-page` accepts optional JSON children blocks in Notion block format
