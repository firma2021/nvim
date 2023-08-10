-- 您也可以通过创建自动命令,来绑定快捷键,如 vim.api.nvim_create_autocmd('LspAttach',...)

local on_attach = function(client, bufnr)
	-- 设置当前缓冲区（buffer）的自动补全函数（omnifunc）为LSP的自动补全函数
	-- "omni" 是 "omniscient" 的缩写，意思是 无所不知的
	-- 按下 <c-x> <c-o> 后, 弹出补全菜单。这个补全功能很弱，基本不会使用
	vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

	-- see :help vim.lsp.*
	if client.supports_method("textDocument/rename") then
		vim.keymap.set("n", "gr",  vim.lsp.buf.rename, {buffer = bufnr, desc = "rename current symbol"})
	end

	if client.supports_method "textDocument/codeAction" then
		vim.keymap.set({"n", "v"}, "ga",  vim.lsp.buf.code_action, {buffer = bufnr, desc = "LSP code action"})
	end

	if client.supports_method("textDocument/definition") then
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = bufnr, desc = "goto definition of current symbol"})
	end

	if client.supports_method("textDocument/implementation") then
		vim.keymap.set("n", "gI", vim.lsp.buf.implementation, {buffer = bufnr, desc = "goto implementation of current symbol"})
	end

	if client.supports_method("textDocument/typeDefinition") then
		vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, {buffer = bufnr, desc = "goto definition of current type"})
	end

	-- see :help K for why this keymap
	-- K键在Vim中被默认绑定为显示关于光标下单词的帮助文档
	-- 将hover快捷键设置为K，可以使其与Vim的默认行为保持一致
	if client.supports_method("textDocument/hover") then
		vim.keymap.set("n", "K",  vim.lsp.buf.hover, {buffer = bufnr, desc = "hover symbol details"})
	end

    if client.supports_method("textDocument/signatureHelp") then
        vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "signature documentation" })
    end

	if client.supports_method("textDocument/switchSourceHeader") then
		vim.keymap.set("n", "gh", vim.lsp.buf.switch_source_header, {buffer = bufnr, desc = "switch source header"})
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
		buffer = bufnr,
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
		buffer = bufnr,
		callback = vim.lsp.buf.document_highlight,
		}
		local clear_references =
		{
		desc = "clear references when cursor moves",
		group = "lsp_document_highlight",
		buffer = bufnr,
		callback = vim.lsp.buf.clear_references,
		}

		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, highlight_references)
		vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, clear_references)
	end

end
