# Shell shortcuts
alias ..='cd ..'
alias c='clear'

# ls replacement 'exa'
alias l='ll --sort=name --git'
alias lg='l --grid'
alias lm='ll --sort=time'
alias lmg='lm --grid'
alias lf='ll --sort=size'
alias lfg='lf --grid'
alias le='ll --sort=ext'
alias leg='le --grid'
alias ll='lx --all --long --header --time-style=long-iso'
alias lx='exa'

# Create parent directories automatically
alias mkdir='mkdir -p'

# Change alias 'vim' to the preferred editor
alias v='vim'
alias vi='vim'
alias vim='nvim'
alias vv='v $(rg --files | fzf)'

# Emacs
alias e='emacs'

# Alias to start ssh-agent when X is started up
alias startx='eval `ssh-agent` startx'

# Reload the shell
alias rl='source ~/.bashrc'

# Cargo
alias ca='cargo'

alias ea='v ~/dotfiles/bash/.bash_aliases'
alias ee='v ~/dotfiles/bash/.bash_env'
alias ev='v ~/.config/nvim/init.vim'
