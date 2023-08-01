--vim.keymap.set()的第一个参数可以是模式列表，比老式的，只能指定一种模式的vim.api.nvim_set_keymap更易用。
-- see :help vim.keymap.set()

-- modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- "<cmd>...<cr>"不会在命令栏中显示执行的命令，而":...<cr>"可能显示，可以指定silent = true选项禁止显示。

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true }) --将空格映射为不执行任何操作

--如果设置了wrap选项，很长的一行将被折回成多行显示。此时按下j/k后，将在逻辑行中上下移动，而不是物理行
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })


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

vim.keymap.set("v", "J", "<cmd>m >+1<cr>gv=gv", {desc = "move the block upwards"})
vim.keymap.set("v", "K", "<cmd>m '<-2<cr>gv=gv", {desc = "move the block downwards"})

-- vim.keymap.set("n", "<c-A-Tab>", "<Cmd>bNext<CR>", { noremap = true, silent = true, desc="buffer next"})
