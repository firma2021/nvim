--根据文件名或文件中的内容，模糊搜索文件；会调用ripgrep程序

return
{
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    version = false, --不检查插件的版本，不自动更新插件

    dependencies = { 'nvim-lua/plenary.nvim' },

    cmd = "Telescope",

    keys =
    {
        { "<leader>ff", ":Telescope find_files<CR>", desc = "telescope find files" },
        { "<leader>fg", ":Telescope live_grep<CR>",  desc = "telescope live_grep" },
        { "<leader>fr", ":Telescope resume<CR>",     desc = "telescope resume" },
        { "<leader>fo", ":Telescope oldfiles<CR>",   desc = "telescope oldfiles" },
    },

    opts =
    {
        defaults =
        {
            prompt_prefix = " ",
            selection_caret = " ",
            mappings =
            {
                i =
                {
                    -- ["<c-t>"] = function(...)
                    --     return require("trouble.providers.telescope").open_with_trouble(...)
                    -- end,
                    -- ["<a-t>"] = function(...)
                    --     return require("trouble.providers.telescope").open_selected_with_trouble(...)
                    -- end,
                    -- ["<a-i>"] = function()
                    --     local action_state = require("telescope.actions.state")
                    --     local line = action_state.get_current_line()
                    --     Util.telescope("find_files", { no_ignore = true, default_text = line })()
                    -- end,
                    -- ["<a-h>"] = function()
                    --     local action_state = require("telescope.actions.state")
                    --     local line = action_state.get_current_line()
                    --     Util.telescope("find_files", { hidden = true, default_text = line })()
                    -- end,
                    ["<C-Down>"] = function(...)
                        return require("telescope.actions").cycle_history_next(...)
                    end,
                    ["<C-Up>"] = function(...)
                        return require("telescope.actions").cycle_history_prev(...)
                    end,
                    ["<C-f>"] = function(...)
                        return require("telescope.actions").preview_scrolling_down(...)
                    end,
                    ["<C-b>"] = function(...)
                        return require("telescope.actions").preview_scrolling_up(...)
                    end,
                },
                n =
                {
                    ["q"] = function(...)
                        return require("telescope.actions").close(...)
                    end,
                },
            },
        },
    },
}

--todo:
-- {
--     "nvim-telescope/telescope-file-browser.nvim",
--     dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
-- }
