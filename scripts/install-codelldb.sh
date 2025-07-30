#!/bin/bash

set -e

# Config
TARGET_DIR="$HOME/dotfiles/deps"
VSIX_URL="https://github.com/vadimcn/codelldb/releases/download/v1.11.5/codelldb-darwin-arm64.vsix"
VSIX_FILE="codelldb.vsix"
EXTRACT_DIR="codelldb"

# Download the .vsix file
wget "$VSIX_URL" -O "$VSIX_FILE"

# Extract contents
mkdir -p "$TARGET_DIR"
unzip "$VSIX_FILE" -d "$TARGET_DIR/$EXTRACT_DIR"
rm "$VSIX_FILE"

# Locate and copy the codelldb binary
CODELLDB_BIN="$TARGET_DIR/$EXTRACT_DIR/extension/adapter/codelldb"

if [ ! -f "$CODELLDB_BIN" ]; then
	echo "codelldb binary not found at $CODELLDB_BIN"
	exit 1
fi

chmod +x "$CODELLDB_BIN"

sudo ln -sf "$CODELLDB_BIN" /usr/local/bin/codelldb

echo "codelldb installed to $TARGET_DIR/$EXTRACT_DIR and symlinked to /usr/local/bin"

exec zsh
