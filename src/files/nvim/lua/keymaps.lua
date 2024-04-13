-- Leader: <Space>
vim.g.mapleader = ' '

-- Enter the command mode by `;`
vim.keymap.set('n', ';', ':')

-- Write the current buffer to disk
vim.keymap.set('n', '<Leader>w', '<cmd>write<cr>', {desc = 'Save'})

-- Jump to start and end of the current line using 'H' and 'L' 
vim.keymap.set({'n', 'v'}, 'H', '^', {desc = 'Jump to beginning of line'})
vim.keymap.set({'n', 'v'}, 'L', '$', {desc = 'Jump to end of line'})

-- Remap clipboards using registers
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', {})
vim.keymap.set({'n', 'v'}, '<leader>p', '"+p', {})
vim.keymap.set({'n', 'v'}, '<leader>P', '"+P', {})
-- Yank towards end of line
vim.keymap.set('n', '<leader>Y', '"+yg_', {})

vim.keymap.set('n', 'K', vim.lsp.buf.hover, { silent = true, noremap = true })
vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, { silent = true, noremap = true })

-- make the window biger vertically
vim.keymap.set("n", "=", [[<cmd>vertical resize +5<cr>]])
-- make the window smaller vertically
vim.keymap.set("n", "-", [[<cmd>vertical resize -5<cr>]])
-- make the window bigger horizontally by pressing shift and =
vim.keymap.set("n", "+", [[<cmd>horizontal resize +2<cr>]]) 
-- make the window smaller horizontally by pressing shift and -
vim.keymap.set("n", "_", [[<cmd>horizontal resize -2<cr>]])

-- Toggle folds
vim.keymap.set("n", "f", "za")
