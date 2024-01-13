#!/bin/bash

gray="\e[2m"
bold="\e[1m"
end="\e[0m"

### Objetivos
folder="GIT/"
# nvim
nvim_target="${HOME}/${folder}Dotfiles/NVIM/nvim/"
nvim_data="${HOME}/.config/nvim/"
# zsh
zsh_target="${HOME}/${folder}Dotfiles/ZSH/.zsh/"
zsh_data="${HOME}/.zsh/"
# tmux
tmux_target="${HOME}/${folder}Dotfiles/TMUX/tmux/"
tmux_data="${HOME}/.tmux.conf"
# lazygit
lazygit_target="${HOME}/${folder}Dotfiles/LAZYGIT/lazygit/"
lazygit_data="${HOME}/.config/lazygit/"

function func_move_data_to_directory() {
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

function func_main() {
  echo -e " ${bold}¿Quiero crear una copia de respaldo para?${end}"
  echo -e "  ${gray}[1] Nvim${end}"
  echo -e "  ${gray}[2] Zsh${end}"
  echo -e "  ${gray}[3] Tmux${end}"
  echo -e "  ${gray}[4] Lazygit${end}"
  echo -ne " "
  read -r option
  echo -e " "

  case $option in
    1) func_move_data_to_directory "$nvim_target" "$nvim_data" ;;
    2) func_move_data_to_directory "$zsh_target" "$zsh_data" ;;
    3) func_move_data_to_directory "$tmux_target" "$tmux_data" ;;
    4) func_move_data_to_directory "$lazygit_target" "$lazygit_data" ;;
    *) echo " Opción inválida" ;;
  esac
}

func_main
