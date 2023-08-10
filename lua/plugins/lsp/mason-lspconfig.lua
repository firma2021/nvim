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
		local function make_handlers(lsp_server_name)
            local lspconfig = require("lspconfig")

            local default_opts =
            {
                capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()), -- nvim-cmp提供了额外的补全能力,将它广播到其它语言服务器
				on_attach = require("lsp_keymaps.lsp_keymaps").on_attach,
            }

            local status, handler = pcall(require, "completion.servers." .. lsp_server_name)
            if not status then
                lspconfig[lsp_server_name].setup(default_opts)
				return
			elseif type(handler) == "function" then
				handler(default_opts)
			elseif type(handler) == "table" then
				lspconfig[lsp_server_name].setup(vim.tbl_deep_extend("force", default_opts, handler))
            else
				vim.notify(lsp_server_name ..": invalid LSP server config which should return either a function or a table, but got" ..type(handler), "error", { title = "nvim-lspconfig" })
			end
		end

		local mason_lspconfig = require("mason-lspconfig")
		mason_lspconfig.setup_handlers({ make_handlers })

		require("neodev").setup({}) --提供对 neovim lua API 的函数签名帮助、文档、自动补全
	end
}
