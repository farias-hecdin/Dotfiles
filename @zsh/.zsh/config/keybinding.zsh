# Info (https://gist.github.com/VonHeikemen/8b3bbdfee976683212818b704b08f405)
set editing-mode vi
set show-mode-in-prompt on
set vi-ins-mode-string +
set vi-cmd-mode-string :

# Setup
autoload -U edit-command-line
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N edit-command-line

bindkey '\033' edit-command-line

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
