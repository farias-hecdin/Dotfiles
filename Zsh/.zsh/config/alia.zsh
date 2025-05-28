source $ZSH/config/utils.zsh

### Distro --------------------------------------------------------------------

alias os="proot-distro login"
alias alpine="termux-alpine"

### APP CONFIGURATION ---------------------------------------------------------

alias gconfig="$EDITOR ~/.gitconfig"
alias nconfig="$EDITOR ~/.config/nvim/init.lua"
alias tconfig="$EDITOR ~/.tmux.conf"
alias zalias="$EDITOR ~/.zsh/config/alia.zsh"
alias zconfig="$EDITOR ~/.zshrc"

### SHORTCUTS -----------------------------------------------------------------

# Basic
alias C="clear"
alias R="exec zsh"
alias q="exit"
alias e="nnn"

# Change dir
alias .="cd ."
alias ..="cd .."
alias ...="cd ~/"

# Various
alias ds="dua i"
alias ed="nvim"
alias fz="fzf -e"
alias lg="lazygit"
alias tree="tree -C"
alias zi="z -I ."

alias Fd="fd -H"
alias Ls="ls -a -F -h --color=always -v --time-style=long-iso"
alias Cd='fn_cdToDir .'
alias Ed="nvim --noplugin"

# Git
alias Git-ssh-prefix='fn_addSshPrefix'
alias Git-compress="git gc --aggressive --prune=now"
alias Git-add="git add"
alias Git-merge="git merge --no-ff"
alias Git-branch-rename="git branch -m" # -> <old-name> <new-name>
alias Git-branch-rename-remote="git push origin" # -> :<old-name> <new-name>
alias Git-remote-change="git remote set-url origin"
alias Git-remote-view="git remote -v"
alias Git-log="git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)' --all"

alias gtc="git clone"
alias gtrc="Git-remote-change"
alias gtrv="Git-remote-view"

# Tmux
alias Tmux-list="tmux list-sessions"
alias Tmux-new-session="tmux new-session -s"
alias Tmux-kill-all="tmux kill-server"
alias Tmux-kill-this="tmux kill-server -t"
alias Tmux-attach="tmux attach -t"

alias tx="tmux"
alias txa="Tmux-kill-all"

# Nanoid
alias Id="nanoid --alphabet abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 --size"
alias Id-int="nanoid --alphabet 1234567890 --size"
alias Id-string="nanoid --alphabet abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ --size"

# Others
alias lua="luajit"
alias nimble="nimble --verbose"
alias info="fastfetch"

### SPECIALS ------------------------------------------------------------------

# Hyperfine (benchmark)
alias B5="hyperfine -r 5 --warmup 5"
alias B25="hyperfine -r 25 --warmup 5"
alias B50="hyperfine -r 50 --warmup 5"
alias B100="hyperfine -r 100 --warmup 5"
alias B150="hyperfine -r 100 --warmup 5"
alias B200="hyperfine -r 200 --warmup 5"

# Tar
alias Tar-gz="tar -xzf"
alias Tar-xz="tar -xvf"
alias Tar-lz4-c="tar --use-compress-program=lz4 -cvf archive.lz4" # Need: "pkg install lz4"
alias Tar-lz4-d="tar --use-compress-program=lz4 -xvf archive.lz4 -C"

# Build
alias Go-build='go build'
alias Go-build-min='go build -a -gcflags=all="-l -B" -ldflags="-w -s"'

alias Nim="clear && nim c --hints:off"
alias Nim-build="nim c -d:release"
alias Nim-build-min="nim c -d:release --opt:speed --passC:-flto --passL:-flto --panics:on"

# Javascript
alias Js-server="five-server"
alias Postcss-opts="pnpm postcss --no-map --replace src/**/*.css --config ./opts/postcss.config.cjs"

alias Pnpm-i-base="pnpm i -D modern-normalize eruda"
alias Pnpm-i-extra="pnpm i -D @svgr/core @svgr/plugin-jsx"
alias Pnpm-i-icons="pnpm i -D unplugin-auto-import unplugin-icons @iconify-json/material-symbols"
alias Pnpm-i-postcss="pnpm i -D postcss autoprefixer postcss-cli postcss-nested postcss-sorting"

alias Prettier="prettier --write '**/*.{html,css,scss,js,ts,jsx,vue,json,astro}'"

# Clean
alias Clean-apt="apt autoremove && pkg clean"
alias Clean-composer="composer clear-cache"
alias Clean-go="go clean -modcache"
alias Clean-npm="npm cache clean --force"
alias Clean-pnpm="pnpm store prune"

### OTHERS --------------------------------------------------------------------

# Termux
alias Add="pkg install"
alias Del="pkg uninstall"
alias Search="pkg search"
alias Installed="pkg list-installed"
alias Update-list-package="pkg update"
alias Upgrade-now="pkg update && pkg upgrade"
alias Upgradable="apt list --upgradable"

# Ssh
alias load-ssh="fn_loadSSH"
