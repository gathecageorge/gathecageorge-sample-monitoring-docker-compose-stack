#!/bin/bash
LOCK_FILE="/var/lib/oncall/db.migrate_lock"
rm -f "$LOCK_FILE"

# migrate database
if python manage.py migrate --noinput; then
  echo "Database migration succeeded" > "$LOCK_FILE"

  # Start celery
  ./celery_with_exporter.sh
else
  echo "Database migration failed"

  # remove lock file
  rm -f "$LOCK_FILE"
fi
