--提供一些基于tree-sitter的基本功能, 如语法高亮
--see :help nvim-treesitter
--use plugin: nvim-treesitter/playground to show concrete syntax tree

return
{
    "nvim-treesitter/nvim-treesitter",

	lazy = true,
    event = { "BufReadPost", "BufNewFile" },

    build = ":TSUpdate", --当插件被安装或更新后，执行此命令，将所有安装好的解析器更新到最近的版本

    dependencies =
	{
        {
			"nvim-treesitter/nvim-treesitter-textobjects",
		}
    },

    cmd = { "TSUpdateSync" }, --执行此命令后，加载插件

    keys = --按下这些键后，加载插件
	{
        { "<c-space>", desc = "increment selection" },
        { "<bs>", mode = "x", desc = "decrement selection" },
    },

    opts =
	{
        highlight = { enable = true },
        indent = { enable = true }, -- 为=运算符启用基于Treesitter的代码格式化

		ensure_installed =
		{
            "sql",
            "query",
            "regex",
        },

        auto_install = true,

        incremental_selection = -- 启用增量选择
		{
            enable = true,
            keymaps =
			{
                init_selection = "<c-space>",
                node_incremental = "<c-space>",
                node_decremental = "<bs>",
                scope_incremental = false,
            },
        },
    },

	config = function (plugin, opts)
		require("nvim-treesitter.configs").setup(opts)
	end
}
