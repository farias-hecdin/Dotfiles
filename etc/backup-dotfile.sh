#!/bin/bash

# --- Colors and Styles ---
gray="\e[2m"
bold="\e[1m"
red="\e[31m"
green="\e[32m"
yellow="\e[33m"
blue="\e[34m"
purple="\e[35m"
cyan="\e[36m"
end="\e[0m"

# --- Directories ---
folder="Hecdin/_Git/"
# nvim
nvim_target="${HOME}/${folder}Dotfiles/Nvim/nvim/"
nvim_data="${HOME}/.config/nvim/"
# zsh
zsh_target="${HOME}/${folder}Dotfiles/Zsh/.zsh/"
zsh_data="${HOME}/.zsh/"
# tmux
tmux_target="${HOME}/${folder}Dotfiles/Tmux/"
tmux_data="${HOME}/.tmux.conf"
# lazygit
lazygit_target="${HOME}/${folder}Dotfiles/Lazygit/lazygit/"
lazygit_data="${HOME}/.config/lazygit/"

# --- Functions ---

# Function to move data to target directory (overwrite)
f_move_to_dir() {
  local target="$1"
  local data="$2"
  local name="$3" # Name for better messages

  echo -e "${bold}Operación:${end} Mover ${cyan}${name}${end}"

  # Check if target directory exists
  if ! [ -d "$target" ]; then
    echo -e "  ${red}Error:${end} El directorio destino ${cyan}${target}${end} no existe."
    return 1
  fi

  # Check if data exists
  if ! [ -e "$data" ]; then
    echo -e "  ${red}Error:${end} Los datos fuente ${cyan}${data}${end} no existen."
    return 1
  fi

  # Confirm overwrite
  read -r -p "  ${yellow}Advertencia:${end} ¿Seguro que quieres ${bold}REEMPLAZAR${end} el contenido de ${cyan}${target}${end} con ${cyan}${data}${end}? (s/n) " confirm
  if [[ "$confirm" != "s" ]]; then
    echo -e "  ${yellow}Operación cancelada por el usuario.${end}"
    return 0
  fi

  # Delete content of target directory
  echo -e "  ${bold}Borrando el contenido del directorio destino:${end}"
  echo -e "   ${gray}${target}${end}"
  rm -rf "${target}/*" # Delete only content, keep directory itself

  # Copy data directory to target directory
  echo -e "  ${bold}Copiando datos desde:${end}"
  echo -e "   ${gray}${data}${end}"
  echo -e "  ${bold}Hacia:${end}"
  echo -e "   ${gray}${target}${end}"
  cp -r "${data}/." "$target" # Copy content of data, not the data directory itself.

  echo -e "  ${green}Operación 'Mover' completada para ${cyan}${name}${end}.${end}"
  return 0
}

# Function to copy data to target directory (backup)
f_copy_to_dir() {
  local target="$1"
  local data="$2"
  local name="$3" # Name for better messages

  echo -e "${bold}Operación:${end} Copiar ${cyan}${name}${end} (Backup)"

  # Check if target directory exists
  if ! [ -d "$target" ]; then
    echo -e "  ${red}Error:${end} El directorio destino ${cyan}${target}${end} no existe."
    return 1
  fi

  # Check if data exists
  if ! [ -e "$data" ]; then
    echo -e "  ${red}Error:${end} Los datos fuente ${cyan}${data}${end} no existen."
    return 1
  fi

  # Confirm copy
  read -r -p "  ¿Seguro que quieres ${bold}COPIAR${end} el contenido de ${cyan}${data}${end} a ${cyan}${target}${end}? (s/n) " confirm
  if [[ "$confirm" != "s" ]]; then
    echo -e "  ${yellow}Operación cancelada por el usuario.${end}"
    return 0
  fi

  # Copy data directory to target directory
  echo -e "  ${bold}Copiando datos desde:${end}"
  echo -e "   ${gray}${data}${end}"
  echo -e "  ${bold}Hacia:${end}"
  echo -e "   ${gray}${target}${end}"
  cp -r "${data}/." "$target" # Copy content of data, not the data directory itself.

  echo -e "  ${green}Operación 'Copiar' completada para ${cyan}${name}${end}.${end}"
  return 0
}

