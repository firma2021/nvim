--mason-lspconfig是 mason.nvim 和 lspconfig 之间的桥梁，使得后两个插件的使用更容易
--see :h mason-lspconfig.setup_handlers()


return
{
	"williamboman/mason-lspconfig",

	lazy = true,
	event = { "BufReadPost", "BufNewFile" },

    enable = false,

	cmd = { "LspInstall", "LspUninstall" }, --mason-lspconfig内置命令

	dependencies =
	{
		"williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
        { "folke/neodev.nvim", opts = {} },
		"hrsh7th/cmp-nvim-lsp",
	},

	opts =
    {
        ensure_installed = {nil, },
		handlers = {},
    },

	config = function (plugin, opts)
		-- local servers = opts.servers

        -- local function make_handler(server)
        --     local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(),require("cmp_nvim_lsp").default_capabilities(), opts.capabilities or {})
        --     local server_opts = vim.tbl_deep_extend("force", { capabilities = vim.deepcopy(capabilities) }, servers[server] or {})
		-- 	if opts.setup[server] or opts.setup["*"] then return end
		-- 	require("lspconfig")[server].setup(server_opts)
		-- end

        -- local mason_lsp = require("mason-lspconfig")
        -- local ensure_installed = {}

        -- for server, configs in pairs(servers) do
        --     ensure_installed[#ensure_installed + 1] = server
        -- end

		-- mason_lsp.setup({ ensure_installed = ensure_installed, handlers = { make_handler } })
		require("mason-lspconfig").setup(opts)
	end
}
--capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()), -- nvim-cmp提供了额外的补全能力,将它广播到其它语言服务器
