#!/usr/bin/env bash

# Information
# ------------------------------------------------------------------------------
printf "# -----------------------\n"
printf "# Homebrew\n"
printf "# -----------------------\n"

# Set the directory to the directory where the script is
# ------------------------------------------------------------------------------
DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Check if brew has already been installed
# ------------------------------------------------------------------------------
printf "Checking for homebrew installation... "
if ! command -v brew &> /dev/null; then
    printf "Not found\n"
    printf "Installing homebrew...\n"

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
    printf "Already Installed\n"
fi

# Let's brew
# ------------------------------------------------------------------------------
brew bundle install --file=$DIRECTORY/Brewfile --no-lock
brew cleanup

# Success message
# ------------------------------------------------------------------------------
printf "\nHomebrew successfully brewed\n\n"
