return
{
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",

    opts = function()
        return
        {
            options =
            {
                icons_enabled = true,
                theme = "auto",
                component_separators = { left = "|", right = "|" },
                section_separators = { left = "", right = "" },
                disabled_filetypes =
                {
                    statusline = { "dashboard", "alpha" },
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,

                globalstatus = true, --只有一个全局状态栏，而不是每个窗口都有一个

                refresh =            --每隔2秒刷新状态栏，如果有特定事件发生而没有到达刷新时间，不保证会刷新状态栏
                {
                    statusline = 2000,
                    tabline = 2000,
                    winbar = 2000,
                },
            },
            sections =
            {

                lualine_a = { "mode" },
                lualine_b =
                {
                    "branch",
                    {
                        "diff",
                        symbols =
                        {
                            added = " ",
                            modified = " ",
                            removed = " ",
                        },
                    },

                },
                lualine_c =
                {
                    {
                        "diagnostics",
                        symbols =
                        {
                            error = " ",
                            warn = " ",
                            info = " ",
                            hint = " ",
                        },
                    }
                },

                lualine_x =
                {
                    {
                        function() return "  " .. require("dap").status() end,
                        cond = function()
                            return package.loaded["dap"] and require("dap").status() ~= ""
                        end,
                        color = function()
                            local hl = vim.api.nvim_get_hl(0, { name = "Debug" })
                            local fg = hl and hl.fg
                            return fg and { fg = string.format("#%06x", fg) }
                        end,
                    },
                    {
                        function()
                            return require("noice").api.status.command.get()
                        end,
                        cond = function()
                            return package.loaded["noice"] and require("noice").api.status.command.has()
                        end,
                        color = function()
                            local hl = vim.api.nvim_get_hl(0, { name = "Statement" })
                            local fg = hl and hl.fg
                            return fg and { fg = string.format("#%06x", fg) }
                        end,
                    },
                    {
                        function()
                            return require("noice").api.status.mode.get()
                        end,

                        cond = function()
                            return package.loaded["noice"] and require("noice").api.status.mode.has()
                        end,

                        color = function()
                            local hl = vim.api.nvim_get_hl(0, { name = "Constant" })
                            local fg = hl and hl.fg
                            return fg and { fg = string.format("#%06x", fg) }
                        end,
                    },
                    {
                        require("lazy.status").updates,

                        cond = require("lazy.status").has_updates,

                        color = function()
                            local hl = vim.api.nvim_get_hl(0, { name = "Special" })
                            local fg = hl and hl.fg
                            return fg and { fg = string.format("#%06x", fg) }
                        end,
                    },
                },
                lualine_y =
                {
                    {
                        "filetype",
                        icon_only = true,
                        separator = "",
                        padding = {
                            left = 1, right = 0 }
                    },
                    {
                        "filename",
                        path = 2,
                        symbols =
                        {
                            modified = "  ",
                            readonly = "",
                            unnamed = "",
                        }
                    },
                    "filesize",
                    { "encoding",   separator = "",                   padding = { left = 1, right = 0 } },
                    { "fileformat", padding = { left = 0, right = 1 } },

                },
                lualine_z =
                {
                    { "location", separator = " ",                  padding = { left = 1, right = 0 } },
                    { "progress", padding = { left = 0, right = 1 } },
                    function() return " " .. os.date("%R") end
                },

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
            extensions = { "neo-tree", "lazy" },
        }
    end,
}
