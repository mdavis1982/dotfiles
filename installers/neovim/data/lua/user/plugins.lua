-- Bootstrap Lazy
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Require each plugin
require('lazy').setup({
    { import = 'user.plugins.bufferline' },
    { import = 'user.plugins.cmp' },
    { import = 'user.plugins.dashboard' },
    { import = 'user.plugins.floatterm' },
    { import = 'user.plugins.gitsigns' },
    { import = 'user.plugins.indent-blankline' },
    { import = 'user.plugins.lspconfig' },
    { import = 'user.plugins.lualine' },
    { import = 'user.plugins.neo-tree' },
    { import = 'user.plugins.telescope' },
    { import = 'user.plugins.tokyo-night' },
    { import = 'user.plugins.treesitter' },
    { import = 'user.plugins.treesj' },
    { import = 'user.plugins.vim-commentary' },
    { import = 'user.plugins.vim-pasta' },
    { import = 'user.plugins.vim-repeat' },
    { import = 'user.plugins.vim-rooter' },
    { import = 'user.plugins.vim-surround' },
    { import = 'user.plugins.vim-test' },
}, {
    checker = {
        enabled = true, -- Check for updates automatically...
        notify = false, -- ...but don't notify of them
    },
    change_detection = {
        notify = false, -- Don't notify when the configuration file changes
    },
    install = {
        colorscheme = { 'tokyonight' }  -- Attempt to load this color scheme when loading the UI
    },
})
