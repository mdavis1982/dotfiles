#!/usr/bin/env bash

# Information
# ------------------------------------------------------------------------------
printf "# -----------------------\n"
printf "# Command Line Tools\n"
printf "# -----------------------\n"

# Set the directory to the directory where the script is
# ------------------------------------------------------------------------------
DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Check if brew has already been installed
# ------------------------------------------------------------------------------
printf "Checking for command line tools... "
if [ ! -d "$( xcode-select -p )" ]; then
    printf "Not found\n"
    printf "You must install command line tools before bootstrapping!\n\n"
    printf "You can do this with: xcode-select --install\n\n"

    exit 0
else
    printf "Already Installed!\n"
fi
