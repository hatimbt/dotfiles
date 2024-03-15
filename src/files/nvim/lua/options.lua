-- TODO Check the scope of all the options


-- Colourscheme
vim.cmd.colorscheme('modus')

-- Shell to use for `!` and `:!` commands.
vim.o.shell = '/bin/bash'

-- Save undo history to an undo file and restore when buffer is reopened.
-- Default location for `undodir` is `$XDG_STATE_HOME/nvim/undo//`
vim.o.undofile = true

-- Disable swapfiles
-- TODO Need to setup a recovery system and try to integrate swapfiles to it
vim.bo.swapfile = false

-- Print the line number in front of current line and relative for all others
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse support for all modes
vim.o.mouse = 'a'

-- Set number of spaces for a <Tab>, and number of spaces for each step of
-- auto-indent.
-- NOTE: For rust files, if `filetype` is on, these are ignored.
-- See `:h g:rust_recommended_style`
vim.bo.tabstop = 4
vim.bo.shiftwidth = 4

-- If the user is AFK for this time (ms), the swap file is written to disk and
-- a 'CursorHold' event is triggered
vim.o.updatetime = 300

-- Number of screen lines for the command-line
vim.o.cmdheight = 2

-- Sane window splitting
vim.o.splitbelow = true
vim.o.splitright = true

-- Name of font that will be used for `:hardcopy`
vim.o.printfont = ':h10'

-- Use visual bell instead of beeping
vim.o.visualbell = true

-- Set the working of <BS>, <Del> etc
-- TODO Update to newer format using `indent,eol,start`
vim.o.backspace = '2'

-- Set a coloured column for text aligning
-- TODO Switch to the method that is relative to `textwidth`, and hence can be
-- different for different languages. Rust `std` library uses 99
vim.wo.colorcolumn = '80'

-- Show (partial) command at the bottom. On by default on `vim`
vim.o.showcmd = true
