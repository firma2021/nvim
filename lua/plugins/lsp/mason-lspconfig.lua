--mason-lspconfig是 mason.nvim 和 lspconfig 之间的桥梁，使得后两个插件的使用更容易
return {
	"williamboman/mason-lspconfig",

	event = { "BufReadPre", "BufNewFile" },

	cmd = { "LspInstall", "LspUninstall" }, --mason-lspconfig内置命令

	dependencies =
	{
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
		"folke/neodev.nvim",
	},

	config = function()
		require("neodev").setup({}) --提供对 neovim lua API 的函数签名帮助、文档、自动补全

		--nvim-cmp提供了额外的补全能力,将它广播到其它语言服务器
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

		-- 您也可以通过创建自动命令,来绑定快捷键,如 vim.api.nvim_create_autocmd('LspAttach',...)
		local on_attach = function(client, bufnr)
			-- 设置当前缓冲区（buffer）的自动补全函数（omnifunc）为LSP的自动补全函数
			-- "omni" 是 "omniscient" 的缩写，意思是 无所不知的
			-- 按下 <c-x> <c-o> 后, 弹出补全菜单。这个补全功能很弱，基本不会使用
			vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

			-- see :help vim.lsp.*
			if client.supports_method("textDocument/rename") then
			  vim.keymap.set("n", "<leader>lr",  vim.lsp.buf.rename, {buffer = bufnr, desc = "rename current symbol"})
			end

			if client.supports_method "textDocument/codeAction" then
			  vim.keymap.set({"n", "v"}, "<leader>la",  vim.lsp.buf.code_action, {buffer = bufnr, desc = "LSP code action"})
			end

			if client.supports_method("textDocument/definition") then
			  vim.keymap.set("n", "gd",  vim.lsp.buf.definition, {buffer = bufnr, desc = "goto definition of current symbol"})
			end

			if client.supports_method("textDocument/implementation") then
			  vim.keymap.set("n", "gI",   vim.lsp.buf.implementation, {buffer = bufnr, desc = "goto implementation of current symbol"})
			end

			if client.supports_method("textDocument/typeDefinition") then
			  vim.keymap.set("n", "gT",  vim.lsp.buf.type_definition, {buffer = bufnr, desc = "goto definition of current type"})
			end

			-- see :help K for why this keymap
			-- K键在Vim中被默认绑定为显示关于光标下单词的帮助文档
			-- 将hover快捷键设置为K，可以使其与Vim的默认行为保持一致
			if client.supports_method("textDocument/hover") then
			  vim.keymap.set("n", "K",  vim.lsp.buf.hover, {buffer = bufnr, desc = "hover symbol details"})
			end

			if client.supports_method("textDocument/signatureHelp") then
			  vim.keymap.set("i", "<c-k>",  vim.lsp.buf.signature_help, {buffer = bufnr, desc = "signature documentation"})
			end

			--less use
			if client.supports_method("textDocument/declaration") then
			  vim.keymap.set("n", "gD",  vim.lsp.buf.declaration, { buffer = bufnr, desc = "goto declaration of current symbol"})
			end

			--此后的未修改
			if client.supports_method("textDocument/codeLens") then
			  vim.api.nvim_create_augroup("lsp_codelens_refresh", { clear = false })
			  local autocmd =
			  {
				desc = "Refresh codelens",
				group = "lsp_codelens_refresh",
				buffer = buffnr,
				callback = vim.lsp.codelens.refresh,
			  }
			  vim.api.nvim_create_autocmd({ "InsertLeave", "BufEnter" }, autocmd)

			  vim.lsp.codelens.refresh()

			  vim.keymap.set("n", "<leader>ll",  vim.lsp.codelens.refresh, {buffer = bufnr, desc = "LSP codelens refresh"})
			  vim.keymap.set("n", "leader>lL",  vim.lsp.codelens.run, {buffer = bufnr, desc = "LSP codelens run"})
			end


			if client.supports_method("textDocument/formatting") then
			  vim.keymap.set({"n", "v"}, "<leader>lf",  vim.lsp.buf.format, {desc = "format buffer"})
			  vim.api.nvim_buf_create_user_command(bufnr, "Format", vim.lsp.buf.format, { desc = "Format file with LSP" })

			  vim.api.nvim_create_autocmd("BufWritePre",{callback = vim.lsp.buf.format, desc = "autoformat on save"})
			end

			if client.supports_method("textDocument/inlayHint") then
			  if vim.lsp.buf.inlay_hint then
				vim.lsp.buf.inlay_hint(bufnr, true)
			  end
			end

			if client.supports_method("textDocument/references") then
			  vim.keymap.set("n", "gr",  vim.lsp.buf.references, {desc = "references of current symbol"})
			  vim.keymap.set("n", "<leader>lR",  vim.lsp.buf.references, {desc = "search references"})
			end

			if client.supports_method("workspace/symbol") then
			  vim.keymap.set("n", "<leader>lG",  vim.lsp.buf.workspace_symbol, {desc = "search workspace symbols"})
			end

			if client.supports_method("textDocument/documentHighlight") then
			  vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
			  local highlight_references =
			  {
				desc = "highlight references when cursor holds",
				group = "lsp_document_highlight",
				buffer = buffnr,
				callback = vim.lsp.buf.document_highlight,
			  }
			  local clear_references =
			  {
				desc = "clear references when cursor moves",
				group = "lsp_document_highlight",
				buffer = buffnr,
				callback = vim.lsp.buf.clear_references,
			  }

			  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, highlight_references)
			  vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, clear_references)
			end

		  end



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
