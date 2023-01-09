# ~/.bashrc: executed by bash(1) for non-login shells.

# Return if the shell is run non-interactivley
# https://unix.stackexchange.com/questions/320465/new-tmux-sessions-do-not-source-bashrc-file
# https://stackoverflow.com/questions/35432562/why-does-running-echo-output-himbh-on-the-bash-shell
# 
# Running `echo $-` will produce a string output, that indicates the Builtin Set Flags 
# 	h: Remember the location of commands as they are looked up for execution.  This is enabled by default.
# 	i: interactive
# 	m: Monitor mode.  Job control is enabled
# 	B: The shell performs brace expansion (see Brace Expansion above).  This is on by default
# 	H: Enable !  style history substitution.  This option is on by default when the shell is interactive.
[[ $- != *i* ]] && return

# Load shell env variables and aliases
source ~/dotfiles/bash/env.bash
source ~/dotfiles/bash/aliases.bash

# Load cargo PATH variables for cargo installed binaries
source "$HOME/.cargo/env"

# Run the starship prompt
eval "$(starship init bash)"

# Run `zoxide`
eval "$(zoxide init bash)"

# Automatically added by the Guix install script.
if [ -n "$GUIX_ENVIRONMENT" ]; then
    if [[ $PS1 =~ (.*)"\\$" ]]; then
        PS1="${BASH_REMATCH[1]} [env]\\\$ "
    fi
fi

