source ~/.bash/config/keybinding.bash
source ~/.bash/config/utils.bash
source ~/.bash/config/alias.bash
source ~/.bash/config/theme.bash

### BASH INIT -----------------------------------------------------------------

export PATH="$HOME/bin:/usr/local/bin:$PATH"

# Reemplazamos $ZSH por una carpeta equivalente para Bash
export BASH_DIR="$HOME/.bash"

# (Nota: KEYTIMEOUT=1 es exclusivo de Zsh (vi-mode). En Bash, esto se
# configura en el archivo ~/.inputrc con "set keyseq-timeout 1")

# Specifies the $EDITOR code
if command -v nvim &> /dev/null; then
  export EDITOR=nvim
elif command -v micro &> /dev/null; then
  export EDITOR=micro
else
  export EDITOR=nano
fi

### HISTORY CONFIG ------------------------------------------------------------

export HISTFILE="$BASH_DIR/.bash_history"
export HISTSIZE=999     # Cuántos comandos carga Bash en la memoria.
export HISTFILESIZE=999 # Cuántos comandos se guardan en el archivo (Reemplaza a SAVEHIST).

# ignoreboth = ignora comandos que empiezan con espacio e ignora duplicados seguidos.
# erasedups = borra duplicados antiguos en todo el historial.
export HISTCONTROL=ignoreboth:erasedups

# Equivalente a EXTENDED_HISTORY (Agrega fecha y hora al historial)
export HISTTIMEFORMAT="%F %T "

# shopt (Shell Options) de Bash
shopt -s histappend # Añade al historial en lugar de sobrescribirlo.

# Equivalente a INC_APPEND_HISTORY_TIME (Guarda el comando inmediatamente después de ejecutarlo).
# Como en Bash usamos PROMPT_COMMAND para dibujar el prompt, le decimos que también guarde el historial.
PROMPT_COMMAND="${PROMPT_COMMAND:-}; history -a"

### PLUGINS --------------------------------------------------------

# z.lua (Asegúrate de cambiar la ruta de .zsh a .bash o donde lo tengas)
export NNN_ZLUA="$BASH_DIR/plugins/z.lua/z.lua"
# # CAMBIO IMPORTANTE: Inicializamos para "bash" en lugar de "zsh"
eval "$(luajit "$BASH_DIR/plugins/z.lua/z.lua" --init bash once)"

### EXPORT --------------------------------------------------------------------

LOCAL_SHARE="/data/data/com.termux/files/home/.local/share"

# fzf
export FZF_DEFAULT_OPTS="--height 90% --layout=reverse --border"
# fzf end

# pnpm
export PNPM_HOME="/data/data/com.termux/files/home/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# nnn
export NNN_PLUG="j:autojump;"
# nnn end

# golang
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
# golang end

# other
export PATH="$LOCAL_SHARE/luatiny:$PATH"
export PATH="$LOCAL_SHARE/XMLmin:$PATH"

