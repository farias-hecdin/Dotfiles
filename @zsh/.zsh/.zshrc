# More information (https://dev.to/hbenvenutti/using-zsh-without-omz-4gch)

# Zsh init ====================================================================

export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH=$HOME/.zsh


# History config ==============================================================

export HISTFILE=$ZSH/.zsh_history
export HISTSIZE=1000 # How many commands zsh will load to memory.
export SAVEHIST=1000 # How many commands history will save on file.

setopt EXTENDED_HISTORY # Record command start time.
setopt HIST_EXPIRE_DUPS_FIRST # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt HIST_FIND_NO_DUPS # History won't show duplicates on search.
setopt HIST_SAVE_NO_DUPS # Do not save duplicated command.
setopt HIST_IGNORE_ALL_DUPS # Do not put duplicated command into history list.
setopt HIST_IGNORE_SPACE # Ignore commands that start with space
setopt HIST_REDUCE_BLANKS # Remove unnecessary blanks.
setopt INC_APPEND_HISTORY_TIME # Append command to history file immediately after execution.


# Plugins & themes ============================================================

# Themes
source $ZSH/themes/zshmate/zshmate.zsh-theme

# Motion
source $ZSH/plugins/jump/jump.plugin.zsh
source $ZSH/plugins/zsh-z/zsh-z.plugin.zsh

# Editing support
source $ZSH/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $ZSH/plugins/zsh-vi-mode/zsh-vi-mode.zsh

# Git
source $ZSH/plugins/git-status/git-status.plugin.zsh


# Alias =======================================================================

# General comands
alias q="exit"
alias C="clear"
alias R="exec zsh"
alias Cp="cp -iv"
alias Mv="mv -iv"
alias Rm="rm -iv"

# App configuration
alias zconfig="nvim ~/.zsh/"
alias tconfig="nvim ~/.tmux.conf"
alias gconfig="nvim ~/.gitconfig"

# App
alias d="ncdu"
alias e="nnn"
alias v="nvim"
alias g="lazygit"
alias fzfe="fzf -e"

# Tmux
alias tx="tmux"
alias txl="tmux list-sessions"
alias txn="tmux new-session -s"
alias txk="tmux kill-server -t"
alias txa="tmux attach -t"

# Jump
alias ju="jump"
alias jum="mark"
alias jul="marks"
alias juu="unmarks"


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
# bindkey " " magic-space  # [Space] - Do history expansion
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
