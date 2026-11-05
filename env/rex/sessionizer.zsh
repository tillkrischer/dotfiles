#!/bin/zsh -f
setopt NO_UNSET PIPE_FAIL

rex_cli=$1
zoxide_cli=$2
fzf_cli=$3
client_id=$4
bootstrap_session=$5

cleanup() {
  if [[ -n "$bootstrap_session" ]]; then
    "$rex_cli" kill "$bootstrap_session" >/dev/null 2>&1 || true
  fi
}
trap cleanup EXIT

fail() {
  print -ru2 -- "$1"
  print -ru2 -- 'Press any key to close.'
  read -rk1
  exit 0
}

directories=$("$zoxide_cli" query -l) || fail 'Could not read the zoxide directory list.'
[[ -n "$directories" ]] || fail 'No zoxide folders yet. Visit a folder in your shell first.'

# Keep zoxide's ranking for an empty query; fzf ranks matches as you type.
# Clear inherited fzf options so selection always returns a single exact path.
selected=$(
  print -r -- "$directories" |
    while IFS= read -r directory; do
      [[ -d "$directory" ]] && print -r -- "$directory"
      true
    done |
    FZF_DEFAULT_OPTS='' FZF_DEFAULT_OPTS_FILE='' "$fzf_cli" \
      --layout=reverse --border=none --no-multi --scheme=path \
      --prompt='Project › ' \
      --header='Enter: open session · Esc: cancel'
)
picker_status=$?
(( picker_status == 1 || picker_status == 130 )) && exit 0
(( picker_status == 0 )) || fail "Folder picker failed (exit $picker_status)."
[[ -n "$selected" ]] || exit 0

"$rex_cli" -C "$client_id" do sessionizer_select \
  "directory=$selected" "picker_block=${REX_BLOCK:-}" \
  "bootstrap_session=$bootstrap_session" --json || fail 'Could not open the folder session.'

# A successful exit closes the floating terminal. Esc follows the same path.
exit 0
