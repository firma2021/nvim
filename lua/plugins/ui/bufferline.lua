--一个漂亮时髦的bufferline, 集成tabpage
return
{
    "akinsho/bufferline.nvim",

    version = "*",

    dependencies =
    {
        {
			"catppuccin/nvim",
		},
		{
            "nvim-tree/nvim-web-devicons",
            lzay = true,
        },
    },

    event = "VeryLazy",

	-- see :h bufferline-configuration
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
		opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
        require("bufferline").setup(opts)

		vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "prev buffer (cycle)" })
  		vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "next buffer (cycle)" })
		vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "prev buffer (cycle)" })
  		vim.keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "next buffer (cycle)" })

        vim.keymap.set("n", "<leader>bo", "<Cmd>BufferLinePick<CR>", { noremap = true, desc="buffer pick"})
        vim.keymap.set("n", "<leader>bc", "<Cmd>BufferLinePickClose<CR>", { noremap = true, desc="buffer pick close" })

        vim.keymap.set("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", { noremap = true, desc="goto buffer 1" })
        vim.keymap.set("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", { noremap = true, desc="goto buffer 2" })
        vim.keymap.set("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", { noremap = true, desc="goto buffer 3" })
    end
}
