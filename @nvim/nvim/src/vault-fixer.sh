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

TEST_FOLDERS=$(find $DIR -type d -name "test" -o -name "tests")
GIT_FOLDERS=$(find $DIR -type d -name ".git" -o -name ".github")
ASSET_FILES=$(find $DIR -type f -name "*.jpeg" -o -name "*.jpg" -o -name "*.png" -o -name "*.gif" -o -name "*.mp4")

# Delete the elements.
for ELEM in ${TEST_FOLDERS[@]} ${GIT_FOLDERS[@]} ${ASSET_FILES[@]}; do
  echo "#  Deleting: $ELEM"
  rm -rf $ELEM
  wait
done

# Print a success message.
echo ""
echo "#  Successfully deleted unwanted folders and files."
