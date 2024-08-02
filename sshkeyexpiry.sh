#!/bin/bash

# Define the public key path
PUB_KEY_PATH="$HOME/.ssh/id_rsa.pub"

# Check if the public key file exists
if [ ! -f "$PUB_KEY_PATH" ]; then
    echo "Public key file not found at $PUB_KEY_PATH"
    exit 1
fi

# Calculate the expiry time 90 days from now in the format YYYYMMDDHHMMSSZ
EXPIRY_TIME=$(date -u -d "90 days" +"%Y%m%d%H%M%SZ")

# Read the public key content
PUBLIC_KEY_CONTENT=$(cat "$PUB_KEY_PATH")

# Define the full entry with the expiry time
FULL_ENTRY="expiry-time=\"$EXPIRY_TIME\" $PUBLIC_KEY_CONTENT"

# Define the authorized_keys file path
AUTHORIZED_KEYS_FILE="$HOME/.ssh/authorized_keys"
BACKUP_FILE="$HOME/.ssh/authorized_keys.bak"

# Backup the current authorized_keys file if it exists
if [ -f "$AUTHORIZED_KEYS_FILE" ]; then
    mv "$AUTHORIZED_KEYS_FILE" "$BACKUP_FILE"
    echo "Existing authorized_keys file renamed to authorized_keys.bak."
fi

# Add the new key with the expiry command
echo "$FULL_ENTRY" > "$AUTHORIZED_KEYS_FILE"
echo "The key has been added to the authorized_keys file with an expiry time of $EXPIRY_TIME."
