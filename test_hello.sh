#!/usr/bin/env bash
set -eo pipefail

title="Hello"

description="Print Hello"

body=$(
    cat <<'EOF'
#!/bin/bash
echo "hello!"
EOF
)

docpath="./$0.md"

./autotest.sh "$title" "$description" "$body" "$docpath"
