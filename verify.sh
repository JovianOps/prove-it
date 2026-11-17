#!/usr/bin/env bash
# prove-it helper: run a one-liner to prove an endpoint or import works.
# Usage:
#   verify.sh http GET  http://localhost:3000/health
#   verify.sh http POST http://localhost:3000/content '{"type":"x"}'
#   verify.sh node  "const m=require('./dist'); console.log(m.foo())"
#   verify.sh py    "import m; print(m.foo())"
set -euo pipefail
mode="${1:-}"; shift || true
case "$mode" in
  http)
    method="${1:-GET}"; url="${2:-}"; body="${3:-}"
    if [ -n "$body" ]; then
      curl -sS -X "$method" -H 'Content-Type: application/json' -d "$body" "$url"
    else
      curl -sS -X "$method" "$url"
    fi
    echo
    ;;
  node)
    node -e "$*"
    ;;
  py)
    python3 -c "$*"
    ;;
  *)
    echo "usage: verify.sh http METHOD URL [BODY] | node CODE | py CODE" >&2
    exit 2
    ;;
esac
