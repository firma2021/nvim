return
{
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(plugin, opts)
			vim.list_extend(opts.ensure_installed, { "make", "cmake" })
		end,
    },

	{
		"mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			vim.list_extend(opts.ensure_installed, { "cmakelang" })
		end,
	},

	{
		"neovim/nvim-lspconfig",
        opts =
		{
            servers =
			{
				neocmake = {},
			},
		},
    },

	{
        "Civitasv/cmake-tools.nvim",

		lazy = true,
        event = "BufRead",

        opts = {},
	},
}
