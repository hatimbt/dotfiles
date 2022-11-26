#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Alias to start ssh-agent when X is started up
alias startx='eval `ssh-agent` startx'

alias ls='ls --color=auto'
alias ll='ls -lah'

PROMPT_COMMAND='smart-pwd'
PS1='\u ❯ '

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/hatim/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/hatim/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/hatim/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/hatim/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
