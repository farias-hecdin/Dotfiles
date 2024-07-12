### APP CONFIGURATION ---------------------------------------------------------

alias gconfig="nvim ~/.gitconfig"
alias nconfig="nvim ~/.config/nvim/init.lua"
alias tconfig="nvim ~/.tmux.conf"
alias zalias="nvim ~/.zsh/config/alia.zsh"
alias zconfig="nvim ~/.zshrc"

### SHORTCUTS -----------------------------------------------------------------

alias fd="fd -H"
alias ls="ls -a -F -h --color=always -v --time-style=long-iso"
alias nimble="nimble --verbose"

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
alias bm="hyperfine -r 250 --warmup 3"
alias tr="tree -C"
alias fz="fzf -e"
alias ed="nvim"
alias zi="z -I ."
alias ds="gdu"
alias lg="lazygit"

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
alias txK="tmux kill-server"
alias txk="tmux kill-server -t"
alias txa="tmux attach -t"

# Jump
alias jp="jump"
alias jpa="mark"
alias jpl="marks"
alias jpd="unmarks"

# Nanoid
alias @id="nanoid --alphabet abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 --size"
alias @id-i="nanoid --alphabet 1234567890 --size"
alias @id-s="nanoid --alphabet abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ --size"

### SPECIALS ------------------------------------------------------------------

alias tar-gz="tar -xzf"
alias tar-xz="tar -xvf"

# Build
alias @go-build='go build'
alias @go-build-min='go build -a -gcflags=all="-l -B" -ldflags="-w -s"'
alias @nim-build="nim c -d:release"
alias @nim-build-min="nim c -d:release --opt:size --passC:-flto --passL:-flto --panics:on"
alias @nim-build-speed="nim c -d:release --opt:speed --passC:-flto --passL:-flto --panics:on"

# Javascript
alias @js-server="five-server"
alias @postcss-opts="pnpm postcss --no-map --replace src/**/*.css --config ./opts/postcss.config.cjs"

alias @pnpm-pkg-base="pnpm i -D modern-normalize eruda"
alias @pnpm-pkg-extra="pnpm i -D @svgr/core @svgr/plugin-jsx"
alias @pnpm-pkg-icon="pnpm i -D unplugin-auto-import unplugin-icons @iconify-json/material-symbols"
alias @pnpm-pkg-postcss="pnpm i -D postcss autoprefixer postcss-cli postcss-nested postcss-sorting"

alias @prettier="prettier --write '**/*.{html,css,js,ts,jsx,json}'"
alias @prettier-all="prettier --write '**/*.{html,css,scss,js,ts,jsx,vue,json,astro}'"

# Clean
alias @clean-apt="apt autoremove"
alias @clean-composer="composer clear-cache"
alias @clean-go="go clean -modcache"
alias @clean-npm="npm cache clean --force"
alias @clean-pnpm="pnpm store prune"

### OTHERS --------------------------------------------------------------------

# Ssh
FILE_NAME="github1"

alias @ssh-agent-start='eval "$(ssh-agent -s)"'
alias @ssh-add-github="ssh-add ~/.ssh/${FILE_NAME}"
alias @ssh-github="@ssh-agent-start && @ssh-add-github"

# TTS
alias @tts="edge-tts --voice es-PA-RobertoNeural --write-media audio.mp3 --write-subtitles audio.vtt --pitch=-15Hz --rate=+18% --text"
