local function set_lsp_ui()
	require("lspconfig.ui.windows").default_options.border = "rounded" -- 将LspInfo面板的边框改为圆形

	local icons = require("plugins.util.icons").diagnostics
	vim.fn.sign_define("DiagnosticSignError", { text = icons.Error, texthl = "DiagnosticSignError", numhl = "" }) --texthl ：标志文本的高亮组; numhl ：标志行号的高亮组
	vim.fn.sign_define("DiagnosticSignWarn", { text = icons.Warn, texthl = "DiagnosticSignWarn", numhl = "" })
	vim.fn.sign_define("DiagnosticSignHint", { text = icons.Hint, texthl = "DiagnosticSignHint", numhl = "" })
    vim.fn.sign_define("DiagnosticSignInfo", { text = icons.Info, texthl = "DiagnosticSignInfo", numhl = "" })

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded",})
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded",})
end

return set_lsp_ui
