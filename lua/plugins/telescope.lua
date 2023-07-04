--根据文件名或文件中的内容，模糊搜索文件；会调用ripgrep程序

return
{
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',

    dependencies = { 'nvim-lua/plenary.nvim' },

    cmd = "Telescope",

    keys =
    {
        { "<leader>pp1", ":Telescope find_files<CR>", desc = "telescope find files" },
        { "<leader>pp2", ":Telescope live_grep<CR>",  desc = "telescope live_grep" },
        { "<leader>pp3", ":Telescope resume<CR>",     desc = "telescope resume" },
        { "<leader>pp4", ":Telescope oldfiles<CR>",   desc = "telescope oldfiles" },
    }

}
