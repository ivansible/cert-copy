#!/bin/bash
#set -x

LOG="{{ certbot_log_file }}"
HOOKDIR="{{ certbot_hook_dir }}"

echo "$(date -Iseconds): start certbot update" | tee -a "$LOG"

# run hook scripts
for script in "$HOOKDIR"/{pre,deploy,post}/*
do
    if [[ -x $script ]]; then
        echo "$(date -Iseconds): running ${script}"
        "$script"
    fi
done  >> "$LOG" 2>&1

# final message
echo "$(date -Iseconds): end certbot update" | tee -a "$LOG"
