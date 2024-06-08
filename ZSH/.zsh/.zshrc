# More information (https://dev.to/hbenvenutti/using-zsh-without-omz-4gch)

# Zsh init ====================================================================

export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH=$HOME/.zsh
export EDITOR=nvim # Specifies the $EDITOR code
export KEYTIMEOUT=1

# History config ==============================================================

export HISTFILE=$ZSH/.zsh_history
export HISTSIZE=999 # How many commands zsh will load to memory.
export SAVEHIST=999 # How many commands history will save on file.
setopt EXTENDED_HISTORY # Record command start time.
setopt HIST_EXPIRE_DUPS_FIRST # Delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt HIST_FIND_NO_DUPS # History won't show duplicates on search.
setopt HIST_SAVE_NO_DUPS # Do not save duplicated command.
setopt HIST_IGNORE_ALL_DUPS # Do not put duplicated command into history list.
setopt HIST_IGNORE_SPACE # Ignore commands that start with space
setopt HIST_REDUCE_BLANKS # Remove unnecessary blanks.
setopt INC_APPEND_HISTORY_TIME # Append command to history file immediately after execution.

# Plugins and themes ==========================================================

# Themes
source $ZSH/themes/zshmate/zshmate.zsh-theme

# Tools
source $ZSH/plugins/git-status/git-status.plugin.zsh

export NNN_ZLUA="$ZSH/plugins/z.lua/z.lua"
eval "$(lua ~/.zsh/plugins/z.lua/z.lua --init zsh once)"

# Alias and Keybindings =======================================================

source $ZSH/config/alia.zsh
source $ZSH/config/keybinding.zsh

# Export ======================================================================

LOCAL_SHARE="/data/data/com.termux/files/home/.local/share"

# fzf
export FZF_DEFAULT_OPTS="--height 80% --layout=reverse --border"
# fzf end

# pnpm
export PNPM_HOME="/data/data/com.termux/files/home/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# nnn
export NNN_PLUG="j:autojump;"
# nnn end

# other
export PATH="$LOCAL_SHARE/luatiny:$PATH"
export PATH="$LOCAL_SHARE/lare:$PATH"
export PATH="$LOCAL_SHARE/impzy:$PATH"
export PATH="$LOCAL_SHARE/phpactor:$PATH"
export PATH="$LOCAL_SHARE/tgpt:$PATH"
