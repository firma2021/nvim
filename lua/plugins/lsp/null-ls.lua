--将Neovim作为语言服务器使用，以注入LSP诊断、代码建议。
return {
	"jose-elias-alvarez/null-ls.nvim",

	event = { "BufReadPre", "BufNewFile" },

	keys = {
		{ "<leader>lI", "<cmd>NullLsInfo<cr>", desc = "null-ls information" },
	},

	dependencies = { "mason.nvim" },

	--https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/CONFIG.md
	opts =  function()
		local null_ls = require("null-ls")

		return
		{
			debug = false, --禁用debug模式

			sources =
			{
				null_ls.builtins.formatting.shfmt, --shell
				null_ls.builtins.formatting.stylua, --lua

				-- null_ls.builtins.diagnostics.cppcheck,
				-- null_ls.builtins.diagnostics.cpplint,
				null_ls.builtins.diagnostics.clang_check,
				null_ls.builtins.formatting.clang_format, --c/c++

				null_ls.builtins.diagnostics.shellcheck,

				--python
				null_ls.builtins.diagnostics.mypy,
				null_ls.builtins.diagnostics.ruff,
				null_ls.builtins.formatting.black,

				null_ls.builtins.completion.spell,

				null_ls.builtins.code_actions.gitsigns,

				null_ls.builtins.hover.dictionary,
			},

			diagnostics_format = "[#{c}](#{s}) #{m}", --代码行号，信息发出者，信息

			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre",
					{
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ bufnr = bufnr })
						end,
				 	}
				)
				end
			end,
		}
	end,

}
