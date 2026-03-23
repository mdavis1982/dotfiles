#!/bin/bash

# Colours matching the Lick theme
R='\033[31m'    # red (username, arrow)
W='\033[37m'    # white (at, in, on)
Y='\033[33m'    # yellow (machine)
G='\033[32m'    # green (directory, clean dot)
C='\033[36m'    # cyan (branch)
X='\033[0m'     # reset
DIM='\033[2m'   # dim

clear

# Prompt 1: git log
printf "\n${R}matt ${W}at ${Y}MacBook-Air-15 ${W}in ${G}~/Developer/Other/dotfiles ${W}on ${W}git${W}:${C}main ${G}●${X}\n"
printf "${R}→ ${X}git log --oneline -5\n"
printf "${Y}8730e59${X} Allow MCP servers to be configured globally.\n"
printf "${Y}8aa85be${X} Add Thinking Partner skill.\n"
printf "${Y}8528bc1${X} Some small refactors.\n"
printf "${Y}39dc429${X} Add an initial global CLAUDE.md file.\n"
printf "${Y}ca81f50${X} Refactor Claude Code status line.\n"

# Prompt 2: tree
printf "\n${R}matt ${W}at ${Y}MacBook-Air-15 ${W}in ${G}~/Developer/Other/dotfiles ${W}on ${W}git${W}:${C}main ${G}●${X}\n"
printf "${R}→ ${X}tree -L 2 --dirsfirst -I '.git|.DS_Store'\n"
printf "${C}.${X}\n"
printf "├── ${C}bootstrap${X}\n"
printf "│   └── ${C}Terminal${X}\n"
printf "├── ${C}installers${X}\n"
printf "│   ├── ${C}claude-code${X}\n"
printf "│   ├── ${C}command-line-tools${X}\n"
printf "│   ├── ${C}filesystem${X}\n"
printf "│   ├── ${C}git${X}\n"
printf "│   ├── ${C}homebrew${X}\n"
printf "│   └── ${C}oh-my-zsh${X}\n"
printf "├── README.md\n"
printf "└── install.sh\n"

# Prompt 3: empty prompt (cursor waiting)
printf "\n${R}matt ${W}at ${Y}MacBook-Air-15 ${W}in ${G}~/Developer/Other/dotfiles ${W}on ${W}git${W}:${C}main ${G}●${X}\n"
printf "${R}→ ${X}"
