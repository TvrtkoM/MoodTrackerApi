#!/usr/bin/env zsh
db=$(jq '.database' src/db/dbconfig.json -r)
filepath="${0:a:h}/../sql/create_db.pgsql"
pg_dump -s -c --quote-all-identifiers --if-exists $db > $filepath
