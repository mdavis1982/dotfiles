#!/usr/bin/env bash

# Heading
# ------------------------------------------------------------------------------
printf "\n\033[35;4mClaude Code\033[0m\n"

# Check prerequisites
# ------------------------------------------------------------------------------
printf "Checking for Claude Code installation... "
if ! command -v claude &> /dev/null; then
    printf "\033[31mNot found\033[0m\n\n"
    printf "Exiting.\n"
    [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit
else
    printf "\033[32mInstalled\033[0m\n"
fi

# Set the directory to the directory where the script is
# ------------------------------------------------------------------------------
DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Ask if the user wants to configure Claude Code
# ------------------------------------------------------------------------------
printf "Would you like to install the Claude Code configuration files? (y/N): "
read -r RESPONSE
case $RESPONSE in
    [yY])
        # Do nothing: Let the rest of the script run
        ;;
    *)
        printf "Claude Code configuration not installed.\n"
        [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit 0
        ;;
esac

# Install Claude Code configuration
# ------------------------------------------------------------------------------
printf "Configuring Claude Code...\n"

printf "Removing any existing configuration... "
rm -f ~/.claude/CLAUDE.md
rm -f ~/.claude/settings.json
rm -f ~/.claude/statusline.sh
rm -rf ~/.claude/skills
printf "\033[32mDone\033[0m\n"

printf "Installing new configuration... "
cp $DIRECTORY/data/global/CLAUDE.md ~/.claude/CLAUDE.md
cp $DIRECTORY/data/global/settings.json ~/.claude/settings.json
cp $DIRECTORY/data/global/statusline.sh ~/.claude/statusline.sh
cp -r $DIRECTORY/data/global/skills ~/.claude/skills
printf "\033[32mDone\033[0m\n"

# Install MCP servers into ~/.claude.json
# ------------------------------------------------------------------------------
MCP_FILE=$DIRECTORY/data/global/mcp.json
MCP_JSON=$(cat "$MCP_FILE")
CURRENT_SERVER=""

while IFS=$'\t' read -r SERVER FIELD KEY <&3; do
    if [[ "$SERVER" != "$CURRENT_SERVER" ]]; then
        [[ -z "$CURRENT_SERVER" ]] && printf "\nConfiguring MCP server secrets...\n"
        CURRENT_SERVER="$SERVER"
        printf "\n  \033[4m%s\033[0m\n" "$SERVER"
    fi

    EXISTING=$(jq -r --arg s "$SERVER" --arg f "$FIELD" --arg k "$KEY" \
        '.mcpServers[$s][$f][$k] // ""' ~/.claude.json 2>/dev/null)

    if [[ -n "$EXISTING" && ! "$EXISTING" =~ ^\$\{ ]]; then
        printf "    \033[33m%s\033[0m is already set. Keep existing value? (Y/n): " "$KEY"
        read -r RESPONSE
        case $RESPONSE in
            [nN])
                printf "    Enter new value for \033[33m%s\033[0m: " "$KEY"
                read -rs VALUE
                printf "\n"
                ;;
            *)
                VALUE="$EXISTING"
                ;;
        esac
    else
        printf "    Enter value for \033[33m%s\033[0m: " "$KEY"
        read -rs VALUE
        printf "\n"
    fi

    MCP_JSON=$(echo "$MCP_JSON" | jq --arg s "$SERVER" --arg f "$FIELD" --arg k "$KEY" --arg v "$VALUE" \
        '.mcpServers[$s][$f][$k] = $v')
done 3< <(jq -r '
    .mcpServers | to_entries[] |
    .key as $server |
    ("env", "headers") as $field |
    .value[$field] // {} | to_entries[] |
    select(.value | test("\\$\\{")) |
    "\($server)\t\($field)\t\(.key)"
' "$MCP_FILE" 2>/dev/null)

printf "Installing MCP servers... "
TEMP=$(mktemp)
jq --argjson servers "$(echo "$MCP_JSON" | jq '.mcpServers')" \
    '.mcpServers = $servers' ~/.claude.json > "$TEMP" && mv "$TEMP" ~/.claude.json
printf "\033[32mDone\033[0m\n"

# Success message
# ------------------------------------------------------------------------------
printf "\033[32mClaude Code configuration installed.\033[0m\n"
