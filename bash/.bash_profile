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

# Guix locales
# https://guix.gnu.org/manual/en/html_node/Application-Setup.html
export GUIX_LOCPATH=$HOME/.guix-profile/lib/locale

# Set up path to a Guix profile
# https://guix.gnu.org/manual/en/html_node/Getting-Started.html
GUIX_PROFILE="$HOME/.guix-profile"
. "$GUIX_PROFILE/etc/profile"




# SSH
export SSH_AUTH_SOCK DEFAULT="$XDG_RUNTIME_DIR/ssh-agent.socket"
