#!/usr/bin/env zsh
config_path=src/db/dbconfig.json
db=$(jq '.database' $config_path -r)

psql -d $db < $1
