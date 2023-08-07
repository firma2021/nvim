-- 显示交互式的垂直滚动条和图标，可自定义样式
-- see :help nvim-scrollview, :help scrollview-issues

return
{
	"dstein64/nvim-scrollview",

	lazy = true,
	event = { "BufReadPost", "BufNewFile", },

	--下面的选项全部为自定义选项，未列出的使用默认值
	opts =
	{
		-- scrollview_mode = "virtual",

        excluded_filetypes = { "neo-tree", "terminal", "nofile", "aerial" },

        current_only = true, --仅在当前窗口显示滚动条

		-- 窗口的混合（blend）级别，即透明度；100为完全透明。
		winblend = 75,

		-- 要显示的图标组
		signs_on_startup = { "folds", "marks", "search",  }, --"diagnostics","spell"
	},
}
