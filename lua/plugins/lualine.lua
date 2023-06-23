return
{
    "nvim-lualine/lualine.nvim",
    config = function()
        require("lualine").setup
        (
            {
                options =
                {
                    icons_enabled = true,
                    theme = "auto",
                    component_separators = { left = "|", right = "|" },
                    section_separators = { left = "", right = "" },
                    disabled_filetypes =
                    {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    --只有一个全局状态栏，而不是每个窗口都有一个。
                    globalstatus = true,
                    --每隔10秒刷新状态栏，如果有特定事件发生而没有到达刷新时间，不保证会刷新状态栏。
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    },
                },
                sections =
                {

                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },

                    lualine_x = { "tabs" },
                    lualine_y = { "filename", "filetype", "filesize", "fileformat", "encoding" },
                    lualine_z = { "location", "progress" },
                },
                inactive_sections =
                {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {},
            }
        )
    end
}
