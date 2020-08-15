#!/usr/bin/env bash

# Information
# ------------------------------------------------------------------------------
printf "# -----------------------\n"
printf "# Oh My ZSH! Installation\n"
printf "# -----------------------\n"

# Set the directory to the directory where the script is
# ------------------------------------------------------------------------------
DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Check if brew has already been installed
# ------------------------------------------------------------------------------
printf "Checking for Oh My ZSH! installation... "
if [ ! -d ~/.oh-my-zsh ]; then
    printf "Not found\n"
    printf "Installing Oh My ZSH!...\n"

    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    printf "Already Installed\n"
fi

# Success message
# ------------------------------------------------------------------------------
printf "\nOh My ZSH! successfully installed.\n"
