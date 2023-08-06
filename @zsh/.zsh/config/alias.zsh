# General
alias q="exit"
alias C="clear"
alias R="exec zsh"
alias Cp="cp -iv"
alias Mv="mv -iv"
alias Rm="rm -iv"
alias ..="cd .."

# App configuration
alias zconfig="nvim ~/.zsh/"
alias tconfig="nvim ~/.tmux.conf"
alias gconfig="nvim ~/.gitconfig"
alias nconfig="nvim ~/.config/nvim/"

# App
alias tree.c="tree -C"
alias fzf.e="fzf -e"
alias e="nnn"
alias ed="nvim"

# Disk usage
alias ds.c="ncdu"
alias ds.g="gdu"

# Git
alias gt="lazygit"
alias gt.last="git log -1 HEAD --stat"
alias gt.remote="git remote -v"
alias gt.remote.change="git remote set-url origin"
alias gt.graph="git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)' --all"

# Tmux
alias tx="tmux"
alias tx.list="tmux list-sessions"
alias tx.new="tmux new-session -s"
alias tx.kill="tmux kill-server -t"
alias tx.attach="tmux attach -t"

# Jump
alias ju="jump"
alias ju.add="mark"
alias ju.list="marks"
alias ju.delete="unmarks"
