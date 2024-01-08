#!/bin/bash

gray="\e[2m"
bold="\e[1m"
end="\e[0m"

# Objetivos
nvim_target="${HOME}/GIT/Dotfiles/NVIM/nvim/"
nvim_data="${HOME}/.config/nvim/"
zsh_target="${HOME}/GIT/Dotfiles/ZSH/.zsh/"
zsh_data="${HOME}/.zsh/"

function move_data_to_directory() {
  local target="$1"
  local data="$2"

  # Comprobamos si el directorio A existe
  if [ -d "$target" ]; then
    # Borramos el contenido del directorio A
    echo -e " ${bold}Borrando el contenido del directorio ${end}:"
    echo -e " ${gray}${target}${end}"
    rm -rf "${target}"
    # Movemos el directorio B dentro del directorio A
    echo -e " ${bold}Copiando el directorio ${end}:"
    echo -e " ${gray}${data}${end}"
    cp -r "${data}" "$target"
  else
    echo -e " El directorio no existe"
  fi
}

function main() {
  echo -e " ¿Quiero crear una copia de respaldo para?"
  echo -e "   ${gray}1) Nvim${end}"
  echo -e "   ${gray}2) Zsh${end}"
  echo -ne " "
  read -r option
  echo -e " "

  case $option in
    1) move_data_to_directory "$nvim_target" "$nvim_data" ;;
    2) move_data_to_directory "$zsh_target" "$zsh_data" ;;
    *) echo " Opción inválida" ;;
  esac
}

main
