# Discard all uncommitted changes and untracked files
alias nah="git reset --hard; git clean -df"

# Remove local references to deleted remote branches
alias prune="git remote prune origin"

# Quick work-in-progress commit of all changes
alias wip="git add . && git commit -m 'WIP'"
