--插件管理器
--see :help lazy.nvim.txt

--检查本地是否有"lazy.nvim"文件，没有则通过Git下载最新的稳定版本，添加到Vim运行时路径中
--:h rtp命令可以查看运行时路径
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" --..用于连接字符串
if not vim.loop.fs_stat(lazypath)
then
    vim.fn.system(
        { "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        }
    )
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup(
    {
        spec =                      --规格，说明(specification)
        {
            { import = "plugins.ui" }, --引入lua/plugins下的所有lua文件
            { import = "plugins.lsp" },
            { import = "plugins.dap" },
            { import = "plugins.git" },
            { import = "plugins.editor" },
            { import = "plugins.edit" },
            { import = "plugins.code_runner" },
			{ import = "plugins.languages" },
        },

        defaults =
        {
            lazy = false,    --插件是否要懒加载
            version = false, --使用最近的git提交，而不是带版本号的release版本，因为release版本可能是老旧的
        },

        install = { colorscheme = { "catppuccin", } },

        checker = { enabled = true, frequency = 60*60*24*7, }, --自动检查插件更新

        performance =
        {
            rtp =
            {
                disabled_plugins = --禁用一些运行时路径中的默认启用的内置插件
                {
                    "2html_plugin", -- 将源代码转换为 HTML 格式
					"tohtml", -- 将当前缓冲区的内容以 HTML 格式保存到文件
					"getscript", -- 从远程地址获取 Vim 脚本
					"getscriptPlugin", -- 管理和加载从远程获取的 Vim 脚本
					"gzip", -- 提供对 gzip 压缩文件的支持
					"logipat", -- 用于 IP 地址的转换和验证
					"netrw", -- 文件浏览器
					"netrwPlugin", -- 用于支持 netrw 插件的配置和设置
					"netrwSettings", -- 对 netrw 插件的进一步设置
					"netrwFileHandlers", -- 定义与 netrw 相关的文件处理程序
                    "matchit", -- 增强括号匹配
					"matchparen", -- 高亮匹配的括号
					"tar", -- 提供对 tar 文件的支持
					"tarPlugin",
					"rrhelper", -- 对 R 文件的支持
					"spellfile_plugin", --拼写检查
					"vimball", -- 对 vimball 文件的支持
					"vimballPlugin",
					"zip", -- 对 zip 压缩文件的支持
					"zipPlugin",
					"tutor", -- 内置的 Vim 教程
					"rplugin", -- 支持 Vim 插件的远程插件架构
					"syntax", -- 提供语法高亮支持
					"synmenu", -- 语法高亮菜单
					"optwin", -- 提供对选项窗口的支持
					"compiler",
					"bugreport", --报告Vim的Bug
					"ftplugin", -- 文件类型
                },
            },
        },

        config =
        {
            compile_on_sync = true,
            max_jobs = 16,
            git = {}, --git-mirrors
            display =
            {
                open_fn = function()
                    return require('lazy.util').float({ border = 'single' })
                end
            },
        },
    }
)

vim.keymap.set("n", "<leader>pi", function() require("lazy").install() end, {desc = "lazy install missing plugins"})
vim.keymap.set("n", "<leader>pl", function() require("lazy").home() end, {desc = "lazy plugin manager"})
vim.keymap.set("n", "<leader>ps", function() require("lazy").sync() end, {desc = "lazy sync (install, clean, update)"})
vim.keymap.set("n", "<leader>pu", function() require("lazy").update() end, {desc = "lazy update plugins"})
vim.keymap.set("n", "<leader>pU", function() require("lazy").check() end, {desc = "lazy check for updates, show git log"})
