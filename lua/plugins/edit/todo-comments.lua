-- 在项目中高亮显示、用列表列出、搜索 todo 注释

return
{
	"folke/todo-comments.nvim",

	dependencies = { "nvim-lua/plenary.nvim" },

	lazy = false, --fixme： 该插件不能懒加载？
	enent = { "BufReadPost", "BufNewFile" },

	keys =
	{
		{ "]t", function() require("todo-comments").jump_next() end, desc = "next error/warning todo comment" },
		{ "[t", function() require("todo-comments").jump_prev() end, desc = "prev error/warning todo comment" },
	},

	cmd = { "TodoQuickFix", "TodoLocList", "TodoTelescope", },

	--使用默认配置，额外指定了一些关键字
	opts =
	{
		keywords =
		{
			FIX =
			{
				icon = " ",
				color = "error",
				alt = { "FIXME", "fixme" },
			},
			TODO =
			{
				icon = " ",
				color = "info",
				alt = { "todo", },
			},

			--  weird code warning
			HACK =
			{
				icon = " ",
				color = "warning",
				alt = { "hack", },
			},

			WARN =
			{
				icon = " ",
				color = "warning",
				alt = { "WARNING", "warning", "warn", "XXX" },
			},

			PERF =
			{
				icon = " ",
				alt = { "OPTIM", "perf", "optimize", },
			},

			NOTE =
			{
				icon = " ",
				color = "hint",
				alt = { "INFO", "note", "info" },
			},

		},
	}
}
