#!/bin/bash

# Read JSON input once
input=$(cat)

# Extract fields
cwd=$(echo "$input" | jq -r '.workspace.current_dir')
in_tokens=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0' | cut -d. -f1)
out_tokens=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0' | cut -d. -f1)
cached_tokens=$(echo "$input" | jq -r '.context_window.current_usage.cache_read_input_tokens // 0' | cut -d. -f1)
cache_creation_tokens=$(echo "$input" | jq -r '.context_window.current_usage.cache_creation_input_tokens // 0' | cut -d. -f1)
current_input_tokens=$(echo "$input" | jq -r '.context_window.current_usage.input_tokens // 0' | cut -d. -f1)
ctx_tokens=$((current_input_tokens + cache_creation_tokens + cached_tokens))
ctx_pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
duration_ms=$(echo "$input" | jq -r '.cost.total_duration_ms // 0' | cut -d. -f1)
version=$(echo "$input" | jq -r '.version // "unknown"')

# Determine display name and git status icon
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  name=$(basename "$cwd")
  if [ -n "$(git -C "$cwd" status --porcelain 2>/dev/null)" ]; then
    git_icon=' \033[00;31m✖︎\033[00m'
  else
    git_icon=' \033[00;32m●\033[00m'
  fi
else
  name="$cwd"
  git_icon=""
fi

# Format token count with SI suffix (e.g. 10.2k, 1.5M)
fmt_tokens() {
  local n=$1
  if [ "$n" -ge 1000000 ]; then
    printf "%s" "$(awk "BEGIN { printf \"%.1fM\", $n/1000000 }")"
  elif [ "$n" -ge 1000 ]; then
    printf "%s" "$(awk "BEGIN { printf \"%.1fk\", $n/1000 }")"
  else
    printf "%s" "$n"
  fi
}

fmt_in=$(fmt_tokens "$in_tokens")
fmt_out=$(fmt_tokens "$out_tokens")
fmt_cached=$(fmt_tokens "$cached_tokens")
fmt_ctx=$(fmt_tokens "$ctx_tokens")

# Color the context percentage based on usage
if [ "$ctx_pct" -ge 60 ]; then
  pct_color_bold='\033[01;31m' # bold red
  pct_color='\033[00;31m'      # red
elif [ "$ctx_pct" -ge 40 ]; then
  pct_color_bold='\033[01;33m' # bold yellow
  pct_color='\033[00;33m'      # yellow
else
  pct_color_bold='\033[01;32m' # bold green
  pct_color='\033[00;32m'      # green
fi

# Format session duration as compact string (e.g. "1h 23m 45s")
total_secs=$((duration_ms / 1000))
hours=$((total_secs / 3600))
mins=$(( (total_secs % 3600) / 60 ))
secs=$((total_secs % 60))
timer=""
[ "$hours" -gt 0 ] && timer="${hours}h "
[ "$hours" -gt 0 ] || [ "$mins" -gt 0 ] && timer="${timer}${mins}m "
timer="${timer}${secs}s"

# Line 1: name
# Line 2: In | Out | Cached | Ctx tokens | Ctx %
# Line 3: Session timer | Version
printf '\033[01;36m%s%b\033[00m\n' "$name" "$git_icon"
printf '\033[01;90mIn: \033[00;90m%s\033[00m | \033[01;90mOut: \033[00;90m%s\033[00m | \033[01;90mCached: \033[00;90m%s\033[00m | \033[01;90mCtx: \033[00;90m%s\033[00m | \033[01;90mCtx: %b%s%%\033[00m\n' \
  "$fmt_in" "$fmt_out" "$fmt_cached" "$fmt_ctx" "$pct_color" "$ctx_pct"
printf '\033[01;90mSession: \033[00;90m%s\033[00m | \033[01;90mVersion: \033[00;90m%s\033[00m' \
  "$timer" "$version"
