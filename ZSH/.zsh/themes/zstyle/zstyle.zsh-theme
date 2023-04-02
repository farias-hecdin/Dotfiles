#!/bin/zsh

setopt prompt_subst

() {
local PR_USER PR_USER_OP PR_PROMPT PR_HOST

# Check the UID
if [[ $UID -ne 0 ]]; then # normal user
  PR_USER="%F{green}(%n%f"
  PR_USER_OP="%F{green}%#%f"
  PR_PROMPT="%f➤%f"
else # root
  PR_USER="%F{red}%n%f"
  PR_USER_OP="%F{red}%#%f"
  PR_PROMPT="%F{red}➤%f"
fi

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
  PR_HOST="%F{red}%M%f" # SSH
else
  PR_HOST="%F{green}%M)%f" # no SSH
fi

# Prompt style
local return_code="%(?..%F{red}%? %f)"
local user_host="${PR_USER}%F{cyan}@${PR_HOST}"
local current_dir="%F{blue}(%~)%f"
local the_time="%F{cyan}(%D{%I:%M %p})%f"
local git_branch='$(git_prompt_info)'
local git_status='%F{white}$(git_prompt_status)%f'
PROMPT="╭─ ${the_time} ${user_host} ${current_dir} ${git_branch} ${git_status}
╰─$PR_PROMPT "

RPROMPT="${return_code}"
ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%f"
}
