# Usage

Core helper script:

`scripts/notion_api.py`

Command examples:

- `scripts/notion_api.py me`
- `scripts/notion_api.py search "query"`
- `scripts/notion_api.py page <page-id>`
- `scripts/notion_api.py page-blocks <page-id>`
- `scripts/notion_api.py database-query <database-id> '{...}'`
- `scripts/notion_api.py append-blocks <block-id> '<json>'`
- `scripts/notion_api.py create-page <parent-page-id> <title> [json-children]`

Use search first when the page or database ID is not already known.
