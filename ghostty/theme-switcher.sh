#!/bin/zsh

set -e

CUSTOM_DIR="$HOME/.config/ghostty/themes/custom"
SYSTEM_DIR="/Applications/Ghostty.app/Contents/Resources/ghostty/themes"
CUSTOM_SYMLINK="$HOME/.config/ghostty/themes/current-theme"

# Whitelist of system themes to include
system_themes=(
  "Black Metal"
  "Everforest Dark Hard"
  "Ghostty Default Style Dark"
  "Gruvbox Dark Hard"
  "N0tch2K"
  "Nvim Dark"
  "Nvim Light"
  "Atom One Dark"
  "One Half Dark"
  "Oxocarbon"
  "Vague"
  "Kanagawa Wave"
  "Nord"
  "Rose Pine"
  "Seoulbones Dark"
  "Seoulbones Light"
)

# Generate and select theme
selection=$(
  {
    echo "0 [1m── Custom Themes ─────────────[0m"
    for t in "$CUSTOM_DIR"/*; do
      [[ -f "$t" ]] && echo "custom $(basename "$t")"
    done
    echo ""
    echo "0 [1m── Built-in Themes ───────────[0m"
    for name in "${system_themes[@]}"; do
      echo "system $name"
    done
  } | fzf \
      --ansi \
      --with-nth=2.. \
      --delimiter=' ' \
      --no-unicode \
      --border=none \
      --prompt="Theme > " \
      --no-preview \
      --reverse
)

# Exit if nothing selected
[[ -z "$selection" ]] && {
  echo "No theme selected." >&2
  exit 1
}

# Split into prefix and theme name
prefix="${selection%% *}"
theme="${selection#* }"

# Resolve correct theme path
if [[ "$prefix" == "custom" ]]; then
  theme_path="$CUSTOM_DIR/$theme"
else
  theme_path="$SYSTEM_DIR/$theme"
fi

# Update the symlink
ln -sf "$theme_path" "$CUSTOM_SYMLINK"

# Reload Ghostty theme
pkill -SIGUSR2 ghostty
