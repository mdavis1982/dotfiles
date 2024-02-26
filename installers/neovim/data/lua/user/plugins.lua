-- Bootstrap Lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = 'user.plugins.tokyo-night' },
    { import = 'user.plugins.vim-commentary' },
    { import = 'user.plugins.vim-surround' },
    { import = 'user.plugins.treesitter' },
    { import = 'user.plugins.telescope' },
    { import = 'user.plugins.neo-tree' },
    { import = 'user.plugins.lualine' },
    { import = 'user.plugins.bufferline' },
    { import = 'user.plugins.indent-blankline' },
    { import = 'user.plugins.gitsigns' },
    { import = 'user.plugins.floatterm' },
    { import = 'user.plugins.lspconfig' },
    { import = 'user.plugins.cmp' },
}, {
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        notify = false,
    },
    install = {
        colorscheme = { "tokyonight" }
    },
})
