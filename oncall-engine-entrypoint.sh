#!/bin/bash
LOCK_FILE="/var/lib/oncall/db.migrate_lock"
SUCCESS_MESSAGE="Database migration succeeded"

# Loop until the lock file exists
while [ ! -e "$LOCK_FILE" ]; do
  echo "Waiting for the lock file ..."
  sleep 1
done

# Check if the content of the lock file is the success message
while [ "$(cat "$LOCK_FILE")" != "$SUCCESS_MESSAGE" ]; do
  echo "Waiting for the lock file content ..."
  sleep 1
done

# Start engine
uwsgi --ini uwsgi.ini
