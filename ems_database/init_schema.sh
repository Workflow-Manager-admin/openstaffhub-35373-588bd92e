#!/bin/bash

# This script will initialize the EMS database schema if not present

SCHEMA_FILE="schema.sql"
DB_NAME="myapp"
DB_USER="appuser"
DB_PASSWORD="dbuser123"
DB_PORT="5000"

if [ ! -f "$SCHEMA_FILE" ]; then
    echo "No schema.sql found in $(pwd). Initialization aborted."
    exit 1
fi

echo "Initializing $DB_NAME schema from $SCHEMA_FILE..."

PGPASSWORD=$DB_PASSWORD psql -h localhost -U $DB_USER -d $DB_NAME -p $DB_PORT -f "$SCHEMA_FILE"

RC=$?
if [ $RC -eq 0 ]; then
    echo "Database schema initialized successfully!"
else
    echo "Schema initialization failed with code $RC."
fi
