return
{
    "nvim-lualine/lualine.nvim",

    event = "VeryLazy",

    dependencies =
    {
        "arkav/lualine-lsp-progress",
    },

    opts = function()
        return
        {
            options =
            {
                icons_enabled = true,
                theme = "auto",
                component_separators = { left = "|", right = "|" },
                section_separators = { left = "", right = "" },
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
                        sources = { "nvim_diagnostic" },
                        symbols =
                        {
                            error = " ",
                            warn = " ",
                            info = " ",
                            hint = " ",
                        },
                    },
                    {
                        function()

                            local clients = vim.lsp.get_active_clients() --获取活跃的LSP客户端
                            if next(clients) == nil then return "no active lsp" end

                            local msg = ""

                            local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype') --获取当前缓冲区文件类型

                            for index, client in ipairs(clients) do
                              local filetypes = client.config.filetypes
                              if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 --检查当前缓冲区的文件类型是否在lSP支持的文件类型列表中
                              then
                                 msg = msg .. "[+" .. client.name .. "]"
                              else
                                msg = msg .. "[-" .. client.name .. "]"
                              end
                            end

                            return msg

                          end,

                          icon = " LSP",

                          color = { fg = '#ec5f67', gui = 'bold' },
                    },
                    "lsp_progress",
                    {
                        function()
                            return "  " .. require("dap").status()
                        end,

                        cond = function()
                            return package.loaded["dap"] and require("dap").status() ~= ""
                        end,

                        color = function()
                            local hl = vim.api.nvim_get_hl(0, { name = "Debug" })
                            local fg = hl and hl.fg
                            return fg and { fg = string.format("#%06x", fg) } --如果fg不为空，返回6位16进制字符串
                        end,
                    },
                },

                lualine_x =
                {

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
                        separator = " ",
                        padding = { left = 1, right = 0 }
                    },
                    "filesize",
                    { "encoding",   separator = " ",                  padding = { left = 1, right = 0 } },
                    { "fileformat", padding = { left = 0, right = 1 } },

                },
                lualine_z =
                {
                    { "location", separator = " ",                  padding = { left = 1, right = 0 } },
                    { "progress", padding = { left = 0, right = 1 } },
                    {"datetime", style = "%H:%M"}
                },

            },

            inactive_sections = --非活动窗口的状态栏。在之前的配置中，我们规定只使用一个全局状态栏，因此这项配置是多余的。
            {
                lualine_a = {},
                lualine_b = {},
                lualine_c =
                {
                    {
                        "filename",
                        file_status = true,     --显示文件状态
                        newfile_status = false, --不显示新文件(创建后未写入的文件)的状态
                        path = 3,               --绝对路径，使用波浪号表示家目录
                        symbols =
                        {
                            modified = '[+]',
                            readonly = '[-]',
                            unnamed = '[No Name]',
                            newfile = '[New]',
                        }
                    },
                },
                lualine_x = { "location" },
                lualine_y = {},
                lualine_z = {},
            },

            -- winbar =
            -- {
            --     lualine_a = {},
            --     lualine_b = {},
            --     lualine_c =
            --     {
            --         {
            --             "filename",
            --             file_status = true,     --显示文件状态
            --             newfile_status = false, --不显示新文件(创建后未写入的文件)的状态
            --             path = 3,               --绝对路径，使用波浪号表示家目录
            --             symbols =
            --             {
            --                 modified = '[+]',
            --                 readonly = '[-]',
            --                 unnamed = '[No Name]',
            --                 newfile = '[New]',
            --             }
            --         },
            --
            --     },
            --     lualine_x = {},
            --     lualine_y = {},
            --     lualine_z = {}
            -- },
            --
            -- inactive_winbar =
            -- {
            --     lualine_a = {},
            --     lualine_b = {},
            --     lualine_c =
            --     {
            --         {
            --             "filename",
            --             path = 3, --绝对路径，使用波浪号表示家目录
            --         },
            --     },
            --     lualine_x = {},
            --     lualine_y = {},
            --     lualine_z = {}
            -- },

            extensions = --这些插件可以改变状态栏的样式
            {
                "neo-tree",
                "lazy",
                "nvim-dap-ui",
                "toggleterm",
                "nvim-dap-ui",
                "trouble",
                "aerial"
            },

            -- tabline =
            -- {
            --     lualine_a = { "buffers" },
            --     lualine_b = { "branch" },
            --     lualine_c = { "" },
            --     lualine_x = {},
            --     lualine_y = {},
            --     lualine_z = { "tabs" },
            -- },
        }
    end,
}
