# Shortcut
alias q="exit"
alias e="nnn"
alias C="clear"
alias R="exec zsh"

# Commands
alias ..="cd .."
alias ...="cd ~/"
alias cp="cp -iv"
alias mv="mv -iv"
alias rm="rm -iv"
alias tgpt="tgpt -i"
alias bard="bard -i"

# App configuration
alias zconfig="nvim ~/.zshrc"
alias tconfig="nvim ~/.tmux.conf"
alias gconfig="nvim ~/.gitconfig"
alias nconfig="nvim ~/.config/nvim/"

# App
alias tr="tree -C"
alias fz="fzf -e"
alias ed="nvim"
alias zi="z -I ."

# Disk usage
alias ds="gdu"

# Git
alias lg="lazygit"

alias gt="git"
alias gta="git add"
alias gtc="git clone"
alias gtlg="git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)' --all"
alias gtrc="git remote set-url origin"
alias gtrv="git remote -v"

# Tmux
alias tx="tmux"
alias txl="tmux list-sessions"
alias txn="tmux new-session -s"
alias txk="tmux kill-server -t"
alias txa="tmux attach -t"

# Jump
alias jp="jump"
alias jpa="mark"
alias jpl="marks"
alias jpd="unmarks"

# Specials --------------------------------------------------------------------

alias @distro="proot-distro login"
alias @js-server="five-server"
alias @nanoid="nanoid --size"
alias @pnpm-clean="pnpm store prune"
alias @postcss-opts="postcss --no-map --replace src/**/*.css --config ./opts/postcss.config.cjs"
alias @prettier="prettier --write '**/*.{html,css,scss,js,ts,jsx,vue,svelte,json}'"
