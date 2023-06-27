--根据文件名或文件中的内容，模糊搜索文件；会调用ripgrep程序

return
{
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',

    dependencies = { 'nvim-lua/plenary.nvim' },

    cmd = "Telescope",

    keys =
    {
        { "<leader>p", ":Telescope find_files<CR>", desc = "telescope find files" },
        { "<leader>p", ":Telescope live_grep<CR>",  desc = "telescope live_grep" },
        { "<leader>p", ":Telescope resume<CR>",     desc = "telescope resume" },
        { "<leader>p", ":Telescope oldfiles<CR>",   desc = "telescope oldfiles" },
    }

}
