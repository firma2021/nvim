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
    event = { "BufReadPost", "BufNewFile" },

    keys =
	{
        { "<leader>li", "<cmd>LspInfo<cr>", desc = "LSP information" },
        { "<leader>lr", "<cmd>LspRestart<cr>", desc = "LSP restart" },
    },

    dependencies =
	{
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },

    config = function(plugin, opts)

		-- 将LspInfo面板的边框改为圆形
		require("lspconfig.ui.windows").default_options.border = "rounded"

        --texthl ：标志文本的高亮组; numhl ：标志行号的高亮组
        vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError", numhl = "" })
        vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn", numhl = "" })
        vim.fn.sign_define("DiagnosticSignHint", { text = " ", texthl = "DiagnosticSignHint", numhl = "" })
        vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo", numhl = "" })

        vim.fn.sign_define("DapStopped", { text = "󰁕 ", texthl = "DiagnosticWarn", numhl = "" })
        vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DiagnosticInfo", numhl = "" })
        vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "DiagnosticError", numhl = "" })
        vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "DiagnosticInfo", numhl = "" })
        vim.fn.sign_define("DapLogPoint", { text = ".>", texthl = "DiagnosticInfo", numhl = "" })

        vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
            border = "rounded",
        })

        vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
            border = "rounded",
        })

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

		local buffer = vim.api.nvim_get_current_buf()
        require("plugins.util.lsp_keymaps").set_buffer_lsp_keymaps(buffer)
		require("plugins.util.lsp_keymaps").set_global_lsp_keymaps()
    end,
}
