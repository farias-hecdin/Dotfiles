#!/bin/bash
# MIT License Copyright (c) 2023 Hecdin Farias
#
# This script removes unwanted files and folders from the Vault folder.

# Module setup ----------------------------------------------------------------
set -o errexit
set -o nounset
set -o pipefail

# Module config ---------------------------------------------------------------

# Get the current directory.
DIR=$(pwd)

# Find all folders and files in the current directory and its subdirectories.
list_folders=$(find $DIR -type d -name "test" \
  -o -name ".git" \
  -o -name ".github" \
  -o -name "_test" \
  -o -name "test" \
  -o -name "tests" \
)
list_files=$(find $DIR -type f -name "*.jpeg" \
  -o -name "*.gif" \
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
  -o -name ".themisrc" \
  -o -name ".vimrc" \
  -o -name "Makefile" \
  -o -name "CHANGELOG.md" \
  -o -name "TODO.md" \
  -o -name "CONTRIBUTING.md" \
  -o -name ".pre-commit-config.yaml" \
)

# Delete the elements.
for ELEM in ${list_folders[@]} ${list_files[@]}; do
  echo "#  Deleting: ${ELEM}"
  rm -rf ${ELEM}
  wait
done

# Print a success message.
echo ""
echo "#  Successfully deleted unwanted folders and files."
