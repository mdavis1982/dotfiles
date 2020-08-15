#!/usr/bin/env bash

# Information
# ------------------------------------------------------------------------------
printf "# --------------------\n"
printf "# Git Configuration\n"
printf "# Installation\n"
printf "# --------------------\n"

# Set the directory to the directory where the script is
# ------------------------------------------------------------------------------
DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Check if the required files are already in place and, if so, ask if we should
# remove them
# ------------------------------------------------------------------------------
CONTINUE=true
if [ -e ~/.gitconfig ] || [ -e ~/.gitignore ]; then
    printf "Some files would be overwritten installing Git config. Continue? (y/N): "
    read -r RESPONSE
    case $RESPONSE in
        [yY])
            printf "Removing ~/.gitconfig... "
            rm ~/.gitconfig
            printf "Done\n"
            printf "Removing ~/.gitignore... "
            rm ~/.gitignore
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


# Copy the required files
# ------------------------------------------------------------------------------
cp $DIRECTORY/data/gitconfig ~/.gitconfig
cp $DIRECTORY/data/gitignore ~/.gitignore

# Set up user and e-mail address
# ------------------------------------------------------------------------------
printf "What is the global git commit author's name?: "
read -r NAME
printf "What is the global git commit author's e-mail address?: "
read -r EMAIL

git config --global user.name "$NAME"
git config --global user.email "$EMAIL"

# Success message
# ------------------------------------------------------------------------------
printf "\nGit configuration successfully installed\n\n"
