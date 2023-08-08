--mason-lspconfig是 mason.nvim 和 lspconfig 之间的桥梁，使得后两个插件的使用更容易
return {
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
            }

            local status, handler = pcall(require, "completion.servers." .. lsp_server_name)
            if not status then
                lspconfig[lsp_server_name].setup(default_opts)
				return
			elseif  type(handler) == "function" then
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

		local lspconfig = require('lspconfig')
		local mason_lspconfig = require('mason-lspconfig')


		--see :h mason-lspconfig.setup_handlers()
		mason_lspconfig.setup_handlers(
		{
		  function(server_name)
			require('lspconfig')[server_name].setup
			{
			  capabilities = capabilities,
			  on_attach = on_attach,
			}
		  end,
		  ["clangd"] = function ()
			lspconfig.clangd.setup
			{
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },

				-- see clangd --help-hidden
				cmd =
				{
					"clangd",
					"--query-driver=/usr/bin/**/clang-*,/usr/bin/gcc,/usr/bin/g++",
					"--background-index",
					"--background-index-priority=background",
					"--all-scopes-completion",
					"--completion-style=detailed",
					"--function-arg-placeholders",
					"--header-insertion=iwyu",
					"--header-insertion-decorators",
					"--all-scopes-completion",
					"-j=8",
					"--pch-storage=memory",

					"--log=info",
					"--offset-encoding=utf-16",
					"--pretty",

					"--clang-tidy",

					"--enable-config",

					-- "--fallback-style=~/.config/clangd/.clang-format"
				},
				capabilities = capabilities,
			  	on_attach = on_attach,
			}
		  end,

		  ["lua_ls"] = function()
			lspconfig.lua_ls.setup
			{
				settings =
				{
					Lua =
					{
						diagnostics =
						{
							globals = { "vim" } --使语言服务器识别 vim global
						},
						workspace =
						{
							library = vim.api.nvim_get_runtime_file("", true), --让语言服务器发现Neovim运行时文件
						},
					}
				},
				capabilities = capabilities,
			  	on_attach = on_attach,
			}
		end,
		}
	)
	end
}
