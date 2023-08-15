-- return
-- {
-- 	"folke/noice.nvim",

-- 	lazy = true,
-- 	event = "VeryLazy",

-- 	dependencies =
-- 	{
-- 		"MunifTanjim/nui.nvim",
-- 		"rcarriga/nvim-notify",
-- 	},

--     keys =
-- 	{
-- 		{ "<leader>nl", function() require("noice").cmd("last") end, desc = "notify aast message" },
-- 		{ "<leader>nh", function() require("noice").cmd("history") end, desc = "notify history" },
-- 		{ "<leader>na", function() require("noice").cmd("all") end, desc = "notify all" },
--     },

-- 	opts = -- 使用该插件建议的配置
-- 	{
-- 		lsp =
-- 		{
-- 			override =
-- 			{
-- 				["vim.lsp.util.convert_input_to_markdown_lines"] = true, --重写markdown渲染，使其使用Treesitter语法高亮
--                 ["vim.lsp.util.stylize_markdown"] = true,
-- 				["cmp.entry.get_documentation"] = true,
-- 			},
-- 		},

-- 		presets =
-- 		{
-- 			bottom_search = true, --使用经典的底部命令栏进行搜索
-- 			command_palette = true, --将命令栏和弹出菜单放在一起
-- 			long_message_to_split = true, --长消息将被分割后发送
-- 			inc_rename = false, --为inc-rename.nvim启用输入框
-- 			lsp_doc_border = false, -- add a border to hover docs and signature help
-- 		},
-- 	},
-- }
return {}
