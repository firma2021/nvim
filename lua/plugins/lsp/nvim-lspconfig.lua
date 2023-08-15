--提供LSP的默认启动配置，如 require 'lspconfig'.pyright.setup{}，就加载了pyright的默认启动配置

--您也可以像下面这样，使用原生的API挨个配置LSP，见https://neovim.io/doc/user/lsp.html
-- 启动LSP：
-- vim.lsp.start({
--   name = 'my-server-name',
--   cmd = {'name-of-language-server-executable'},
--   root_dir = vim.fs.dirname(vim.fs.find({'setup.py', 'pyproject.toml'}, { upward = true })[1]),
-- })
-- 使用LSP提供的能力：
-- vim.lsp.buf.references()

return
{
    "neovim/nvim-lspconfig",

	lazy = true,
    event = { "BufReadPre", "BufNewFile" },

    keys =
	{
        { "<leader>li", "<cmd>LspInfo<cr>", desc = "LSP information" },
        { "<leader>lr", "<cmd>LspRestart<cr>", desc = "LSP restart" },
    },

	opts =
	{
        inlay_hints =
		{
      		enabled = true,
        },
	},

    config = function(plugin, opts)
        require("plugins.util.lsp_keymaps")()
        require("plugins.util.diagnostics_config")()
        require("plugins.util.lsp_ui")()

	-- 	local capabilities = vim.tbl_deep_extend(
    --     "force",
    --     {},
    --     vim.lsp.protocol.make_client_capabilities(),
    --     has_cmp and cmp_nvim_lsp.default_capabilities() or {},
    --     opts.capabilities or {}
    --   )
		local cap = require('cmp_nvim_lsp').default_capabilities()
            require('lspconfig').clangd.setup(
			{
				keys =
				{
					{ "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "switch source/header (C/C++)" },
				},

				capabilities = vim.list_extend(cap, { offsetEncoding = { "utf-16" },}),

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

					"-j=12",

					"--pch-storage=memory",

					"--pretty",

					"--clang-tidy",

					"--enable-config",
				},

				init_options =
				{
					usePlaceholders = true,
					completeUnimported = true,
					clangdFileStatus = true,
				},
			}
            )
    end,
}
