# Loads SSH keys for secure authentication
function f_loadSSH() {
  eval $(ssh-agent -s)
  ssh-add ~/.ssh/$1
}

# Changes directory to a selected subdirectory using fzf
function f_cdToDir() {
  local selected_dir
  selected_dir=$(fd -t d . "$1" | fzf --height 90%)
  if [[ -n "$selected_dir" ]]; then
    # Change to the selected directory
    cd "$selected_dir" || return 1
  fi
}

# Prepends the 'git@github.com:' prefix to a given string
function f_addSshPrefix() {
  local keyword="git@github.com:"
  echo "${keyword}${1}"
}

