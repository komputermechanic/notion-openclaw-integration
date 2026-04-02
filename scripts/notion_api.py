#!/usr/bin/env python3
import json
import os
import sys
from pathlib import Path

import requests

API_BASE = "https://api.notion.com/v1"
API_VERSION = "2022-06-28"
ENV_FILE = Path.home() / ".openclaw" / "credentials" / "notion-workspace.env"


def load_env_file(path: Path) -> None:
    if not path.exists():
        return
    for raw in path.read_text().splitlines():
        line = raw.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, value = line.split("=", 1)
        key = key.strip()
        value = value.strip().strip('"').strip("'")
        os.environ.setdefault(key, value)


def notion_token() -> str:
    load_env_file(ENV_FILE)
    token = os.environ.get("NOTION_API_KEY") or os.environ.get("NOTION_TOKEN")
    if not token:
        print(json.dumps({
            "ok": False,
            "error": f"Missing NOTION_API_KEY. Expected it in env or {ENV_FILE}"
        }, indent=2))
        sys.exit(2)
    return token


def headers() -> dict:
    return {
        "Authorization": f"Bearer {notion_token()}",
        "Notion-Version": API_VERSION,
        "Content-Type": "application/json",
    }


def request(method: str, path: str, payload=None, params=None):
    url = f"{API_BASE}{path}"
    resp = requests.request(method, url, headers=headers(), json=payload, params=params, timeout=30)
    try:
        data = resp.json()
    except Exception:
        data = {"status": resp.status_code, "text": resp.text}
    if not resp.ok:
        print(json.dumps({"ok": False, "status": resp.status_code, "response": data}, indent=2))
        sys.exit(1)
    print(json.dumps({"ok": True, "status": resp.status_code, "response": data}, indent=2))


def main():
    if len(sys.argv) < 2:
        print("Usage: notion_api.py <me|search|page|database-query|append-blocks|create-page|page-blocks> [args...]", file=sys.stderr)
        sys.exit(2)

    cmd = sys.argv[1]

    if cmd == "me":
        request("GET", "/users/me")
        return

    if cmd == "search":
        query = sys.argv[2] if len(sys.argv) > 2 else ""
        payload = {"query": query, "page_size": 10}
        request("POST", "/search", payload=payload)
        return

    if cmd == "page":
        if len(sys.argv) < 3:
            print("Usage: notion_api.py page <page-id>", file=sys.stderr)
            sys.exit(2)
        request("GET", f"/pages/{sys.argv[2]}")
        return

    if cmd == "page-blocks":
        if len(sys.argv) < 3:
            print("Usage: notion_api.py page-blocks <page-id>", file=sys.stderr)
            sys.exit(2)
        request("GET", f"/blocks/{sys.argv[2]}/children")
        return

    if cmd == "database-query":
        if len(sys.argv) < 3:
            print("Usage: notion_api.py database-query <database-id> [json-filter]", file=sys.stderr)
            sys.exit(2)
        payload = json.loads(sys.argv[3]) if len(sys.argv) > 3 else {}
        request("POST", f"/databases/{sys.argv[2]}/query", payload=payload)
        return

    if cmd == "append-blocks":
        if len(sys.argv) < 4:
            print("Usage: notion_api.py append-blocks <block-id> <json-children>", file=sys.stderr)
            sys.exit(2)
        payload = {"children": json.loads(sys.argv[3])}
        request("PATCH", f"/blocks/{sys.argv[2]}/children", payload=payload)
        return

    if cmd == "create-page":
        if len(sys.argv) < 4:
            print("Usage: notion_api.py create-page <parent-page-id> <title> [json-children]", file=sys.stderr)
            sys.exit(2)
        parent_id = sys.argv[2]
        title = sys.argv[3]
        children = json.loads(sys.argv[4]) if len(sys.argv) > 4 else []
        payload = {
            "parent": {"type": "page_id", "page_id": parent_id},
            "properties": {
                "title": {
                    "title": [
                        {
                            "type": "text",
                            "text": {"content": title}
                        }
                    ]
                }
            },
            "children": children,
        }
        request("POST", "/pages", payload=payload)
        return

    print(f"Unknown command: {cmd}", file=sys.stderr)
    sys.exit(2)


if __name__ == "__main__":
    main()
