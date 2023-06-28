return
{
    "akinsho/bufferline.nvim", --https://github.com/akinsho/bufferline.nvim
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',

    event = "VeryLazy",

    keys =
    {
        { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>",            desc = "Toggle pin" },
        { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
    },

    opts =
    {
        options =
        {
            always_show_bufferline = true,

            numbers = function(opts) return string.format('%s-%s', opts.ordinal, opts.id) end,

            -- stylua: ignore
            close_command = function(n) require("mini.bufremove").delete(n, false) end,
            -- stylua: ignore
            right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,

            diagnostics = "nvim_lsp",

            --LSP indicators
            --count：整数，表示错误的总数
            --level：字符串，"error" | "warning"
            --diagnostics_dict：字典，
            diagnostics_indicator = function(count, level, diagnostics_dict, context)
                local icons =
                {
                    Error = " ",
                    Warn = " ",
                    Hint = " ",
                    Info = " ",
                }

                local ret = (diag.error and icons.Error .. diag.error .. " " or "") -- diag.error ? icons.Error + diag.error + " " : " "
                    .. (diag.warning and icons.Warn .. diag.warning or "")

                return vim.trim(ret)
            end,

            --鼠标悬停到标签上时，隐藏关闭图标
            hover =
            {
                enabled = true,
                delay = 200,
                reveal = { 'close' },
            },

            --为左侧的文件浏览器留出空间
            offsets =
            {
                {
                    filetype = "neo-tree",
                    text = "neo-tree",
                    highlight = "Directory",
                    text_align = "left",
                },
            },
        },
    },
}
