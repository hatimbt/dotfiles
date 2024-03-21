#!/bin/zsh

[[ -e "$HOME/.guix-profile/etc/profile" ]] && . $HOME/.guix-profile/etc/profile
[[ -e "$HOME/.guix-home/profile/etc/profile" ]] && . $HOME/.guix-home/profile/etc/profile
export PATH=/run/setuid-programs:$PATH

zmodload zsh/complist

setopt autocd
setopt interactive_comments
setopt no_sharehistory
unsetopt share_history
setopt histignorespace

# Prompt
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

# Left Caps Lock as Escape, and as Ctrl when used as a modifier
xcape -e 'Control_L=Escape'
