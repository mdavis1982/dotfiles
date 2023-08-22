# Lick
# ====
# An awesome OhMyZSH theme by Matthew Davis
# ------------------------------------------------------------------------------

# Machine name
function machine_name {
    [ -f ~/.machine-name ] && cat ~/.machine-name || echo $HOST
}

# Current directory
local current_dir='${PWD/#$HOME/~}'

# VCS
VCS_PROMPT_PREFIX1="%{$fg[white]%}on%{$reset_color%} "
VCS_PROMPT_PREFIX2=":%{$fg[cyan]%}"
VCS_PROMPT_SUFFIX="%{$reset_color%}"
VCS_PROMPT_DIRTY=" %{$fg[red]%}✖︎"
VCS_PROMPT_CLEAN=" %{$fg[green]%}●"

# Git info
local git_info='$(git_prompt_info)'
ZSH_THEME_GIT_PROMPT_PREFIX="${VCS_PROMPT_PREFIX1}git${VCS_PROMPT_PREFIX2}"
ZSH_THEME_GIT_PROMPT_SUFFIX="$VCS_PROMPT_SUFFIX"
ZSH_THEME_GIT_PROMPT_DIRTY="$VCS_PROMPT_DIRTY"
ZSH_THEME_GIT_PROMPT_CLEAN="$VCS_PROMPT_CLEAN"

# Prompt format: \n # USER at MACHINE in DIRECTORY on git:BRANCH STATE \n ->
PROMPT="
%{$fg[red]%}%n \
%{$fg[white]%}at \
%{$fg[yellow]%}$(machine_name) \
%{$fg[white]%}in \
%{$fg[green]%}${current_dir} \
${git_info}
%{$fg[red]%}→ %{$reset_color%}"
