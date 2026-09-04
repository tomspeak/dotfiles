#!/bin/zsh

set -e

THEMES_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/ghostty/themes"
CUSTOM_DIR="$THEMES_DIR/custom"
SYSTEM_DIR="${GHOSTTY_RESOURCES_DIR:-/Applications/Ghostty.app/Contents/Resources/ghostty}/themes"
CUSTOM_SYMLINK="$THEMES_DIR/current-theme"

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
  "Vesper"
)

# Only existing themes are selectable; keep the source visible beside each name.
selection=$(
  {
    for theme_path in "$CUSTOM_DIR"/*(N); do
      if [[ -f "$theme_path" ]]; then
        printf 'custom %s\n' "${theme_path:t}"
      fi
    done
    for name in "${system_themes[@]}"; do
      if [[ -f "$SYSTEM_DIR/$name" ]]; then
        printf 'system %s\n' "$name"
      fi
    done
  } | fzf \
      --header="Custom themes and built-in favorites" \
      --no-unicode \
      --border=none \
      --prompt="Theme > " \
      --no-preview \
      --reverse
) || {
  picker_status=$?
  # No match and cancellation leave the current theme untouched.
  (( picker_status == 1 || picker_status == 130 )) && exit 0
  exit "$picker_status"
}

[[ -z "$selection" ]] && exit 0

# Split into prefix and theme name
prefix="${selection%% *}"
theme="${selection#* }"

# Resolve correct theme path
case "$prefix" in
  custom) theme_path="$CUSTOM_DIR/$theme" ;;
  system) theme_path="$SYSTEM_DIR/$theme" ;;
  *) printf 'Invalid theme selection: %s\n' "$selection" >&2; exit 1 ;;
esac

[[ -f "$theme_path" ]] || {
  printf 'Theme no longer exists: %s\n' "$theme_path" >&2
  exit 1
}

# Update the symlink
ln -sfn "$theme_path" "$CUSTOM_SYMLINK"

# Reload Ghostty theme
pkill -SIGUSR2 -x ghostty || [[ $? == 1 ]]
