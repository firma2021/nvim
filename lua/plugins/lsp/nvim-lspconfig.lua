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
      		enabled = true, -- Neovim >= 0.10.0
        },
	},

    config = function(plugin, opts)
        require("plugins.util.lsp_keymaps")()
		require("plugins.util.diagnostics_config")()
    end,
}
