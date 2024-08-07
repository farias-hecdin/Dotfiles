#!/bin/bash
# MIT License Copyright (c) 2023 Hecdin Farias
#
# This script removes unwanted files and folders from the Vault folder.

set -o errexit
set -o nounset
set -o pipefail

gray="\e[37m"
bold="\e[1m"
end="\e[0m"

### Get the current directory.
DIR=$(pwd)
list=()

### Find all folders and files in the current directory and its subdirectories.
list+=($(find "$DIR" -type f -name "*.jpeg" \
  -o -name ".git" \
  -o -name ".github" \
  -o -name ".gitignore" \
  -o -name "_test" \
  -o -name "test" \
  -o -name "tests" \
  -o -name "*.log" \
  -o -name "*.css" \
  -o -name "*.gif" \
  -o -name "*.html" \
  -o -name "*.jpg" \
  -o -name "*.mp4" \
  -o -name "*.png" \
  -o -name "*.toml" \
  -o -name "*.yml" \
  -o -name ".editorconfig" \
  -o -name ".gitattributes" \
  -o -name ".luacheckrc" \
  -o -name ".luarc.json" \
  -o -name ".npmrc" \
  -o -name ".pre-commit-config.yaml" \
  -o -name ".themisrc" \
  -o -name ".vimrc" \
  -o -name "CHANGELOG.md" \
  -o -name "TODO.md" \
  -o -name "CONTRIBUTING.md" \
  -o -name "Makefile" \
  -o -name ".styluaignore" \
  -o -name ".rockspec" \
  -o -name ".lua-format" \
))

if [[ ${#list[@]} -gt 0 ]]; then
  echo -e "  ${bold}Deleting: ${end}"
  # Delete the elements.
  for elem in "${list[@]}"; do
    echo -e "  ${gray}$elem ${end}"
    rm -rf "$elem"
    wait
  done
  echo ""
fi

### Print a success message.
echo -e "  ${bold}Successfully deleted unwanted folders and files.${end}"
