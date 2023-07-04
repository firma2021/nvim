--lazy.nvim能够在加载插件时，设置插件的键位映射。
--如果已经设置了插件的键位映射，则不再重复设置相同的键位映射。

-- map({ "n", "v", "o" }, "H", "^", { desc = "map 'H' to '^'" }) --normal, visual, operator模式下的映射
-- map({ "n", "v", "o" }, "L", "$", { desc = "map 'L' to '$'" })

-- map("n", "<leader>us", function() util.toggle("spell") end, { desc = "toggle spell check" })

-- map("n", "<leader>pt", "<cmd>TSModuleInfo<cr>", { desc = "treesitter module info" })
vim.keymap.set("n", "x", '"_X')    --普通模式下，x删除一个字符，但不保存到剪贴板里
vim.keymap.set("n", "dw", 'vb"_d') --普通模式下，dw删除一个单词，但不保存到剪贴板里

vim.keymap.set("n", "+", "<c-a>")  --普通模式下，按+将数字加1,按-将数字减1
vim.keymap.set("n", "-", "<c-x>")  --

vim.keymap.set("n", "<c-a>", "gg<s-v>G")
