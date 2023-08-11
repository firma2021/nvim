return
{
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(plugin, opts)
			vim.list_extend(opts.ensure_installed, { "cmake" })
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
		"jose-elias-alvarez/null-ls.nvim",
		opts = function(_, opts)
		local nls = require("null-ls")
		opts.sources = opts.sources or {}
		vim.list_extend(opts.sources, {
			nls.builtins.diagnostics.cmake_lint,
		})
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
