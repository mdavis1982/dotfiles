# Install message
# ------------------------------------------------------------------------------
printf "Creating standard folders..."

# Set the directory to the directory where the script is
# ------------------------------------------------------------------------------
DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Install
# ------------------------------------------------------------------------------
# -- ~/Code folder with icon
mkdir -p ~/Code
$DIRECTORY/../../utilities/set-icon.applescript "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/DeveloperFolderIcon.icns" ~/Code >& /dev/null

# -- ~/Code/Other folder with icon
mkdir -p ~/Code/Other
$DIRECTORY/../../utilities/set-icon.applescript "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/UtilitiesFolder.icns" ~/Code/Other >& /dev/null

# -- ~/Code/Sites folder with icon
mkdir -p ~/Code/Sites
$DIRECTORY/../../utilities/set-icon.applescript "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/SitesFolderIcon.icns" ~/Code/Sites >& /dev/null

# Success message
# ------------------------------------------------------------------------------
printf "Done\n"
