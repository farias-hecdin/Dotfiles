#!/bin/zsh

setopt prompt_subst

DIR_LENGTH=28

function run() {
  local PR_USER
  local PR_USER_OP
  local PR_PROMPT PR_HOST

  # Check the UID
  if [[ $UID -ne 0 ]]; then # Normal user
    PR_USER="%F{green}(%n%f"
    PR_USER_OP="%F{green}%#%f"
    PR_PROMPT="%F{green}▶%f"
  else # Root user
    PR_USER="%F{red}(%n%f"
    PR_USER_OP="%F{red}%#%f"
    PR_PROMPT="%F{red}▶%f"
  fi

  # Check if we are on SSH or not
  if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
    PR_HOST="%F{red}%M)%f" # SSH
  else
    PR_HOST="%F{green}%M)%f" # No SSH
  fi

  # Prompt style
  local return_code="%(?..%F{red}%? %f)"
  local user_host="${PR_USER}%F{cyan}@${PR_HOST}"
  local dir='%F{blue}(%$DIR_LENGTH<...<%~%<<)%f'
  local hour="%F{cyan}%D{%I:%M%p}%f"
  local git_status='%F{white}$(git_prompt_status)%f'
  local git_branch='$(git_prompt_info)'

  # Prompt
  RPROMPT="${return_code}"
  ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow} "
  ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
  PROMPT="╭─ ${hour} ${user_host} ${dir} ${git_branch} ${git_status}
╰─$PR_PROMPT "
}

run
