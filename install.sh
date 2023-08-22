#!/usr/bin/env bash

# Clear the screen
# ------------------------------------------------------------------------------
printf "\033[2J"

# Heading
# ------------------------------------------------------------------------------
printf "\n\033[36;4mDotfiles\033[0m\n"
printf "Because \033[36m~\033[0m is where the ❤️ is.\n"
printf "==============================\n\n"

# Set the base directory to the directory where the script is
# ------------------------------------------------------------------------------
BASE_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Run each step in turn
# ------------------------------------------------------------------------------
printf "\033[35;4mPrerequisites\033[0m\n"
source $BASE_DIRECTORY/installers/command-line-tools/check.sh
source $BASE_DIRECTORY/installers/filesystem/install.sh
source $BASE_DIRECTORY/installers/git/install.sh
source $BASE_DIRECTORY/installers/oh-my-zsh/install.sh
source $BASE_DIRECTORY/installers/homebrew/install.sh

# Exit Cleanly
# ------------------------------------------------------------------------------
exit 0
