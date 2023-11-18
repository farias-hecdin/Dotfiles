# Shortcut
alias q="exit"
alias e="nnn"
alias C="clear"
alias R="exec zsh"

# Commands
alias ..="cd .."
alias ...="cd ~/"
alias Cp="cp -iv"
alias Mv="mv -iv"
alias Rm="rm -iv"
alias tgpt="tgpt -i"
alias bard="bard -i"

# App configuration
alias zconfig="nvim ~/.zshrc"
alias tconfig="nvim ~/.tmux.conf"
alias gconfig="nvim ~/.gitconfig"
alias nconfig="nvim ~/.config/nvim/"

# App
alias tree="tree -C"
alias fzfe="fzf -e"
alias ed="nvim"
alias zi="z -I ."

# Disk usage
alias ds="gdu"

# Git
alias lg="lazygit"

alias gtLast="git log -1 HEAD --stat"
alias gtRemote="git remote -v"
alias gtRemoteChange="git remote set-url origin"
alias gtGraph="git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)' --all"

# Tmux
alias tx="tmux"
alias txList="tmux list-sessions"
alias txNew="tmux new-session -s"
alias txKill="tmux kill-server -t"
alias txAttach="tmux attach -t"

# Jump
alias jp="jump"
alias jpAdd="mark"
alias jpList="marks"
alias jpDelete="unmarks"

# Specials --------------------------------------------------------------------

alias prettierNow="prettier --write '**/*.{html,css,js,ts,jsx,vue,svelte,json}'"
