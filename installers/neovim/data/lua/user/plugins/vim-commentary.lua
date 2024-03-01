-- Commenting support
return {
    'tpope/vim-commentary',
    config = function()
        -- Maintain cursor position when commenting paragraphs
        vim.keymap.set('n', 'gcap', 'my<cmd>norm vip<bar>gc<cr>`y')
    end,
}
