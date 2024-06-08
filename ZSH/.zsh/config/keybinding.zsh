# Setup
autoload -U edit-command-line
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N edit-command-line

# Keys
bindkey '\033' beginning-of-line # [ESC] - Go to beginning of line
bindkey "^[[A" up-line-or-beginning-search  # [Typing+Up] - Fuzzy find history forward
bindkey "^[[B" down-line-or-beginning-search  # [Typing+Down] - Fuzzy find history backward
bindkey "^[[1~" beginning-of-line  # [Home] - Go to beginning of line
bindkey "^[[4~" end-of-line  # [End] - Go to end of line
bindkey "^[[1;5C" forward-word  # [Ctrl+Right] - Move forward one word
bindkey "^[[1;5D" backward-word  # [Ctrl+Left] - Move backward one word
bindkey "^e" edit-command-line  # [Ctrl+e] - Use $EDITOR to write a command
