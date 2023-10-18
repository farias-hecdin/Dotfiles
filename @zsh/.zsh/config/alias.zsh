# Shortcut
alias q="exit"
alias C="clear"
alias e="nnn"
alias r="exec zsh"

# Commands
alias ..="cd .."
alias Cp="cp -iv"
alias Mv="mv -iv"
alias Rm="rm -iv"

# App configuration
alias zconfig="nvim ~/.zshrc"
alias tconfig="nvim ~/.tmux.conf"
alias gconfig="nvim ~/.gitconfig"
alias nconfig="nvim ~/.config/nvim/"

# App
alias treeU="tree -C"
alias fzfExact="fzf -e"
alias ed="nvim"

# Disk usage
# alias ds="ncdu"
alias ds="gdu"

# Git
alias gi="lazygit"
alias giLast="git log -1 HEAD --stat"
alias giRemote="git remote -v"
alias giRemoteChange="git remote set-url origin"
alias giGraph="git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)' --all"

# Tmux
alias tm="tmux"
alias tmList="tmux list-sessions"
alias tmNew="tmux new-session -s"
alias tmKill="tmux kill-server -t"
alias tmAttach="tmux attach -t"

# Jump
alias ju="jump"
alias juAdd="mark"
alias juList="marks"
alias juDelete="unmarks"
