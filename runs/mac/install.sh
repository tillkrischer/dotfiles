#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd "$(dirname "$0")" && pwd)
LOCAL_DIR="$HOME/.local"
APP_DIR="$HOME/Applications"
TMP_DIR="$(mktemp -d)"

cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

mkdir -p "$LOCAL_DIR/bin" "$LOCAL_DIR/opt" "$APP_DIR"

. "$SCRIPT_DIR/lib.sh"

CLI_PROGRAMS=
APP_PROGRAMS=

for program in "$SCRIPT_DIR"/programs/cli/*.sh; do
  . "$program"
  program_name=$(basename "$program" .sh)
  CLI_PROGRAMS="$CLI_PROGRAMS $program_name"
done

for program in "$SCRIPT_DIR"/programs/apps/*.sh; do
  . "$program"
  program_name=$(basename "$program" .sh)
  APP_PROGRAMS="$APP_PROGRAMS $program_name"
done

print_targets() {
  echo "cli:"
  for program in $CLI_PROGRAMS; do
    echo "  $program"
  done

  echo "apps:"
  for program in $APP_PROGRAMS; do
    echo "  $program"
  done
}

has_target() {
  target="$1"

  for program in $CLI_PROGRAMS $APP_PROGRAMS; do
    if [ "$program" = "$target" ]; then
      return 0
    fi
  done

  return 1
}

install_target() {
  target="$1"

  if ! has_target "$target"; then
    echo "unknown target: $target" >&2
    print_targets >&2
    exit 1
  fi

  install_func="install_$(printf '%s' "$target" | tr '-' '_')"
  "$install_func"
}

if [ "$#" -eq 0 ]; then
  print_targets
  exit 0
fi

for target in "$@"; do
  install_target "$target"
done
