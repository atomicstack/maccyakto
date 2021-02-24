#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$CURRENT_DIR/scripts/helpers.sh"
maccyakto_open="$CURRENT_DIR/scripts/open.sh"

maccyakto_key=$(get_option "@maccyakto_key")

if [[ ${maccyakto_key,,} != none ]]; then
    tmux bind-key ${maccyakto_key} run-shell "\"$maccyakto_open\" \"#{pane_id}\""
fi
