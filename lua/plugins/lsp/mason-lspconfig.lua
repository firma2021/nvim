--mason-lspconfig是 mason.nvim 和 lspconfig 之间的桥梁，使得后两个插件的使用更容易
return {
	"williamboman/mason-lspconfig",

	event = { "BufReadPre", "BufNewFile" },

	cmd = { "LspInstall", "LspUninstall" }, --mason-lspconfig内置命令

	dependencies =
	{
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
	},

	opts = {
		--https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
		--如果这些服务器并没有被安装，则自动安装
		ensure_installed = {
			"clangd",
			"cmake",
			"neocmake",

			"pyright",

			"lua_ls", --short for lua language server

			"cssls",
			"html",
			"jsonls",
			"quick_lint_js",

			"marksman",

			"sqlls",

			"vimls",

			"yamlls",
		},

		automatic_installation = true, --通过lspconfig设置的服务器，如果没有安装，是否要自动安装
	},
}
