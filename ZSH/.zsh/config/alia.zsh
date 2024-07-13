alias alpine="termux-alpine"

### APP CONFIGURATION ---------------------------------------------------------

alias gconfig="$EDITOR ~/.gitconfig"
alias nconfig="$EDITOR ~/.config/nvim/init.lua"
alias tconfig="$EDITOR ~/.tmux.conf"
alias zalias="$EDITOR ~/.zsh/config/alia.zsh"
alias zconfig="$EDITOR ~/.zshrc"

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
alias tr="tree -C"
alias fz="fzf -e"
alias ed="nvim"
alias zi="z -I ."
alias ds="gdu"
alias lg="lazygit"

# Git
alias gt="git"
alias gtc="git clone"
alias @git-add="git add"
alias @git-clone="git clone"
alias @git-merge="git merge --no-ff"
alias @git-remote-change="git remote set-url origin"
alias @git-remote-view="git remote -v"
alias @git-log="git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)' --all"

# Tmux
alias tx="tmux"
alias @tmux-list="tmux list-sessions"
alias @tmux-new-session="tmux new-session -s"
alias @tmux-kill-all="tmux kill-server"
alias @tmux-kill-this="tmux kill-server -t"
alias @tmux-attach="tmux attach -t"

# Nanoid
alias @id="nanoid --alphabet abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 --size"
alias @id-int="nanoid --alphabet 1234567890 --size"
alias @id-string="nanoid --alphabet abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ --size"

### SPECIALS ------------------------------------------------------------------

alias measure="hyperfine -r 250 --warmup 3"

# Tar
alias tar-gz="tar -xzf"
alias tar-xz="tar -xvf"
alias tarC-lz4="tar --use-compress-program=lz4 -cvf archive.lz4" # Need: "pkg install lz4"
alias tarD-lz4="tar --use-compress-program=lz4 -xvf archive.lz4 -C"

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
alias @pnpm-pkg-icons="pnpm i -D unplugin-auto-import unplugin-icons @iconify-json/material-symbols"
alias @pnpm-pkg-postcss="pnpm i -D postcss autoprefixer postcss-cli postcss-nested postcss-sorting"

alias @prettier="prettier --write '**/*.{html,css,js,ts,jsx,json}'"
alias @prettier-all="prettier --write '**/*.{html,css,scss,js,ts,jsx,vue,json,astro}'"

# Clean
alias @clean-apt="apt autoremove"
alias @clean-composer="composer clear-cache"
alias @clean-go="go clean -modcache"
alias @clean-npm="npm cache clean --force"
alias @clean-pnpm="pnpm store prune"

# Croc (share file)
alias @croc-unsafe="croc send --code hk2308"
alias @croc-safe="CROC_SECRET=hk2308 croc"
alias @croc-mode-classic="croc --classic"

### OTHERS --------------------------------------------------------------------

# Ssh
FILE_NAME="github1"

alias @ssh-agent-start='eval "$(ssh-agent -s)"'
alias @ssh-add-github="ssh-add ~/.ssh/${FILE_NAME}"
alias @ssh-github="@ssh-agent-start && @ssh-add-github"


# TTS
function now() {
  local datetime=$(date +"%m-%d_%H:%M:%S")
  echo "${datetime}"
}

audio_export="downloads/"
alias tts="edge-tts --voice es-PA-RobertoNeural --write-media ${audio_export}tts_$(now).mp3 --write-subtitles ${audio_export}tts_$(now).vtt --pitch=-15Hz --rate=+18% --text"

# alias vpy="python3 -m venv /path/to/venv && . /path/to/venv/bin/activate"
