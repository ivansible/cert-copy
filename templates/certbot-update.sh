#!/bin/bash
LOG=/var/log/letsencrypt/letsencrypt.log

echo "$(date): start certbot update" >> $LOG

# run hook scripts
for script in /etc/letsencrypt/renewal-hooks/{pre,deploy,post}/*
do
    if [ -x $script ]; then
        echo "$(date): running $script"
        $script
    fi
done  >> $LOG 2>&1

# final message
echo "$(date): end certbot update" >> $LOG
