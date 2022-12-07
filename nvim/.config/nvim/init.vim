set shell=/bin/bash

let mapleader = "\<Space>"

" Disable swapfiles
set noswapfile

"set nocompatible
"filetype off
call plug#begin()

" Load plugins
" Neovim Autocomplete and LSP
Plug 'neovim/nvim-lspconfig'
" Plug 'hrsh7th/nvim-compe'

" Extensions to built-in LSP, for example, providing type inlay hints
Plug 'nvim-lua/lsp_extensions.nvim'

" Autocompletion framework for built-in LSP
Plug 'nvim-lua/completion-nvim'

" VIM Enhancements
Plug 'ciaranm/securemodelines'

" GUI Enhancements
Plug 'itchyny/lightline.vim'

"Plug 'dense-analysis/ale'
Plug 'machakann/vim-highlightedyank'

" Fuzzy finder
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim'

" Plug 'airblad/vim-rooter'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install -all' }
" Plug 'junegunn/fzf/vim'

" Semantic language support
Plug 'rust-lang/rust.vim'

" Inko Language support
Plug 'https://gitlab.com/inko-lang/inko.vim.git'

" Vim theme
Plug 'casonadams/walh'


call plug#end()

" Open hotkeys
map <C-p> :Files<CR>
map <leader>; :Buffers<CR>

" Quick-save
nmap <leader>w :w<CR>

" Completion
" Better display for messages
set cmdheight=2

" =============================================================================
" Editor settings
" =============================================================================
set printfont=:h10

" Sane splits
set splitright
set splitbelow

" Permanent undo
set undodir=~/.vimdid
set undofile



" =============================================================================
" # GUI Settings
" =============================================================================
set guioptions-=T	" Remove toolbar
set vb t_vb=		" Remove beeps
set backspace=2		" Backspace over newlines
set relativenumber	" Relative line numbers
set number		" Also show current absolute line number
set diffopt+=iwhite	" No whitespace in vimdiff
set colorcolumn=80	" Coloured column
set showcmd		" Show (partial) command in status line
set mouse=a		" Enable mouse usage (all modes) in terminals


" =============================================================================
" Keyboard shortcuts
" =============================================================================
" ; as :
nnoremap ; :

" Jump to start and end of line using the home row keys
map H ^
map L $

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300

set tabstop=4
set shiftwidth=4

hi MatchParen ctermbg=Black cterm=bold

" FIXME: The walh repo is currently not tracked in git, need a way to fetch
" this
source ~/.config/nvim/walh/colors/walh-nord.vim

let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ }
      \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction
