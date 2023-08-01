--pattern: 只在特定类型的文件上执行自动命令
--buffer: 只在指定的buffer上执行自动命令
--自动命令组的clear选项：为false时，每次加载此文件，都会重复创建相同的自动命令，为true时则不会。

-- 您可以在自动命令的回调函数中, 调用vim.fn.expand("<abuf>") 来获得文件的相关信息。
-- <afile> autocmd file name
-- <abuf> autocmd buffer number
-- <amatch> autocmd matched name (即file type)


--粘贴模式用于在插入文本时保留原始文本的缩进格式和特殊字符, 此模式下可能会出现格式混乱
vim.api.nvim_create_autocmd("InsertLeave", { pattern = "*", command = "set nopaste" })

--高亮复制的文本, see :help vim.highlight.on_yank()
--
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd(
    'TextYankPost',
    {
		group = highlight_group,
		pattern = '*',
		callback = function() vim.highlight.on_yank() end,
		desc = "highlight when yank",
    }
)
