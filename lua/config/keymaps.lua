-- modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

vim.keymap.set({ "n", "v", "o" }, "H", "^", { desc = "map 'H' to '^'" }) --normal, visual, operator模式下的映射
vim.keymap.set({ "n", "v", "o" }, "L", "$", { desc = "map 'L' to '$'" })

-- map("n", "<leader>pt", "<cmd>TSModuleInfo<cr>", { desc = "treesitter module info" })

vim.keymap.set("n", "x", '"_X')    --普通模式下，x删除一个字符，但不保存到剪贴板里
vim.keymap.set("n", "dw", 'vb"_d') --普通模式下，dw删除一个单词，但不保存到剪贴板里

vim.keymap.set("n", "+", "<c-a>")  --普通模式下，按+将数字加1,按-将数字减1
vim.keymap.set("n", "-", "<c-x>")  --

vim.keymap.set("n", "<c-a>", "gg<s-v>G")

vim.keymap.set("n", "<leader>n", "<cmd>enew<cr>", {desc = "edit new file"})
vim.keymap.set("n", "<leader>q", "<cmd>confirm q<cr>", {desc = "confirm quit"})
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", {desc = "save"})

vim.keymap.set("n", "<c-s>", "<cmd>w!<cr>", {desc = "force save"})
vim.keymap.set("n", "<c-q>", "<cmd>q!<cr>", {desc = "force quit"})

vim.keymap.set("n", "|", "<cmd>vsplit<cr>", {desc = "vertical split"})
vim.keymap.set("n", "\\", "<cmd>split<cr>", {desc = "horizontal split"})
