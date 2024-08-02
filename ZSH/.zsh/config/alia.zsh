### Distro --------------------------------------------------------------------

alias proot-alpine="proot-distro login alpine"
alias alpine="termux-alpine"

### APP CONFIGURATION ---------------------------------------------------------

alias gconfig="$EDITOR ~/.gitconfig"
alias nconfig="$EDITOR ~/.config/nvim/init.lua"
alias tconfig="$EDITOR ~/.tmux.conf"
alias zalias="$EDITOR ~/.zsh/config/alia.zsh"
alias zconfig="$EDITOR ~/.zshrc"

### SHORTCUTS -----------------------------------------------------------------

alias fd="fd -H"
alias Ls="ls -a -F -h --color=always -v --time-style=long-iso"
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
alias ed-noPlugins="nvim --noplugin"
alias zi="z -I ."
alias ds="dua"
alias lg="lazygit"

# Git
alias gt="git"
alias gtc="git clone"
alias Git-add="git add"
alias Git-clone="git clone"
alias Git-merge="git merge --no-ff"
alias Git-branch-rename="git branch -m" # -> <old-name> <new-name>
alias Git-branch-rename-remote="git push origin" #. -> :<old-name> <new-name>
alias Git-remote-change="git remote set-url origin"
alias Git-remote-view="git remote -v"
alias Git-log="git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)' --all"

# Tmux
alias tx="tmux"
alias Tmux-list="tmux list-sessions"
alias Tmux-new-session="tmux new-session -s"
alias Tmux-kill-all="tmux kill-server"
alias Tmux-kill-this="tmux kill-server -t"
alias Tmux-attach="tmux attach -t"

# Nanoid
alias Id="nanoid --alphabet abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 --size"
alias Id-int="nanoid --alphabet 1234567890 --size"
alias Id-string="nanoid --alphabet abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ --size"

# Others
alias lua="luajit"
alias find-clones="fclones group"

### SPECIALS ------------------------------------------------------------------

# Hyperfine (benchmark)
alias Bm5="hyperfine -r 5 --warmup 5"
alias Bm25="hyperfine -r 25 --warmup 5"
alias Bm50="hyperfine -r 50 --warmup 5"
alias Bm100="hyperfine -r 100 --warmup 5"
alias Bm200="hyperfine -r 200 --warmup 5"

# Tar
alias Tar-gz="tar -xzf"
alias Tar-xz="tar -xvf"
alias Tar-lz4-c="tar --use-compress-program=lz4 -cvf archive.lz4" # Need: "pkg install lz4"
alias Tar-lz4-d="tar --use-compress-program=lz4 -xvf archive.lz4 -C"

# Build
alias Go-build='go build'
alias Go-build-min='go build -a -gcflags=all="-l -B" -ldflags="-w -s"'
alias Nim-build="nim c -d:release --hints:off"
alias Nim-build-min="nim c -d:release --opt:speed --passC:-flto --passL:-flto --panics:on"
alias Nim-build-end="nim c -d:release --opt:speed --passC:'-flto -ffast-math -fsingle-precision-constant' --passL:-flto --panics:on"

# Javascript
alias Js-server="five-server"
alias Postcss-opts="pnpm postcss --no-map --replace src/**/*.css --config ./opts/postcss.config.cjs"

alias Pnpm-add-base="pnpm i -D modern-normalize eruda"
alias Pnpm-add-extra="pnpm i -D @svgr/core @svgr/plugin-jsx"
alias Pnpm-add-icons="pnpm i -D unplugin-auto-import unplugin-icons @iconify-json/material-symbols"
alias Pnpm-add-postcss="pnpm i -D postcss autoprefixer postcss-cli postcss-nested postcss-sorting"

alias Prettier="prettier --write '**/*.{html,css,js,ts,jsx,json}'"
alias Prettier-all="prettier --write '**/*.{html,css,scss,js,ts,jsx,vue,json,astro}'"

# Clean
alias Clean-apt="apt autoremove && pkg clean"
alias Clean-composer="composer clear-cache"
alias Clean-go="go clean -modcache"
alias Clean-npm="npm cache clean --force"
alias Clean-pnpm="pnpm store prune"

# Croc (share file)
alias Croc-unsafe="croc send --code hk2308"
alias Croc-safe="CROC_SECRET=hk2308 croc"
alias Croc-mode-classic="croc --classic"

### OTHERS --------------------------------------------------------------------

# Termux
alias Add="pkg install"
alias Del="pkg uninstall"
alias Search="pkg search"
alias Installed="pkg list-installed"
alias Upgradable="apt list --upgradable"

# Ssh
FILE_NAME="github1"

alias Ssh-agent-start='eval "$(ssh-agent -s)"'
alias Ssh-add-github="ssh-add ~/.ssh/${FILE_NAME}"
alias Ssh-github="@ssh-agent-start && @ssh-add-github"


# TTS
function now() {
  local datetime=$(date +"%m-%d_%H:%M:%S")
  echo "${datetime}"
}

audio_export="downloads/"
alias tts="edge-tts --voice es-PA-RobertoNeural --write-media ${audio_export}tts_$(now).mp3 --write-subtitles ${audio_export}tts_$(now).vtt --pitch=-15Hz --rate=+18% --text"

# alias vpy="python3 -m venv /path/to/venv && . /path/to/venv/bin/activate"
