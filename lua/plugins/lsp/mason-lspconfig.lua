--mason-lspconfig是 mason.nvim 和 lspconfig 之间的桥梁，使得后两个插件的使用更容易
--see :h mason-lspconfig.setup_handlers()


return
{
	"williamboman/mason-lspconfig",

	event = { "BufReadPost", "BufNewFile" },

	cmd = { "LspInstall", "LspUninstall" }, --mason-lspconfig内置命令

	dependencies =
	{
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
		"folke/neodev.nvim",
	},

	opts =
    {
		ensure_installed =
        {
			"bashls",
			"clangd",
			"html",
			"jsonls",
			"lua_ls",
			"pylsp",
			-- "gopls",
		},
    },

    config = function()
		require("neodev").setup({}) --提供对 neovim lua API 的函数签名帮助、文档、自动补全
	end
}
--capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()), -- nvim-cmp提供了额外的补全能力,将它广播到其它语言服务器
