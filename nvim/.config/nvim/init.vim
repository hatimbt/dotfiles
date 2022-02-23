set shell=/bin/bash

let mapleader = "\<Space>"

" Disable swapfiles
"set noswapfile

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
" Plug 'airblad/vim-rooter'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install -all' }
" Plug 'junegunn/fzf/vim'

" Semantic language support
Plug 'rust-lang/rust.vim'

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


" =============================================================================
" LSP Config
" Source: https://sharksforarms.dev/posts/neovim-rust/
" =============================================================================

syntax enable
filetype plugin indent on

" Set completeopt to have a better completion experience
" :help completeopt
" menuone: popup even when there's only one match
" noinsert: Do not insert text until a selection is made
" noselect: Do not select, force user to select one from the menu
set completeopt=menuone,noinsert,noselect

" Avoid showing extra messages when using completion
set shortmess+=c

" Configure LSP
" https://github.com/neovim/nvim-lspconfig#rust_analyzer
lua <<EOF

-- nvim_lsp object
local nvim_lsp = require'lspconfig'

-- function to attach completion when setting up lsp
local on_attach = function(client)
    require'completion'.on_attach(client)
end

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

local diagnostic_handler = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    signs = {
      severity_limit = 'Warning',
    },
    underline = false,
    update_in_insert = false,
    virtual_text = {
      spacing = 2,
      severity_limit = 'Warning',
    },
  }
)
EOF

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" use <Tab> as trigger keys
imap <Tab> <Plug>(completion_smart_tab)
imap <S-Tab> <Plug>(completion_smart_s_tab)

" Code navigation shortcuts
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>

" Code Actions
nnoremap <silent> ga    <cmd>lua vim.lsp.buf.code_action()<CR>

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" Set updatetime for CursorHold
" 300ms of no cursor movement to trigger CursorHold
set updatetime=300
" Show diagnostic popup on cursor hold
autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()

" Goto previous/next diagnostic warning/error
nnoremap <silent> g[ <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> g] <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

set tabstop=4
set shiftwidth=4
