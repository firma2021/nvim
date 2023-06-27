--插件管理

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" --..用于连接字符串
if not vim.loop.fs_stat(lazypath)                            --检查本地是否有"lazy.nvim"文件，没有则通过Git下载最新的稳定版本，添加到Vim运行时路径中
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
            { import = "plugins" }, --引入lua/plugins下的所有lua文件
        },
        defaults =
        {
            lazy = true,     --插件默认为懒加载
            version = false, --使用最近的git提交，而不是带版本号的release版本，因为release版本可能是老旧的
        },
        install = { colorscheme = { "tokyonight", "habamax" } },
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
