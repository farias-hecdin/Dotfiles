# More information (https://dev.to/hbenvenutti/using-zsh-without-omz-4gch)

# Zsh init ====================================================================
export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH=$HOME/.zsh


# History config ==============================================================
export HISTFILE=$ZSH/.zsh_history
export HISTSIZE=10000 # How many commands zsh will load to memory.
export SAVEHIST=10000 # How many commands history will save on file.

setopt EXTENDED_HISTORY # Record command start time.
setopt HIST_FIND_NO_DUPS # History won't show duplicates on search.
setopt HIST_IGNORE_ALL_DUPS # Do not put duplicated command into history list.
setopt HIST_IGNORE_SPACE # Ignore commands that start with space
setopt HIST_EXPIRE_DUPS_FIRST # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt HIST_REDUCE_BLANKS # Remove unnecessary blanks.
setopt HIST_SAVE_NO_DUPS # Do not save duplicated command.
setopt INC_APPEND_HISTORY_TIME # Append command to history file immediately after execution.


# Plugins & themes ============================================================

# Themes
source $ZSH/themes/z-style/z-style.zsh-theme

# Editing support
source $ZSH/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
# source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source $ZSH/plugins/zsh-vi-mode/zsh-vi-mode.zsh

# Motion
source $ZSH/plugins/jump/jump.plugin.zsh
source $ZSH/plugins/z/z.sh

# Git
source $ZSH/plugins/git/git.plugin.zsh


# Alias =======================================================================
alias C="clear"
alias q="exit"
alias R="exec zsh"

# General tools
alias v="nvim"
alias e="nnn"
alias d="ncdu"

# Git
alias g="lazygit"
alias ga="git add"

# Tmux
alias t="tmux"
alias tk="tmux kill-server"

# Jump
alias j="jump"
alias jm="mark"
alias jl="marks"
alias ju="unmarks"


# Keybinding ==================================================================
# Info (https://gist.github.com/VonHeikemen/8b3bbdfee976683212818b704b08f405)

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
autoload -U edit-command-line

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N edit-command-line

# Enable vi-mode
bindkey -v

# Keys
bindkey "^[[A" up-line-or-beginning-search  # [Typing+Up] - Fuzzy find history forward
bindkey "^[[B" down-line-or-beginning-search  # [Typing+Down] - Fuzzy find history backward
# bindkey "^[[1~" beginning-of-line  # [Home] - Go to beginning of line
# bindkey "^[[4~" end-of-line  # [End] - Go to end of line
# bindkey "^[[1;5C" forward-word  # [Ctrl+Right] - Move forward one word
# bindkey "^[[1;5D" backward-word  # [Ctrl+Left] - Move backward one word
# bindkey "^e" edit-command-line  # [Ctrl+e] - Use $EDITOR to write a command
bindkey " " magic-space  # [Space] - Do history expansion
# bindkey -M vicmd "/" fzf-history-widget  # [Slash] - Search history with fzf
#
# export KEYTIMEOUT=1 # Disable delay when changing modes
#
# # Change cursor shape
# zle-keymap-select() {
#   if [ $KEYMAP = vicmd ]; then
#     echo -ne "\e[2 q" # the command mode for vi
#   else
#     echo -ne "\e[6 q" # the insert mode for vi
#   fi
# }
# zle -N zle-keymap-select
# echo -ne "\e[6 q"


# Export ======================================================================

# nnn
export NNN_PLUG='f:fzcd;j:autojump;'
# nnn end

# fzf
export FZF_DEFAULT_OPTS='--height 85% --layout=reverse --border'
# fzf end

# pnpm
export PNPM_HOME="/data/data/com.termux/files/home/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end
