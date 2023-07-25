-- see :help vim.o
--vim.opt是比vim.o更方便的lua接口



--前导键--
--在加载lazy插件前，必须设置 mapleader，以确保键位映射是正确的
--See :help mapleader
vim.g.mapleader = " "      --全局设置
vim.g.maplocalleader = " " --Local Leader key, 只在当前缓冲区有效


--时间--
vim.opt.timeoutlen = 300 --输入延迟。快捷键连击的判定时间。在300毫秒内没有再次输入，Vim将认为输入完成并执行相应的操作
vim.opt.updatetime = 250 --这个时间内光标没有移动，会触发CursorHold事件；该时间内没有打字，将保存swap文件到硬盘


--编码--
vim.opt.encoding = "utf-8"                           --vim内部使用的字符编码。可以在vim中输入:set encoding命令来查看当前编码
vim.opt.fileencodings = { "utf-8", "gbk", "utf-16" } --打开文件时, 尝试识别这些编码格式
vim.opt.fileencoding = "utf-8"                       --文件保存时的字符编码
vim.opt.termencoding = "utf-8"                       --终端的编码


--编辑设置--
vim.opt.backspace = { "indent", "eol", "start"}
vim.opt.number = true                 --显示行号
vim.opt.relativenumber = false        --虽然显示相对行号后方便跳转，但显示绝对行号更自然
vim.opt.cursorline = true             --高亮当前行
vim.opt.scrolloff = 8                 --如果光标的置移出了窗口，那么它会带动窗口的内容移动几行，即上下文的行数
vim.opt.sidescrolloff = 8             --如果光标位置移出了窗口，那么它会带动窗口的内容移动几列
vim.opt.signcolumn = "yes"            --始终显示 sign column（最左侧的提升性图标）
vim.opt.whichwrap = "h,l,<,>,[,]"     --当光标在文本行的开头或结尾时，按下这些键可以换行。
vim.opt.matchpairs:append { "<:>" }   --将<和>作为一对匹配的括号字符, 高亮显示之
vim.opt.virtualedit = "block,onemore" --可以将光标移动到行末的下一个位置
vim.wo.colorcolumn = "80"             --在第80列显示垂直辅助线

--折行--
vim.opt.wrap = false    --全局设置：文本超出屏幕宽度时不换行；之后我们会设置某些类型的文件换行
vim.opt.textwidth = 0   --文本超出80个字符时不换行
vim.opt_local_wrap = true
vim.opt.showbreak = "↪" --在折行时显示一个可见的断行符

--缩进--
local indent_size = 4
local tab_size = 8
vim.opt.tabstop = tab_size        --\t宽度为8
vim.opt.expandtab = true          --在插入模式下，用多个空格代替Tab；按下ctrl v后，再按Tab，才会输入\t符
vim.opt.softtabstop = indent_size --插入模式下按Tab键添加缩进，缩进宽度为4
vim.opt.shiftwidth = indent_size  --普通模式和可视模式下，缩进宽度为4.(普通模式下用> < =  添加、删除、对齐缩进，可视模式下用> < = 处理缩进)
vim.opt.shiftround = true         --使用> <等命令缩进时，缩进量自动调整到shiftwidth的倍数
vim.opt.autoindent = true         --换行时，复制上一行的缩进
vim.opt.smartindent = true        --编写代码时智能缩进；而vim.opt.cindent启用c语言风格的缩进,比smartindent更严格
vim.opt.smarttab = true           --根据已有的缩进来确定新行的缩进
vim.opt.breakindent = true        --换行时，保留上一行的缩进

--查找--
vim.opt.hlsearch = true  --普通模式下, 使用/或?命令, 向前或向后搜索文本时，高亮显示匹配的文本
vim.opt.incsearch = true --启用增量搜索: 输入每个字符后都更新搜索结果
vim.opt.smartcase = true --如果搜索模式包含至少一个大写字母, 则区分大小写, 否则不区分


--搜索--
vim.opt.grepprg = "rg --vimgrep"                 --使用rg --vimgrep命令进行搜索。rg即ripgrep,是Rust语言编写的grep高级替代
vim.opt.grepformat = "%f:%l:%c:%m"               --文件名，行号，列号，匹配内容
vim.opt.inccommand = "split"                     --增量搜索时，既在当前窗口高亮显示匹配项，又在新窗口中显示所有匹配项
vim.opt.path:append { "**" }                     --使用:find、:edit命令时，在该路径（当前目录及子目录）中搜索文件
vim.opt.wildignore:append { "*/node_modules/*" } --在文件名补全和文件浏览时忽略的目录
vim.opt.formatoptions:append { "r" }             --自动识别和处理反引号
vim.opt.history = 200                            --保存200条命令历史

