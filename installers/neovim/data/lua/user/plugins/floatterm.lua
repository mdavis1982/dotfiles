-- Floating terminal
return {
    'voldikss/vim-floaterm',
    keys = {
        { '<F1>', ':FloatermToggle<CR>' },
        { '<F1>', '<C-\\><C-n>:FloatermToggle<CR>', mode = 't' },
    },
    cmd = { 'FloatermToggle' },
    init = function()
        vim.g.floaterm_width = 0.9
        vim.g.floaterm_height = 0.9
    end,
}
