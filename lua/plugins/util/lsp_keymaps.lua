-- 您也可以通过创建自动命令,来绑定快捷键,如 vim.api.nvim_create_autocmd('LspAttach',...)
-- see :help vim.lsp.*
--see :help vim.diagnostic.*
-- see :help K for why this keymap
-- K键在Vim中被默认绑定为显示关于光标下单词的帮助文档
-- 将hover快捷键设置为K，可以使其与Vim的默认行为保持一致

local M = {}

local function set_buffer_lsp_keymaps(bufnr)

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer = bufnr, desc = "goto definition"})
	vim.keymap.set("n", "gD",  vim.lsp.buf.declaration, { buffer = bufnr, desc = "goto declaration"})
	vim.keymap.set("n", "K",  vim.lsp.buf.hover, {buffer = bufnr, desc = "hover symbol details"})
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer = bufnr, desc = "goto implementation"})
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer = bufnr, desc = "goto definition of current type"})
	vim.keymap.set({ "n", "i"}, "<c-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "signature documentation" })
	vim.keymap.set("n", "gr",  vim.lsp.buf.references, {buffer = bufnr, desc = "goto reference"})
	vim.keymap.set({"n", "v"}, "<leader>ca",  vim.lsp.buf.code_action, {buffer = bufnr, desc = "LSP code action"})
	vim.keymap.set("n", "<leader>ra",  vim.lsp.buf.rename, {buffer = bufnr, desc = "rename symbol"})


	vim.keymap.set({"n", "v"}, "<leader>cs",  vim.diagnostic.setloclist, {buffer = bufnr, desc = "diagnostic setloclist"})
    vim.keymap.set({ "n", "v" }, "<leader>wa", vim.lsp.buf.add_workspace_folder, { buffer = bufnr, desc = "add workspace folder" })
    vim.keymap.set({ "n", "v" }, "<leader>wr", vim.lsp.buf.remove_workspace_folder, { buffer = bufnr, desc = "remove workspace folder" })
	vim.keymap.set({"n", "v"}, "<leader>wl",  function()print(vim.inspect(vim.lsp.buf.list_workspace_folders()))end, {buffer = bufnr, desc = "list workspace folders"})
end

local function set_global_lsp_keymaps()
	vim.keymap.set("n", "g[", function ()vim.diagnostic.goto_prev({ float = { border = "rounded" } }) end, { noremap = true, silent = true, desc = "goto previous diagnostic" })
	vim.keymap.set("n", "g]", function ()vim.diagnostic.goto_next({ float = { border = "rounded" } }) end, { noremap = true, silent = true, desc = "goto next diagnostic" })
	vim.keymap.set("n", "gl", function () vim.diagnostic.open_float({border = "rounded"}) end, { noremap = true, silent = true, desc = "open floating diagnostic message" }) --将光标定位到出错处后，按下此快捷键，在浮动窗口中显示错误信息
	vim.keymap.set("n", "<leader>ld", vim.diagnostic.setloclist, { noremap = true, silent = true, desc = "open diagnostics list" }) --在列表中显示所有错误信息
end

local function set_lsp_key_maps()

	vim.api.nvim_create_autocmd("LspAttach",
	{
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			set_buffer_lsp_keymaps(buffer)
			set_global_lsp_keymaps()
		end,
    }
	)
end

return set_lsp_key_maps
