lua require('options')
lua require('keymaps')

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
