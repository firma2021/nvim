return
{
	{
		"nvim-treesitter/nvim-treesitter",

		opts = function(plugin, opts)
			vim.list_extend(opts.ensure_installed, { "yaml","jsdoc", "json", "rst", "toml"})
		end,
	},
}
