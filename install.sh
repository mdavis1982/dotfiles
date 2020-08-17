#!/usr/bin/env bash

# Clear the screen
# ------------------------------------------------------------------------------
printf "\033[2J"

# Heading
# ------------------------------------------------------------------------------
printf "\n\033[36;4mDotfiles\033[0m\n"
printf "Because \033[36m~\033[0m is where the ❤️  is.\n"
printf "==============================\n\n"

# Set the base directory to the directory where the script is
# ------------------------------------------------------------------------------
BASE_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Run each step in turn
# ------------------------------------------------------------------------------
source $BASE_DIRECTORY/bootstrap/command-line-tools/check.sh
source $BASE_DIRECTORY/bootstrap/homebrew/install.sh
source $BASE_DIRECTORY/bootstrap/oh-my-zsh/install.sh

source $BASE_DIRECTORY/bootstrap/laravel/install.sh
source $BASE_DIRECTORY/bootstrap/filesystem/install.sh

# Exit Cleanly
# ------------------------------------------------------------------------------
exit 0
