#!/usr/bin/env bash

# Heading
# ------------------------------------------------------------------------------
printf "\n\033[35;4mGit\033[0m\n"

# Check prerequisites
# ------------------------------------------------------------------------------
printf "Checking for Git installation... "
if ! command -v git &> /dev/null; then
    printf "\033[31mNot found\033[0m\n\n"
    printf "Exiting.\n"
    [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit
else
    printf "\033[32mInstalled\033[0m\n"
fi

# Set the directory to the directory where the script is
# ------------------------------------------------------------------------------
DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Ask if the user wants to configure Git
# ------------------------------------------------------------------------------
printf "Would you like to install the Git configuration files? (y/N): "
read -r RESPONSE
case $RESPONSE in
    [yY])
        # Do nothing: Let the rest of the script run
        ;;
    *)
        printf "Git configuration not installed.\n"
        [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit 0
        ;;
esac

# Install Git configuration
# ------------------------------------------------------------------------------
printf "Configuring Git...\n"

printf "Removing any existing configuration... "
rm ~/.gitconfig
rm ~/.gitignore
printf "\033[32mDone\033[0m\n"

printf "Installing new configuration... "
cp $DIRECTORY/data/gitconfig ~/.gitconfig
cp $DIRECTORY/data/gitignore ~/.gitignore
printf "\033[32mDone\033[0m\n"

printf "What is the global git commit author's name?: "
read -r NAME
printf "What is the global git commit author's e-mail address?: "
read -r EMAIL

git config --global user.name "$NAME"
git config --global user.email "$EMAIL"

# Success message
# ------------------------------------------------------------------------------
printf "\033[32mGit configuration installed.\033[0m\n"
