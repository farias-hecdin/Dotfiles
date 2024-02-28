### Shortcut
alias q="exit"
alias e="nnn"
alias C="clear"
alias R="exec zsh"

### Change dir
alias .="cd ."
alias ..="cd .."
alias ...="cd ~/"

### App configuration
alias gconfig="nvim ~/.gitconfig"
alias nconfig="nvim ~/.config/nvim/init.lua"
alias tconfig="nvim ~/.tmux.conf"
alias zalias="nvim ~/.zsh/config/alia.zsh"
alias zconfig="nvim ~/.zshrc"

### App
alias pn="pnpm"
alias tr="tree -C"
alias fz="fzf -e"
alias ed="nvim"
alias ed-noplugin="nvim --noplugin"
alias zi="z -I ."
alias ds="gdu"
alias @fd="fd -H"

### Git
alias lg="lazygit"

alias gt="git"
alias gta="git add"
alias gtc="git clone"
alias gtlg="git log --graph --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%an%C(reset)%C(bold yellow)%d%C(reset) %C(dim white)- %s%C(reset)' --all"
alias gtrc="git remote set-url origin"
alias gtrv="git remote -v"

### Tmux
alias tx="tmux"
alias txl="tmux list-sessions"
alias txn="tmux new-session -s"
alias txk="tmux kill-server -t"
alias txa="tmux attach -t"

### Jump
alias jp="jump"
alias jpa="mark"
alias jpl="marks"
alias jpd="unmarks"

### Specials ------------------------------------------------------------------

# termux
alias @distro="proot-distro login"

# nanoid
alias @id="nanoid --alphabet abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 --size"
alias @idn="nanoid --alphabet 1234567890 --size"
alias @ids="nanoid --alphabet abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ --size"

# javascript
alias @js-server="five-server"
alias @postcss-opts="postcss --no-map --replace src/**/*.css --config ./opts/postcss.config.cjs"
alias @pnpm-pkgBase="pnpm i -D modern-normalize eruda postcss autoprefixer postcss-cli postcss-nested postcss-sorting unplugin-auto-import unplugin-icons @iconify-json/material-symbols"
alias @pnpm-pkgBaseReact="pnpm i -D modern-normalize eruda postcss autoprefixer postcss-cli postcss-nested postcss-sorting unplugin-auto-import unplugin-icons @iconify-json/material-symbols @svgr/core @svgr/plugin-jsx"

alias @prettier="prettier --write '**/*.{html,css,js,ts,jsx,json}'"
alias @prettier2="prettier --write '**/*.{html,css,scss,js,ts,jsx,vue,json,astro}'"

### Clean
alias @clean-apt="apt autoremove"
alias @clean-composer="composer clear-cache"
alias @clean-go="go clean -modcache"
alias @clean-npm="npm cache clean --force"
alias @clean-pnpm="pnpm store prune"

### tgpt
alias tgpt="tgpt -m --provider opengpts"
alias tgpt-phind="tgpt -m --provider phind"
alias tgpt-llama="tgpt -m --provider llama2"

### Other

# paq9a
alias @paq9al="paq9a l *.paq9a"
alias @paq9ax="paq9a x *.paq9a"

