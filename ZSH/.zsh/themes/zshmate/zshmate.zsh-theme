#!/bin/zsh

setopt prompt_subst

function get_user() {
  if [[ $UID -ne 0 ]]; then
    echo "%F{green}%n%f" "%F{green}%#%f" "%F{green}▶%f"
  else
    echo "%F{red}%n%f" "%F{red}%#%f" "%F{red}▶%f"
  fi
}

function get_host() {
  if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
    echo "%F{red}%M%f"
  else
    echo "%F{green}%M%f"
  fi
}

function run() {
  local PR_USER PR_USER_OP PR_PROMPT PR_HOST

  read PR_USER PR_USER_OP PR_PROMPT <<< $(get_user)
  PR_HOST=$(get_host)

  local RETURN_CODE="%(?..%F{red}%? %f)"
  local USER_HOST="$PR_USER%F{cyan}@$PR_HOST"
  local DIR='%F{blue}%20<…<%~%<<%f'
  local HOUR="%F{cyan}%D{%I:%M%p}%f"
  local GIT_STATUS='%F{white}$(git_prompt_status)%f'
  local GIT_BRANCH='$(git_prompt_info)'

  RPROMPT="$RETURN_CODE"
  ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow} "
  ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
  PROMPT="╭─ $HOUR $USER_HOST $DIR $GIT_BRANCH $GIT_STATUS
╰─$PR_PROMPT "
}

run
