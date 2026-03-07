# [ESC] - Ir al principio de la línea (Equivalente a \033)
bind '"\e": beginning-of-line'

# [Escribir + Arriba] - Autocompletar historial según lo que ya escribiste
# (Equivalente exacto a up-line-or-beginning-search de Zsh)
bind '"\e[A": history-search-backward'

# [Escribir + Abajo] - Autocompletar historial hacia adelante
bind '"\e[B": history-search-forward'

# [Inicio / Home] - Ir al principio de la línea
bind '"\e[1~": beginning-of-line'

# [Fin / End] - Ir al final de la línea
bind '"\e[4~": end-of-line'

# [Ctrl+Derecha] - Avanzar una palabra
bind '"\e[1;5C": forward-word'

# [Ctrl+Izquierda] - Retroceder una palabra
bind '"\e[1;5D": backward-word'

# [Ctrl+e] - Usar $EDITOR para escribir/editar un comando
# (En Bash esta función nativa abre tu $EDITOR y ejecuta al guardar)
bind '"\C-e": edit-and-execute-command'

