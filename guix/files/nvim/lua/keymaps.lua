-- Leader: <Space>
vim.g.mapleader = ' '

-- Enter the command mode by `;`
vim.keymap.set('n', ';', ':')

-- Write the current buffer to disk
vim.keymap.set('n', '<Leader>w', '<cmd>write<cr>', {desc = 'Save'})

-- Jump to start and end of the current line using 'H' and 'L' 
vim.keymap.set({'n', 'v'}, 'H', '^', {desc = 'Jump to beginning of line'})
vim.keymap.set({'n', 'v'}, 'L', '$', {desc = 'Jump to end of line'})
