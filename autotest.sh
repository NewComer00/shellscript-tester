#!/usr/bin/env bash
set -euo pipefail

_TEST_GEN_DOC=""

test_title() {
    local title="$1"
    if [[ -z "$_TEST_GEN_DOC" ]]; then
        echo "$title"
    else
        echo $'# '"$title"$'\n' > "$_TEST_GEN_DOC"
    fi
}

test_description() {
    local desc="$1"
    if [[ -z "$_TEST_GEN_DOC" ]]; then
        echo "$desc"
    else
        echo $'## Description\n' >> "$_TEST_GEN_DOC"
        echo "$desc"$'\n' >> "$_TEST_GEN_DOC"
    fi
}

test_log=""
test_body() {
    local body="$1"
    if [[ -z "$_TEST_GEN_DOC" ]]; then
        test_log=$(eval "$body" | tee /dev/tty)
    else
        echo $'## Test Script\n' >> "$_TEST_GEN_DOC"
        echo $'```sh\n'"$body"$'\n```\n' >> "$_TEST_GEN_DOC"
        echo $'## Test Result\n' >> "$_TEST_GEN_DOC"
        echo $'```sh\n'"$test_log"$'\n```\n' >> "$_TEST_GEN_DOC"
    fi
}


run_test() {
    test_title "$1"
    test_description "$2"
    test_body "$3"
}

run_test "$1" "$2" "$3"
_TEST_GEN_DOC="$4"
run_test "$1" "$2" "$3"
