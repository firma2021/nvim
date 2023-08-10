--显示代码大纲
return
{
    {
        "stevearc/aerial.nvim",

        event = { "BufReadPost", "BufNewFile" },

        dependencies =
		{
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons",
        },

        keys =
		{
            {
                "go",
                function()
                    require("aerial").toggle()
                end,
                desc = "goto symbols outline",
            },
        },

		--大部分配置使用默认值，下面只重写了少量自定义配置
        opts =
		{
            --只显示一个全局的代码大纲
			attach_mode = "global",

            backends = { "lsp", "treesitter", "markdown", "man" },

			default_direction = "prefer_left",

			-- Show box drawing characters for the tree hierarchy
            show_guides = true,

			-- Set to false to display all symbols
            filter_kind = false,
        },
    },
}
