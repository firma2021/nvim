--一个漂亮时髦的bufferline, 集成tabpage
return
{
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',

    event = "VeryLazy",

    opts =
    {
        options =
        {
            always_show_bufferline = true,

            numbers = function(opts) return string.format('%s-%s', opts.ordinal, opts.id) end,

            -- close_command = 'Bdelete! %d',
            -- right_mouse_command = 'Bdelete! %d',

            diagnostics = "nvim_lsp",

            separator_style = "thin", --"slant","slope","thick","thin", 右下倾斜，右上倾斜，厚竖线，瘦竖线

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

                local ret = (diagnostics_dict.error and icons.Error .. diagnostics_dict.error .. " " or "") ..
                    (diagnostics_dict.warning and icons.Warn .. diagnostics_dict.warning or "")

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
                    text_align = "center",
                },
            },
        },
    },

    config = function(plugin, opts)
        require("bufferline").setup(opts)
        --有冲突
        -- vim.api.nvim_set_keymap("n", "gb", "<Cmd>BufferLinePick<CR>", { noremap = true, silent = true })
        -- vim.api.nvim_set_keymap("n", "gD", "<Cmd>BufferLinePickClose<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", { noremap = true, silent = true })
        vim.api.nvim_set_keymap("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", { noremap = true, silent = true })
    end
}
