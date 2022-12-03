#
# ~/.bashrc
#

# Return if the shell is run non-interactivley
# https://unix.stackexchange.com/questions/320465/new-tmux-sessions-do-not-source-bashrc-file
[[ $- != *i* ]] && return

# Load shell env variables and aliases
source ~/dotfiles/bash/.bash_env
source ~/dotfiles/bash/.bash_aliases

# Load cargo env variables
source "$HOME/.cargo/env"

# Run the starship prompt
eval "$(starship init bash)"
