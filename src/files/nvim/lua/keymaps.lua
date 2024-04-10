-- Leader: <Space>
vim.g.mapleader = ' '

-- Enter the command mode by `;`
vim.keymap.set('n', ';', ':')

-- Write the current buffer to disk
vim.keymap.set('n', '<Leader>w', '<cmd>write<cr>', {desc = 'Save'})

-- Jump to start and end of the current line using 'H' and 'L' 
vim.keymap.set({'n', 'v'}, 'H', '^', {desc = 'Jump to beginning of line'})
vim.keymap.set({'n', 'v'}, 'L', '$', {desc = 'Jump to end of line'})

-- Telescope keybindings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>ft', builtin.lsp_type_definitions, {})
vim.keymap.set('n', '<leader>fd', builtin.lsp_definitions, {})
vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})

-- Remap clipboards using registers
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', {})
vim.keymap.set({'n', 'v'}, '<leader>p', '"+p', {})
vim.keymap.set({'n', 'v'}, '<leader>P', '"+P', {})
-- Yank towards end of line
vim.keymap.set('n', '<leader>Y', '"+yg_', {})

vim.keymap.set('n', 'K', vim.lsp.buf.hover, { silent = true, noremap = true })
vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, { silent = true, noremap = true })
