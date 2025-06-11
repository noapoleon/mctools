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
	printf "Error: Required .env file not found in $SCRIPT_DIR\n" >&2
	exit 1
fi

# Check Server dir
if [[ -z "$SERVER_DIR" ]]; then
	printf "Error: SERVER_DIR is not defined in .env\n" >&2
	exit 1
elif [[ ! -d $SERVER_DIR ]]; then
	printf "Error: SERVER_DIR '$SERVER_DIR' does not exist or is not a directory\n" >&2
	exit 1
fi
# Get whitelist file
WHITELIST_FILE="$SERVER_DIR/whitelist.json"
if [[ ! -f "$WHITELIST_FILE" ]]; then
	printf "[]\n" > "$WHITELIST_FILE"
fi

wl_print_usage() {
		printf "Usage: $0 add <username>\n"
		printf "       $0 remove <username>\n"
}

# Query Minecraft API for uuid from name
wl_get_user_info() {
	USERNAME="$1"
	if [[ -z "$USERNAME" ]]; then
		wl_print_usage
		exit 1
	fi

	# Query Minecraft API
	RESPONSE=$(curl -s "https://api.minecraftservices.com/minecraft/profile/lookup/name/$USERNAME")
	# Check if the response is valid
	UUID=$(printf "$RESPONSE" | jq -r '.id // empty')
	NAME=$(printf "$RESPONSE" | jq -r '.name // empty')
	if [[ -z "$UUID" || -z "$NAME" ]]; then
		printf "Error: Invalid response from Mojang API. User may not exist or request failed\n" >&2
		printf "       Raw response:\n$RESPONSE\n" >&2
		exit 1
	fi
	# Format UUID properly (with dashes)
	UUID="$(printf "$UUID" | sed -E 's/^(.{8})(.{4})(.{4})(.{4})(.{12})/\1-\2-\3-\4-\5/')"
}

# Handle subcommands
case "$1" in
	add)
		wl_get_user_info "$2"

		# Add/Update user in whitelist
		TMP_FILE=$(mktemp)
		jq --arg uuid "$UUID" --arg name "$NAME" \
			'(map(select(.uuid != $uuid)) + [{"uuid": $uuid, "name": $name}])' \
			"$WHITELIST_FILE" > "$TMP_FILE" && mv "$TMP_FILE" "$WHITELIST_FILE"
		;;
	remove)
		wl_get_user_info "$2"

		# Remove user in whitelist
		TMP_FILE=$(mktemp)
		jq --arg uuid "$UUID" \
			'(map(select(.uuid != $uuid)))' \
			"$WHITELIST_FILE" > "$TMP_FILE" && mv "$TMP_FILE" "$WHITELIST_FILE"
		;;
	*)
		printf "Error: Only 'add' and 'remove' are implemented for now\n"
		exit 1
		;;
esac




