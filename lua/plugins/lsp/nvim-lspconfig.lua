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

    dependencies =
	{
        {
            "folke/neodev.nvim", --提供对 neovim lua API 的函数签名帮助、文档、自动补全
			opts = {},
		},
        {
			"williamboman/mason.nvim",
		},
        {
            "williamboman/mason-lspconfig.nvim",
		},
		{
        "hrsh7th/cmp-nvim-lsp",
      	},
    },

	opts =
	{
		diagnostics =
		{
			underline = true,
			update_in_insert = true,
			virtual_text =  --在诊断范围旁边显示虚拟文本
			{
				spacing = 4,
				source = "if_many",
				prefix = "●", -- "icons" if neovim version >= 0.10.0
			},
			severity_sort = true, --按照严重程度排序
        },

        inlay_hints =
		{
      		enabled = true, -- Neovim >= 0.10.0
        },

        capabilities = {},

		servers =
		{
      		jsonls = {},
			lua_ls =
			{
				settings =
				{
					Lua =
					{
						workspace =
						{
							checkThirdParty = false,
						},
						completion =
						{
							callSnippet = "Replace",
						},
					},
				},
			},
        },

		-- you can do any additional lsp server setup here
      	-- return true if you don't want this server to be setup with lspconfig
		setup = {},
	},

    config = function(plugin, opts)
        local servers = opts.servers

        local function make_handler(server)
            local capabilities = vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(),require("cmp_nvim_lsp").default_capabilities(), opts.capabilities or {})
            local server_opts = vim.tbl_deep_extend("force", { capabilities = vim.deepcopy(capabilities) }, servers[server] or {})
			if opts.setup[server] or opts.setup["*"] then return end
			require("lspconfig")[server].setup(server_opts)
		end

        local mason_lsp = require("mason-lspconfig")
        local ensure_installed = {}

        for server, configs in pairs(servers) do
            ensure_installed[#ensure_installed + 1] = server
        end

		mason_lsp.setup({ ensure_installed = ensure_installed, handlers = { make_handler } })

        local diagnostics_on =
		{
            virtual_text = true, --在诊断范围旁边显示虚拟文本
            severity_sort = true, --按照严重程度排序
            signs = { active = "signs" }, --左侧显示诊断标志
            update_in_insert = true,
            underline = true,  --在诊断范围下方显示下划线
            float =
			{
                focused = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        }

        vim.diagnostic.config(diagnostics_on)

        require("plugins.util.lsp_keymaps")()
    end,
}
