#!/usr/bin/env zsh
db=$(jq '.database' src/db/dbconfig.json -r)
psql $db < $1
