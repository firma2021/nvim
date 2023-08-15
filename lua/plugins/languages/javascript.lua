return
{
	{
		"nvim-treesitter/nvim-treesitter",
		opts = function(plugin, opts)
			vim.list_extend(opts.ensure_installed, { "html", "css", "javascript", })
		end,
    },

	{
    "williamboman/mason-lspconfig.nvim",
        opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {"html","jsonls",})
		end,
  	},
}
