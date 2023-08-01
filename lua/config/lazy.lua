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
            { import = "plugins.util" },
            { import = "plugins.code_runner" },
        },

        defaults =
        {
            lazy = false,    --插件是否要懒加载
            version = false, --使用最近的git提交，而不是带版本号的release版本，因为release版本可能是老旧的
        },

        install = { colorscheme = { "catppuccin", } },

        checker = { enabled = true }, --自动检查插件更新

        performance =
        {
            rtp =
            {

                disabled_plugins = --禁用一些运行时路径中的插件
                {
                    "gzip",
                    "matchit",
                    "matchparen",
                    "netrwPlugin",
                    "tarPlugin",
                    "tohtml",
                    "tutor",
                    "zipPlugin",
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
vim.keymap.set("n", "<leader>ph", function() require("lazy").home() end, {desc = "lazy plugin list"})
vim.keymap.set("n", "<leader>ps", function() require("lazy").sync() end, {desc = "lazy sync (install, clean, update)"})
vim.keymap.set("n", "<leader>pu", function() require("lazy").update() end, {desc = "lazy update plugins"})
vim.keymap.set("n", "<leader>pU", function() require("lazy").check() end, {desc = "lazy check for updates, show git log"})
