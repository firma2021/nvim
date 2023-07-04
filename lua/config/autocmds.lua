--粘贴模式用于在插入文本时保留原始文本的缩进格式和特殊字符, 此模式下可能会出现格式混乱
vim.api.nvim_create_autocmd("InsertLeave", { pattern = "*", command = "set nopaste" })
