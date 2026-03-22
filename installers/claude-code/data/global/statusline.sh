#!/bin/bash

# Claude Code Statusline
# ======================
# A custom statusline for Claude Code by Matthew Davis
# ------------------------------------------------------------------------------

# Colors
COLOR_RESET='\033[00m'
COLOR_CYAN_BOLD='\033[01;36m'
COLOR_GREY_BOLD='\033[01;90m'
COLOR_GREY='\033[00;90m'
COLOR_RED='\033[00;31m'
COLOR_YELLOW='\033[00;33m'
COLOR_GREEN='\033[00;32m'

# Git status icons
GIT_DIRTY=" ${COLOR_RED}✖︎${COLOR_RESET}"
GIT_CLEAN=" ${COLOR_GREEN}●${COLOR_RESET}"

# Format token count with SI suffix (e.g. 10.2k, 1.5M)
fmt_tokens() {
    local n=$1
    if [ "$n" -ge 1000000 ]; then
        awk "BEGIN { printf \"%.1fM\", $n/1000000 }"
    elif [ "$n" -ge 1000 ]; then
        awk "BEGIN { printf \"%.1fk\", $n/1000 }"
    else
        printf "%s" "$n"
    fi
}

# Format duration from milliseconds to compact string (e.g. "1h 23m 45s")
fmt_duration() {
    local total_secs=$(($1 / 1000))
    local hours=$((total_secs / 3600))
    local mins=$(( (total_secs % 3600) / 60 ))
    local secs=$((total_secs % 60))
    local result=""
    [ "$hours" -gt 0 ] && result="${hours}h "
    [ "$hours" -gt 0 ] || [ "$mins" -gt 0 ] && result="${result}${mins}m "
    printf "%s" "${result}${secs}s"
}

# Read JSON input
input=$(cat)

# Extract fields
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
in_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0' | cut -d. -f1)
out_tokens=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0' | cut -d. -f1)
cached_tokens=$(echo "$input" | jq -r '.context_window.current_usage.cache_read_input_tokens // 0' | cut -d. -f1)
cache_creation_tokens=$(echo "$input" | jq -r '.context_window.current_usage.cache_creation_input_tokens // 0' | cut -d. -f1)
current_input_tokens=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // 0' | cut -d. -f1)
ctx_pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
duration_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // 0' | cut -d. -f1)
version=$(echo "$input" | jq -r '.version // "unknown"')

# Calculated fields
ctx_tokens=$((current_input_tokens + cache_creation_tokens + cached_tokens))
total_tokens=$((in_tokens + out_tokens + cached_tokens))

# Display name and git status
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
    name=$(basename "$cwd")
    if [ -n "$(git -C "$cwd" status --porcelain 2>/dev/null)" ]; then
        git_icon="$GIT_DIRTY"
    else
        git_icon="$GIT_CLEAN"
    fi
else
    name="$cwd"
    git_icon=""
fi

# Context color based on usage
if [ "$ctx_pct" -ge 60 ]; then
    ctx_color="$COLOR_RED"
elif [ "$ctx_pct" -ge 40 ]; then
    ctx_color="$COLOR_YELLOW"
else
    ctx_color="$COLOR_GREEN"
fi

# Prompt format:
# NAME STATE
# In: X | Out: X | Cached: X | Total: X | Context: X / X%
# Session: X | Version: X
printf "${COLOR_CYAN_BOLD}%s%b${COLOR_RESET}\n" "$name" "$git_icon"
printf "${COLOR_GREY_BOLD}In: ${COLOR_GREY}%s${COLOR_RESET} | " "$(fmt_tokens "$in_tokens")"
printf "${COLOR_GREY_BOLD}Out: ${COLOR_GREY}%s${COLOR_RESET} | " "$(fmt_tokens "$out_tokens")"
printf "${COLOR_GREY_BOLD}Cached: ${COLOR_GREY}%s${COLOR_RESET} | " "$(fmt_tokens "$cached_tokens")"
printf "${COLOR_GREY_BOLD}Total: ${COLOR_GREY}%s${COLOR_RESET} | " "$(fmt_tokens "$total_tokens")"
printf "${COLOR_GREY_BOLD}Context: %b%s${COLOR_GREY} / %b%s%%${COLOR_RESET}\n" \
    "$ctx_color" "$(fmt_tokens "$ctx_tokens")" "$ctx_color" "$ctx_pct"
printf "${COLOR_GREY_BOLD}Session: ${COLOR_GREY}%s${COLOR_RESET} | " "$(fmt_duration "$duration_ms")"
printf "${COLOR_GREY_BOLD}Version: ${COLOR_GREY}%s${COLOR_RESET}" "$version"
