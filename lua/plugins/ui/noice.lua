return
{
	--   "folke/noice.nvim",

	--   event = "VeryLazy",

	--   dependencies =
	--   {
	--     "MunifTanjim/nui.nvim",
	--     "rcarriga/nvim-notify",
	--     },

	--   opts =
	--   {
	--     lsp =
	--     {
	--       override = --重写markdown渲染，使其使用Treesitter语法高亮
	--       {
	--         ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	--         ["vim.lsp.util.stylize_markdown"] = true,
	--         ["cmp.entry.get_documentation"] = true,
	--       },
	--       signature = { enabled = false },
	--       hover = { enabled = false },
	--       message = { enabled = false },
	--     },

	--     presets =
	--     {
	--       bottom_search = true, --使用经典的底部命令栏进行搜索
	--       command_palette = true, --将命令栏和弹出菜单放在一起
	--       long_message_to_split = true, --长消息将被分割后发送
	--       inc_rename = false, --为inc-rename.nvim启用输入框
	--       lsp_doc_border = false,
	--     },
	--   },


}
