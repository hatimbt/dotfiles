#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

#[[ $(fgconsole 2>/dev/null) == 1 ]] && execute startx --vt
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	exec startx
fi

# Load .bashrc for login shells (tmux uses a login shell)
# https://unix.stackexchange.com/questions/320465/new-tmux-sessions-do-not-source-bashrc-file
source "$HOME/.bashrc"

# Load cargo env variables
source "$HOME/.cargo/env"

# SSH
alias ssh='/path/to/ssh-ident'
export SSH_AUTH_SOCK DEFAULT="$XDG_RUNTIME_DIR/ssh-agent.socket"
