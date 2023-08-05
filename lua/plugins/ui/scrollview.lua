-- 显示交互式的垂直滚动条和图标，可自定义样式
-- see :help nvim-scrollview, :help scrollview-issues

return
{
	"dstein64/nvim-scrollview",

	event = { "BufReadPost", "BufNewFile", "BufAdd", },

	opts =
	{
		scrollview_mode = "virtual",

		excluded_filetypes = { "NeoTree", "terminal", "nofile", "Outline" },

		-- 窗口的混合（blend）级别，即透明度；100为完全透明。
		winblend = 0,

		-- 要显示的图标组
		signs_on_startup = { "diagnostics", "folds", "marks", "search", "spell" },

		diagnostics_error_symbol = "",
		diagnostics_warn_symbol = "",
		diagnostics_info_symbol = "",
		diagnostics_hint_symbol = "󰌵",
	},
}