--文件保存--
vim.opt.autoread = true              --文件被外部程序修改后, 自动重新读取文件
vim.opt.autowrite = true             --切换缓冲区或退出Vim时, 自动保存当前文件
vim.opt.confirm = true               --在用户执行一些可能会导致数据丢失或不可逆操作时，提示用户进行确认
vim.opt.writebackup = true           --在写入文件前创建备份文件(以~结尾，包含了文件的上一次保存状态)
vim.opt.backup = false               --如果为false, 成功写入后删除备份文件
vim.opt.backupskip = "/tmp/*, *.log" --这些文件将不被备份
vim.opt.swapfile = false             --禁止创建交换文件，它通常以.swp结尾, 在编辑器正常关闭时自动删除, 在Vim崩溃或编辑器意外关闭时恢复文件
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undodir = vim.fn.expand("$HOME/.local/share/nvim/undodir")


--缓冲区--
vim.opt.hidden = true                                                   --切换缓冲区时，隐藏而不是关闭旧缓冲区
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" } --保存会话文件时要保存的信息

--窗口--
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.winminwidth = 5

--鼠标--
vim.opt.mouse = "a"                 --启用鼠标
vim.opt.mousemodel = "popup_setpos" --点击鼠标右键后，弹出菜单，光标移动到点击处(setpos)

--弹出式菜单--
vim.opt.pumheight = 10 --高度，即菜单项的最大数目
vim.o.pumwidth = 40
vim.opt.pumblend = 30  --透明度为30%

--剪切板--
vim.opt.clipboard = "unnamedplus" --使用+寄存器，以同步操作系统和neovim的剪切板。 See :help clipboard


--显示不可见字符--
vim.opt.listchars = { trail = "·", tab = "▸-", extends = ">", precedes = "<" } --space = "-"; print(vim.inspect(vim.opt.listchars:get()))
vim.opt.list = true



--补全--
vim.opt.wildmenu = true                       -- 在命令模式中输出命令时，按Tab键自动补全命令和参数
vim.opt.wildmode = "longest:full,full"        --启动wildmenu；补全下一个匹配项
vim.opt.completeopt = "menu,menuone,noselect" --显示一个菜单列出可选的补全项，如果只有一个补全项，Vim会自动选择该项，但不会自动插入补全项



--开启真彩色--
vim.opt.termguicolors = true

--拼写检查--
vim.opt.spell = true
vim.opt.spelllang = { "en_us", "cjk" } -- 检查英语和东亚语
vim.opt.spelloptions = "camel"         -- 检查驼峰单词


--markdown--
vim.opt.conceallevel = 3             --隐藏Markdown中的*标记的粗体和斜体
vim.g.markdown_recommended_style = 0 --不使用建议的语法高亮风格

--格式化--
vim.opt.formatoptions = "jcroqlnt"


--状态栏与命令栏--
vim.opt.laststatus = 0                                     --不显示内置状态栏，我们会启动第三方插件
vim.opt.showmode = false
vim.opt.shortmess:append({ W = true, I = true, c = true }) --在执行某些操作时不显示的短消息：不显示写入、插入、补全消息提示
--vim.opt.showcmd = true --在底部命令栏显示正在执行的命令，如选中几行后，显示选中的行数
-- vim.opt.cmdheight=1 --底部命令栏最多可以显示1行
--vim.opt.ruler = true --在底部命令栏显示光标位置

--标题栏--
vim.opt.title = true                       --在终端模拟器中显示vim标题
vim.opt.titlestring = "%<%F%=%l/%L - nvim" --尽可能多得显示文件名、显示文件名、后续文本居中显示、显示当前行号、总行数

--内置终端使用的shell--
vim.opt.shell = "zsh"

--ui设置--
vim.opt.winblend = 0         --设置窗口透明度，100为全透明
vim.opt.background = "dark" --设置高亮行的背景色, 可设置为light或dark
vim.opt.wildoptions = "pum"  --命令行补全时用弹出菜单显示候选项

--vim.opt.foldmethod=indent --根据代码的缩进层级自动折叠和展开代码块

--vim.opt.showmatch 输入右括号后，光标跳到左括号，持续0.5秒
--vim.opt.matchtime=5
