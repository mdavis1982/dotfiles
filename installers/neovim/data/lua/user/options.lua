-- Set the default tab stop preferences
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- Use smart indents
vim.opt.smartindent = true

-- Disable line wrapping by default
vim.opt.wrap = false

-- Enable line numbers and set them to be relative
vim.opt.number = true
vim.opt.relativenumber = true

-- Hide the command area when not in use
vim.opt.cmdheight = 0

-- Complete the longest common match, and allow tabbing the results
vim.opt.wildmode = 'longest:full,full'

-- Set completion options
vim.opt.completeopt = 'menuone,longest,preview'

-- Set the title
vim.opt.title = true

-- Enable the mouse for all modes
vim.opt.mouse = 'a'
vim.opt.mousemoveevent = true

-- Enable all colours
vim.opt.termguicolors = true

-- Turn on spell checking by default
vim.opt.spell = true

-- Set case insensitive searching unless using uppercase letters
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable list characters
vim.opt.list = true
vim.opt.listchars = { tab = '▸ ', trail = '·' }

-- Remove the fill characters from the end of a buffer
vim.opt.fillchars:append({ eob = ' ' })

-- Set the default split direction
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Set scroll offsets to keep context
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8

-- Use the system clipboard
vim.opt.clipboard = 'unnamedplus'

-- Ask for confirmation instead of showing an error when quitting with unsaved changes
vim.opt.confirm = true

-- Turn on persistent undo
vim.opt.undofile = true

-- Create backup files, but not in the current directory
vim.opt.backup = true
vim.opt.backupdir:remove('.')

-- Turn on the sign column and set it to 2 characters
vim.opt.signcolumn = 'yes:2'
