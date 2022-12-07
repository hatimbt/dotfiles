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
alias mk='mkdir -p'
alias mkdir='mkdir -p'

# Find files
alias f='fd'

# Change alias 'vim' to the preferred editor
alias v='vim'
alias vi='vim'
alias vim='nvim'
# FIXME: fix the --preview on sk, sk seems to not be dropin replacement for fzf
alias vv='v $(rg --files | sk --preview="{} --color=always")'
alias o='xdg-open'
alias oo='xdg-open "$(rg --files | fzf)"'

# Emacs
alias e='emacs'
alias vimdiff='nvim -d'

# Alias to start ssh-agent when X is started up
alias startx='eval `ssh-agent` startx'

# Reload the shell
alias rl='source ~/.bashrc'

# Rust and Cargo
alias rup='rustup'
alias ru='rustup update'
alias ca='cargo'
alias cu='cargo install --locked $(cargo install --list | egrep "^[a-z0-9_-]+ v[0-9.]+:$" | cut -f1 -d" ")'
alias ci='cargo install --locked'

alias eb='v ~/dotfiles/bash/.bashrc'
alias ea='v ~/dotfiles/bash/.bash_aliases'
alias ev='v ~/.config/nvim/init.vim'
alias eg='v ~/.config/git/config'
alias ep='v ~/.config/starship.toml'
alias ee='emacs ~/.emacs.d'
alias ve='v ~/.emacs.d'

# Shortcuts to locations
alias a='cd ~/km/'
alias dj='cd ~/dev/major/'
alias dn='cd ~/dev/minor/'
alias dw='cd ~/dev/work/'
alias ch='cd ~/'
alias cdt='cd ~/dotfiles/'

# Git
# gs is an executable hash for ghostcript, to run it, use `\gs` or `command gs`
alias gs='git s'
alias gd='git d'
alias ga='git a'
alias gaa='git aa'
alias gap='git ap'
alias gc='git c'
alias gr='git r'
alias gl='git l'
alias gll='git ll'
alias gps='git ps'
alias gpl='git pl'
