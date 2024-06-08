### App configuration ---------------------------------------------------------

alias gconfig="nvim ~/.gitconfig"
alias nconfig="nvim ~/.config/nvim/init.lua"
alias tconfig="nvim ~/.tmux.conf"
alias zalias="nvim ~/.zsh/config/alia.zsh"
alias zconfig="nvim ~/.zshrc"

### Shortcut ------------------------------------------------------------------

# Basic
alias q="exit"
alias e="nnn"
alias C="clear"
alias R="exec zsh"

# Change dir
alias .="cd ."
alias ..="cd .."
alias ...="cd ~/"

# Various
alias tr="tree -C"
alias fz="fzf -e"
alias ed="nvim"
alias zi="z -I ."
alias ds="gdu"
alias lg="lazygit"
alias fd="fd -H"

# Git
alias gt="git"
alias gta="git add"
alias gtc="git clone"
alias gtm="git merge --no-ff"
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

# Nanoid
alias id="nanoid --alphabet abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 --size"
alias idn="nanoid --alphabet 1234567890 --size"
alias ids="nanoid --alphabet abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ --size"

### Specials ------------------------------------------------------------------

# Golang
alias @go-build='go build -a -gcflags=all="-l -B" -ldflags="-w -s"'

# Termux
alias @distro="proot-distro login"

# Javascript
alias @js-server="five-server"
alias @postcss-opts="pnpm postcss --no-map --replace src/**/*.css --config ./opts/postcss.config.cjs"

alias @pnpm-pkg-postcss="pnpm i -D postcss autoprefixer postcss-cli postcss-nested postcss-sorting"
alias @pnpm-pkg-base="pnpm i -D modern-normalize eruda"
alias @pnpm-pkg-icon="pnpm i -D unplugin-auto-import unplugin-icons @iconify-json/material-symbols"
alias @pnpm-pkg-extra="pnpm i -D @svgr/core @svgr/plugin-jsx"

alias @prettier="prettier --write '**/*.{html,css,js,ts,jsx,json}'"
alias @prettier-all="prettier --write '**/*.{html,css,scss,js,ts,jsx,vue,json,astro}'"

# Clean
alias @clean-apt="apt autoremove"
alias @clean-composer="composer clear-cache"
alias @clean-go="go clean -modcache"
alias @clean-npm="npm cache clean --force"
alias @clean-pnpm="pnpm store prune"

### Other ---------------------------------------------------------------------

# Ssh
alias @ssh-agent-start='eval "$(ssh-agent -s)"'
alias @ssh-add-github='ssh-add ~/.ssh/github_EJ5Mx'
alias @ssh-github="ssh-agent-start && ssh-add-github"
