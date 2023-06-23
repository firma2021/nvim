--检查本地是否有一个名为 "lazy.nvim" 的文件，如果没有就通过 Git 下载最新的稳定版本，并将其添加到 Vim 的运行时路径中
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" --..用于连接字符串
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system
    (
        {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath,
        }
    )
end
vim.opt.rtp:prepend(lazypath)

--管理插件
require("lazy").setup
(
    {
        spec =
        {
            -- add LazyVim and import its plugins
            { "LazyVim/LazyVim", import = "lazyvim.plugins" },
            -- import any extras modules here
            -- { import = "lazyvim.plugins.extras.lang.typescript" },
            -- { import = "lazyvim.plugins.extras.lang.json" },
            -- { import = "lazyvim.plugins.extras.ui.mini-animate" },
            -- import/override with your plugins
            { import = "plugins" },
        },
        defaults =
        {
            lazy = true, --插件默认为懒加载
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
    }
)
