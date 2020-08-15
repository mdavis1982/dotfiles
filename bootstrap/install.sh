#!/usr/bin/env bash

# Information
# ------------------------------------------------------------------------------
printf "# ---------------------\n"
printf "# Bootstrap\n"
printf "# ---------------------\n\n"
printf "This script will bootstrap the machine.\n\n"

# Set the directory to the directory where the script is
# ------------------------------------------------------------------------------
BASE_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Install each section in turn
# ------------------------------------------------------------------------------
source $BASE_DIRECTORY/command-line-tools/check.sh
source $BASE_DIRECTORY/homebrew/install.sh

# Install stuff from the "Other" directory
# -------------------------------------------------------------------------------
source $BASE_DIRECTORY/other/pure-prompt.sh
