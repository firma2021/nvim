--一个漂亮时髦的bufferline, 集成tabpage
-- see :h bufferline-configuration

return
{
	"akinsho/bufferline.nvim",

	lazy = true,
	event = { "BufReadPost", "BufNewFile" },

	version = "*", -- 使用最新的稳定版本

	dependencies =
	{
		{
			"catppuccin/nvim",
		},
		{
			"nvim-tree/nvim-web-devicons",
		},
	},

	keys =
    {
		{ "<tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "prev buffer (cycle)" },
		{ "<S-tab>", "<cmd>BufferLineCycleNext<cr>", desc = "next buffer (cycle)" },

		{ "<leader>bo", "<Cmd>BufferLinePick<CR>",  desc = "buffer pick" },
		{ "<leader>bc", "<Cmd>BufferLinePickClose<CR>",  desc = "buffer pick close" },

		{ "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>",  desc = "goto buffer 1" },
		{ "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>",  desc = "goto buffer 2"},
		{ "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>",  desc = "goto buffer 3" },
	},
	-- 大部分配置使用默认值，下面列出的是自定义了的值
	-- see :h bufferline-configuration
	opts =
	{
		options =
		{
			always_show_bufferline = true, -- use default value

			modified_icon = "",
			buffer_close_icon = "",

			-- buffer序号，buffer id
			numbers = function(opts) return string.format('%s-%s', opts.ordinal, opts.id) end,

			diagnostics = "nvim_lsp",

			separator_style = "thin", --"slant","slope","thick","thin", 右下倾斜，右上倾斜，厚竖线，瘦竖线

			--LSP indicators
			--count：整数，表示错误的总数
			--level：字符串，"error" | "warning"
			--diagnostics_dict：字典，
			diagnostics_indicator = function(count, level, diagnostics_dict, context)
				local icons = require("plugins.util.icons").diagnostics

				-- 相当于C中的 diagnostics_dict.error ? icons.Error .. diagnostics_dict.error .. " " : ""
				local ret = (diagnostics_dict.error and icons.Error .. diagnostics_dict.error .. " " or "") ..
					(diagnostics_dict.warning and icons.Warn .. diagnostics_dict.warning or "")

				return vim.trim(ret)
			end,

			--为下面打开侧边栏的插件，添加 buffer line
			offsets =
			{
				{
					filetype = "neo-tree",
					text = "neo-tree",
					highlight = "Directory",
					text_align = "left",
				},
				{
					filetype = "aerial",
					text = "symbol outline",
					text_align = "center",
				},
			},
		},
	},

	config = function(plugin, opts)
		opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
		require("bufferline").setup(opts)
	end
}
