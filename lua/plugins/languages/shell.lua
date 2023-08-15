return
{
	{
        "nvim-treesitter/nvim-treesitter",

		opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, { "bash", })
		end,
    },
	{
        "williamboman/mason-lspconfig.nvim",

        opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {"bashls", })
		end,
  	},
}
