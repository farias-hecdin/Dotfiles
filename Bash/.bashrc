# ============================================================================
# PROMPT PERSONALIZADO PARA BASH (Sin Oh My Zsh)
# ============================================================================

# Limita la longitud de las rutas largas (ej. convierte /a/b/c/d en .../c/d)
PROMPT_DIRTRIM=3

# Función que construye el prompt dinámicamente
__build_prompt() {
    # 1. CAPTURAR EL CÓDIGO DE ERROR SIEMPRE EN LA PRIMERA LÍNEA
    local EXIT_CODE=$?

    # 2. DEFINIR COLORES (Bash requiere \[ y \] alrededor de secuencias no imprimibles)
    local RESET="\[\033[0m\]"
    local RED="\[\033[31m\]"
    local GREEN="\[\033[32m\]"
    local YELLOW="\[\033[33m\]"
    local BLUE="\[\033[34m\]"
    local CYAN="\[\033[36m\]"
    local WHITE="\[\033[37m\]"

    # 3. LÓGICA DE USUARIO Y HOST
    local user_color=$GREEN
    # $EUID es 0 si eres root
    if [[ $EUID -eq 0 ]]; then
        user_color=$RED
    fi

    local host_color=$GREEN
    # Detectar si estamos conectados por SSH
    if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
        host_color=$RED
    fi

    local PR_PROMPT="${user_color}▶${RESET}"
    local USER_HOST="${user_color}\u${CYAN}@${host_color}\h${RESET}"
    local DIR="${BLUE}\w${RESET}"

    # 4. LÓGICA DE GIT MANUAL (Sustituye a Oh My Zsh)
    local GIT_LINE=""
    # Comprobar rápido si es un repositorio Git
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        # Obtener el nombre de la rama
        local branch
        branch=$(git branch --show-current 2>/dev/null)
        # Fallback por si la versión de Git es antigua
        [[ -z "$branch" ]] && branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)

        # Comprobar si hay cambios sin confirmar (Dirty/Clean)
        local status_icon="${WHITE}✓${RESET}" # Limpio
        if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
            status_icon="${RED}✗${RESET}" # Modificado
        fi

        GIT_LINE="\n ${YELLOW} ${branch} ${status_icon}"
    fi

    # 5. LÓGICA DE RPROMPT (Simulación del prompt derecho de Zsh para el código de salida)
    local RIGHT_PROMPT=""
    if [[ $EXIT_CODE -ne 0 ]]; then
        local err_str="${EXIT_CODE}  "
        # Truco de Bash: Guardar posición (\e[s), ir a la derecha (\e[XXXG), regresar margen (\e[XXXD), imprimir, y restaurar (\e[u)
        local move_left=$(( ${#err_str} + 1 ))
        RIGHT_PROMPT="\[\033[s\033[${COLUMNS}G\033[${move_left}D\033[31m\]${err_str}\[\033[0m\033[u\]"
    fi

    # 6. CONSTRUIR EL PS1 FINAL
    # \u = usuario, \h = host, \w = ruta
    PS1="${RIGHT_PROMPT} ${USER_HOST}\n󰉋 ${DIR}${GIT_LINE}\n╰─${PR_PROMPT} "
}

# Ejecutar la función __build_prompt cada vez que se va a mostrar una nueva línea
PROMPT_COMMAND=__build_prompt

