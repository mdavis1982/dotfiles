#!/usr/bin/env bash

# Information
# ------------------------------------------------------------------------------
printf "# -----------------------\n"
printf "# Oh My ZSH! Installation\n"
printf "# -----------------------\n"

# Set the directory to the directory where the script is
# ------------------------------------------------------------------------------
DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Check if the ~/.oh-my-zsh directory exists
# ------------------------------------------------------------------------------
if ! [ -d ~/.oh-my-zsh ]; then
    printf "Oh My ZSH! has not been installed.\n"

    exit 0
fi

# Check if the required files are already in place and, if so, ask if we should
# remove them
# ------------------------------------------------------------------------------
CONTINUE=true
if [ -e ~/.zshrc ] || [ -e ~/.oh-my-zsh/custom/git.zsh ] || [ -e ~/.oh-my-zsh/custom/laravel.zsh ] || [ -e ~/.oh-my-zsh/custom/path.zsh ] || [ -e ~/.oh-my-zsh/custom/pure-prompt.zsh ]; then
    printf "Some files would be overwritten installing Oh My ZSH! config. Continue? (y/N): "
    read -r RESPONSE
    case $RESPONSE in
        [yY])
            printf "Removing ~/.zshrc..."
            rm ~/.zshrc
            printf "Done\n"

            printf "Removing ~/.oh-my-zsh/custom/git.zsh... "
            rm ~/.oh-my-zsh/custom/git.zsh
            printf "Done\n"

            printf "Removing ~/.oh-my-zsh/custom/laravel.zsh... "
            rm ~/.oh-my-zsh/custom/laravel.zsh
            printf "Done\n"

            printf "Removing ~/.oh-my-zsh/custom/path.zsh... "
            rm ~/.oh-my-zsh/custom/path.zsh
            printf "Done\n"

            printf "Removing ~/.oh-my-zsh/custom/pure-prompt.zsh... "
            rm ~/.oh-my-zsh/custom/pure-prompt.zsh
            printf "Done\n"
            ;;
        *)
            CONTINUE=false
            ;;
    esac
fi

if ! $CONTINUE; then
    printf "Nothing installed\n\n"
    exit 0
fi

# Copy configuration file
# ------------------------------------------------------------------------------
cp $DIRECTORY/data/zshrc ~/.zshrc
cp $DIRECTORY/data/custom/git.zsh ~/.oh-my-zsh/custom/git.zsh
cp $DIRECTORY/data/custom/laravel.zsh ~/.oh-my-zsh/custom/laravel.zsh
cp $DIRECTORY/data/custom/path.zsh ~/.oh-my-zsh/custom/path.zsh
cp $DIRECTORY/data/custom/pure-prompt.zsh ~/.oh-my-zsh/custom/pure-prompt.zsh

# Success message
# ------------------------------------------------------------------------------
printf "\nOh My ZSH! settings successfully installed\n\n"
