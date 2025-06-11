#!/usr/bin/env bash

# Get the directory where the script lives
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# Define .env path next to the script
ENV_FILE="$SCRIPT_DIR/.env"
# Load .env file
if [[ -f .env ]]; then
	set -a
	source $ENV_FILE
	set +a
else
	printf "Error: Required .env file not found in $SCRIPT_DIR\n"
	exit 1
fi

printf "Server directory: %s\n"  $SERVER_DIR
printf "RCON Host: %s\n"  $RCON_HOST
printf "RCON Port: %s\n"  $RCON_PORT
printf "RCON Pass: %s\n"  $RCON_PASS
