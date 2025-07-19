#!/bin/zsh

set -e

CUSTOM_DIR="$HOME/.config/ghostty/themes/custom"
SYSTEM_DIR="/Applications/Ghostty.app/Contents/Resources/ghostty/themes"
CUSTOM_SYMLINK="$HOME/.config/ghostty/themes/current-theme"

# Whitelist of system themes to include
system_themes=(
  "Black Metal"
  "Everforest Dark - Hard"
  "Ghostty Default StyleDark"
  "GruvboxDarkHard"
  "N0tch2K"
  "NvimDark"
  "NvimLight"
  "Oxocarbon"
  "Vague"
  "nord"
  "rose-pine"
  "seoulbones_dark"
  "seoulbones_light"
)

print_theme_list() {
  for t in "$CUSTOM_DIR"/*; do
    [[ -f "$t" ]] && echo "1 $(basename "$t")"
  done

  for name in "${system_themes[@]}"; do
    echo "2 $name"
  done
}

theme=$(
  {
    echo "0 [1m── Custom Themes ─────────────[0m"
    for t in "$CUSTOM_DIR"/*; do
      [[ -f "$t" ]] && echo "1 $(basename "$t")"
    done
    echo ""
    echo "0 [1m── Built-in Themes ───────────[0m"
    for name in "${system_themes[@]}"; do
      echo "2 $name"
    done
  } | fzf \
      --ansi \
      --with-nth=2.. \
      --nth=2.. \
      --delimiter=' ' \
      --no-unicode \
      --border=none \
      --prompt="Theme > " \
      --no-preview \
      --reverse \
      --bind "enter:accept"
)

# Strip out the group prefix (first word)
theme="${theme#* }"

# Let user select
# theme=$(print_theme_list | fzf --prompt="Theme > " --no-preview --border=none --no-unicode)

if [[ -z "$theme" ]]; then
  echo "No theme selected." >&2
  exit 1
fi

# Parse prefix and name
prefix=${theme%%:*}
name=${theme#*:}

# Resolve full path
if [[ "$prefix" == "custom" ]]; then
  theme_path="$CUSTOM_DIR/$name"
else
  theme_path="$SYSTEM_DIR/$name"
fi

# Update the symlink
ln -sf "$theme_path" "$CUSTOM_SYMLINK"

# Signal Ghostty to reload theme
pkill -SIGUSR2 ghostty
