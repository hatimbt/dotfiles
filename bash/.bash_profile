#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

#[[ $(fgconsole 2>/dev/null) == 1 ]] && execute startx --vt
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	exec startx
fi
source "$HOME/.cargo/env"

alias ssh='/path/to/ssh-ident'

export SSH_AUTH_SOCK DEFAULT="$XDG_RUNTIME_DIR/ssh-agent.socket"
