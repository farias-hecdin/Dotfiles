#!/bin/bash

gray="\e[2m"
bold="\e[1m"
end="\e[0m"

### Directorio objetivo
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

function f_move_to_dir() {
  local target="$1"
  local data="$2"
  # Comprobamos si el directorio A existe
  if ! [ -d "$target" ]; then
    echo -e " El directorio no existe"
  else
    # Borramos el contenido del directorio A
    echo -e " ${bold}Borrando el contenido del directorio ${end}:"
    echo -e " ${gray}${target}${end}"
    rm -rf "${target}"
    # Movemos el directorio B dentro del directorio A
    echo -e " ${bold}Copiando el directorio ${end}:"
    echo -e " ${gray}${data}${end}"
    cp -r "${data}" "$target"
  fi
}

function f_main() {
  echo -e " ${bold}¿Quiero crear una copia de respaldo para?${end}"
  echo -e "  ${gray}[1] Nvim${end}"
  echo -e "  ${gray}[2] Zsh${end}"
  echo -e "  ${gray}[3] Tmux${end}"
  echo -e "  ${gray}[4] Lazygit${end}"
  echo -ne " "
  read -r option
  echo -e " "

  case $option in
    1) f_move_to_dir "$nvim_target" "$nvim_data" ;;
    2) f_move_to_dir "$zsh_target" "$zsh_data" ;;
    3) f_move_to_dir "$tmux_target" "$tmux_data" ;;
    4) f_move_to_dir "$lazygit_target" "$lazygit_data" ;;
    *) echo " Opción inválida" ;;
  esac
}

f_main
