-- Set the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- When text is wrapped, move by terminal rows instead of lines, unless a count is given
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Reselect visual selection after indenting
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

-- Maintain the cursor position when yanking a visual selection (yank without jank)
vim.keymap.set('v', 'y', 'myy`y')

-- Disable the annoying quit typo
vim.keymap.set('n', 'q:', ':q')

-- Paste replace visual selection without copying it
vim.keymap.set('v', 'p', '"_dP')

-- Easy insertion of ; and , in insert mode
vim.keymap.set('i', ';;', '<Esc>A;')
vim.keymap.set('i', ',,', '<Esc>A,')

-- Get out of insert mode quickly
vim.keymap.set('i', 'jj', '<Esc>')

-- Quickly clear search highlighting
vim.keymap.set('n', '<Leader>k', ':nohlsearch<CR>')

-- Open the current file in the default program
vim.keymap.set('n', '<Leader>x', ':!open %<CR><CR>')

-- Resize splits with arrow keys
vim.keymap.set('n', '<C-Up>', ':resize +2<CR>')
vim.keymap.set('n', '<C-Down>', ':resize -2<CR>')
vim.keymap.set('n', '<C-Left>', ':vertical resize -2<CR>')
vim.keymap.set('n', '<C-Right>', ':vertical resize +2<CR>')

-- Move lines up and down
vim.keymap.set('i', '<A-j>', '<Esc>:move .+1<CR>==gi')
vim.keymap.set('i', '<A-k>', '<Esc>:move .-2<CR>==gi')
vim.keymap.set('n', '<A-j>', ':move .+1<CR>==')
vim.keymap.set('n', '<A-k>', ':move .-2<CR>==')
vim.keymap.set('v', '<A-j>', ":move '>+1<CR>gv=gv")
vim.keymap.set('v', '<A-k>', ":move '<-2<CR>gv=gv")
