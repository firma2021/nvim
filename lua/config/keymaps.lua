--vim.keymap.set()的第一个参数可以是模式列表，比老式的，只能指定一种模式的vim.api.nvim_set_keymap更易用。
-- see :help vim.keymap.set()

-- modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",
--   select_mode = "s",

-- "<cmd>...<cr>"不会在命令栏中显示执行的命令，而":...<cr>"可能显示，可以指定silent = true选项禁止显示。
--
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true }) --将空格映射为不执行任何操作

--如果设置了wrap选项，很长的一行将被折回成多行显示。此时按下j/k后，将在逻辑行中上下移动，而不是物理行
vim.keymap.set({ "n", "x" }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })



vim.keymap.set({ "n", "v", "o" }, "H", "^", { desc = "map 'H' to '^'" }) --normal, visual, operator模式下的映射
vim.keymap.set({ "n", "v", "o" }, "L", "$", { desc = "map 'L' to '$'" })

-- map("n", "<leader>pt", "<cmd>TSModuleInfo<cr>", { desc = "treesitter module info" })

vim.keymap.set("n", "x", '"_X')    --普通模式下，x删除一个字符，但不保存到剪贴板里
vim.keymap.set("n", "dw", 'vb"_d') --普通模式下，dw删除一个单词，但不保存到剪贴板里

vim.keymap.set("n", "+", "<c-a>")  --普通模式下，按+将数字加1,按-将数字减1
vim.keymap.set("n", "-", "<c-x>")  --

vim.keymap.set("n", "<c-a>", "gg<s-v>G")

vim.keymap.set("n", "<leader>n", "<cmd>enew<cr>", {desc = "edit new file"})
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", {desc = "save"})

vim.keymap.set("n", "<c-s>", "<cmd>w!<cr>", {desc = "force save"})
vim.keymap.set("n", "<c-q>", "<cmd>q!<cr>", {desc = "force quit"})

vim.keymap.set("n", "|", "<cmd>vsplit<cr>", {desc = "vertical split"})
vim.keymap.set("n", "\\", "<cmd>split<cr>", {desc = "horizontal split"})


--窗口设置：窗口跳转
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "go to left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "go to right window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "go to down window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "go to up window" })

--窗口设置：调整窗口大小
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "increase window width" })

-- 上下移动当前行
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down", silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up", silent = true })

-- 保存文件
vim.keymap.set({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "save file" })
vim.keymap.set("n", "<leader>n", "<cmd>enew<cr>", { desc = "new File" })

-- 退出neovim
vim.keymap.set("n", "<leader>qw", "<cmd>wqa<cr>", { desc = "save and quit all" })
vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "quit all" })

-- windows
vim.keymap.set("n", "<leader>ww", "<C-W>p", { desc = "Other window"})
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window"})
vim.keymap.set("n", "<leader>w-", "<C-W>s", { desc = "Split window below" })
vim.keymap.set("n", "<leader>w|", "<C-W>v", { desc = "Split window right"})
vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split window below"})
vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split window right"})

-- tabs
vim.keymap.set("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
vim.keymap.set("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
vim.keymap.set("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
vim.keymap.set("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
vim.keymap.set("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })
