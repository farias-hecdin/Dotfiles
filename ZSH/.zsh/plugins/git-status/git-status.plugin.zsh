# cat ~/.oh-my-zsh/lib/git.zsh

# Get the name of the branch we are on
function git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
}

# Checks if working tree is dirty
function parse_git_dirty() {
  local SUBMODULE_SYNTAX=''
  if [[ $POST_1_7_2_GIT -gt 0 ]]; then
    SUBMODULE_SYNTAX="--ignore-submodules=dirty"
  fi
  if [[ -n $(git status -s ${SUBMODULE_SYNTAX}  2> /dev/null) ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

# Checks if there are commits ahead from remote
function git_prompt_ahead() {
  if [[ -n "$(git log origin/$(current_branch)..HEAD 2> /dev/null)" ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_AHEAD"
  fi
}

# Formats prompt string for current git commit short SHA
function git_prompt_short_sha() {
  SHA=$(git rev-parse --short HEAD 2> /dev/null) && echo "$ZSH_THEME_GIT_PROMPT_SHA_BEFORE$SHA$ZSH_THEME_GIT_PROMPT_SHA_AFTER"
}

# Formats prompt string for current git commit long SHA
function git_prompt_long_sha() {
  SHA=$(git rev-parse HEAD 2> /dev/null) && echo "$ZSH_THEME_GIT_PROMPT_SHA_BEFORE$SHA$ZSH_THEME_GIT_PROMPT_SHA_AFTER"
}

# Get the status of the working tree
function git_prompt_status() {
  INDEX=$(git status --porcelain 2> /dev/null)

  ZSH_THEME_GIT_PROMPT_UNTRACKED=" "
  ZSH_THEME_GIT_PROMPT_ADDED=" "
  ZSH_THEME_GIT_PROMPT_MODIFIED=" "
  ZSH_THEME_GIT_PROMPT_UNMERGED=" "

  STATUS=""
  if [[ $INDEX == *'?? '* ]]; then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNTRACKED$STATUS"
  fi
  if [[ $INDEX == *'A  '* || $INDEX == *'M  '* ]]; then
    STATUS="$ZSH_THEME_GIT_PROMPT_ADDED$STATUS"
  fi
  if [[ $INDEX == *' M '* || $INDEX == *'AM '* || $INDEX == *' T '* ]]; then
    STATUS="$ZSH_THEME_GIT_PROMPT_MODIFIED$STATUS"
  fi
  if [[ $INDEX == *'R  '* ]]; then
    STATUS="$ZSH_THEME_GIT_PROMPT_RENAMED$STATUS"
  fi
  if [[ $INDEX == *' D '* || $INDEX == *'AD '* ]]; then
    STATUS="$ZSH_THEME_GIT_PROMPT_DELETED$STATUS"
  fi
  if [[ $INDEX == *'UU '* ]]; then
    STATUS="$ZSH_THEME_GIT_PROMPT_UNMERGED$STATUS"
  fi
  echo $STATUS
}

# Compare the provided version of git to the version installed and on path
# prints 1 if input version <= installed version
# prints -1 otherwise
function git_compare_version() {
  local INPUT_GIT_VERSION=$1;
  local INSTALLED_GIT_VERSION
  INPUT_GIT_VERSION=(${(s/./)INPUT_GIT_VERSION});
  INSTALLED_GIT_VERSION=($(git --version));
  INSTALLED_GIT_VERSION=(${(s/./)INSTALLED_GIT_VERSION[3]});

  for i in {1..3}; do
    if [[ $INSTALLED_GIT_VERSION[$i] -lt $INPUT_GIT_VERSION[$i] ]]; then
      echo -1
      return 0
    fi
  done
  echo 1
}

# This is unlikely to change so make it all statically assigned
POST_1_7_2_GIT=$(git_compare_version "1.7.2")
# Clean up the namespace slightly by removing the checker function
unset -f git_compare_version
