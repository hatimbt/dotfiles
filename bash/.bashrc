#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/dotfiles/bash/.bash_env
source ~/dotfiles/bash/.bash_aliases

source "$HOME/.cargo/env"

# Run the starship prompt
eval "$(starship init bash)"
