--使用virtual text,显示缩进线
--see :help indent_blankline.txt

return
{
    "lukas-reineke/indent-blankline.nvim",
	
    event = { "BufReadPost", "BufNewFile" },

    opts = function()
		vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
		vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
		vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
		vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
		vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
		vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

		return
		{
			char = "┊",
			 char_highlight_list =
			 {
				"IndentBlanklineIndent1",
				"IndentBlanklineIndent2",
				"IndentBlanklineIndent3",
				"IndentBlanklineIndent4",
				"IndentBlanklineIndent5",
				"IndentBlanklineIndent6",
			},
			filetype_exclude =
			{
				"null-ls-info",
				"help",
				"alpha",
				"dashboard",
				"neo-tree",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
				"terminal",
				"lspinfo",
				"toggleterm",
				"TelescopePrompt",
				"log",
				"markdown",
			},


			context_patterns =
			{
				"class",
				"function",
				"method",
				"element",
				"^if",
				"^while",
				"^for",
				"^object",
				"^table",
				"block",
				"arguments",
			},

			-- 调用vim.opt.listchars:append "eol:↴"显示换行符后，如果缩进线上有换行符，是否将缩进线char替换为换行符
			-- show_end_of_line = false,

			-- 是否显示尾随空白行的缩进
			show_trailing_blankline_indent = true,

			show_current_context = true,
			show_current_context_start = false,
		}
	end,

}