# Function to install packages using pkg
f_install_pkg_packages() {
  local packages=("$@")
  echo -e "${bold}Operación:${end} Instalando paquetes con ${cyan}pkg install${end}"

  if ! command -v pkg &> /dev/null
  then
    echo -e "  ${red}Error:${end} Comando 'pkg' no encontrado. Asegúrate de que pkg esté instalado y en tu PATH."
    return 1
  fi

  for package in "${packages[@]}"; do
    if ! pkg info "$package" > /dev/null 2>&1; then
      echo -e "  Paquete ${cyan}${package}${end} no instalado. Instalando..."
      if ! sudo pkg install -y "$package"; then
        echo -e "  ${red}Error:${end} Falló la instalación del paquete ${cyan}${package}${end}."
        return 1
      else
        echo -e "  ${green}Paquete ${cyan}${package}${end} instalado correctamente.${end}"
      fi
    else
      echo -e "  Paquete ${cyan}${package}${end} ya está instalado."
    fi
  done
  echo -e "  ${green}Instalación de paquetes 'pkg' completada.${end}"
  return 0
}

# Function to install packages using pnpm
f_install_pnpm_packages() {
  local packages=("$@")
  echo -e "${bold}Operación:${end} Instalando paquetes con ${cyan}pnpm i -g${end}"

  if ! command -v pnpm &> /dev/null
  then
    echo -e "  ${red}Error:${end} Comando 'pnpm' no encontrado. Asegúrate de que pnpm esté instalado y en tu PATH."
    return 1
  fi

  for package in "${packages[@]}"; do
    if ! pnpm list -g "$package" > /dev/null 2>&1; then
      echo -e "  Paquete global ${cyan}${package}${end} no instalado. Instalando..."
      if ! pnpm i -g "$package"; then
        echo -e "  ${red}Error:${end} Falló la instalación del paquete global ${cyan}${package}${end}."
        return 1
      else
        echo -e "  ${green}Paquete global ${cyan}${package}${end} instalado correctamente.${end}"
      fi
    else
      echo -e "  Paquete global ${cyan}${package}${end} ya está instalado."
    fi
  done
  echo -e "  ${green}Instalación de paquetes 'pnpm' completada.${end}"
  return 0
}


# --- Main Function ---
f_main() {
  echo -e "${bold}¿Qué quieres hacer?${end}"
  echo -e "  ${gray}[1]${end} Mover (Reemplazar) configuración de Nvim"
  echo -e "  ${gray}[2]${end} Mover (Reemplazar) configuración de Zsh"
  echo -e "  ${gray}[3]${end} Mover (Reemplazar) configuración de Tmux"
  echo -e "  ${gray}[4]${end} Mover (Reemplazar) configuración de Lazygit"
  echo -e "  ${gray}[5]${end} Copiar (Backup) configuración de Nvim"
  echo -e "  ${gray}[6]${end} Copiar (Backup) configuración de Zsh"
  echo -e "  ${gray}[7]${end} Copiar (Backup) configuración de Tmux"
  echo -e "  ${gray}[8]${end} Copiar (Backup) configuración de Lazygit"
  echo -e "  ${gray}[9]${end} Instalar paquetes con ${cyan}pkg install${end} (clang neovim fzf)"
  echo -e "  ${gray}[10]${end} Instalar paquetes con ${cyan}pnpm i -g${end} (nanoid vite)"
  echo -ne "  ${bold}Selecciona una opción:${end} "
  read -r option
  echo -e ""

  case $option in
    1) f_move_to_dir "$nvim_target" "$nvim_data" "Nvim" ;;
    2) f_move_to_dir "$zsh_target" "$zsh_data" "Zsh" ;;
    3) f_move_to_dir "$tmux_target" "$tmux_data" "Tmux" ;;
    4) f_move_to_dir "$lazygit_target" "$lazygit_data" "Lazygit" ;;
    5) f_copy_to_dir "$nvim_target" "$nvim_data" "Nvim" ;;
    6) f_copy_to_dir "$zsh_target" "$zsh_data" "Zsh" ;;
    7) f_copy_to_dir "$tmux_target" "$tmux_data" "Tmux" ;;
    8) f_copy_to_dir "$lazygit_target" "$lazygit_data" "Lazygit" ;;
    9) f_install_pkg_packages clang neovim fzf ;;
    10) f_install_pnpm_packages nanoid vite ;;
    *) echo "  ${red}Opción inválida.${end}" ;;
  esac
}

# --- Run Main Function ---
f_main
