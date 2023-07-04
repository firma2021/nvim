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
            { import = "plugins.ui" },
            { import = "plugins.lsp" },
            --{ import = "plugins.languages" },
        },
        defaults =
        {
            lazy = false,    --插件默认为懒加载
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

-- local api = vim.api
-- local M = {}
-- function M.show_colorschemes()
--     local bufnr = api.nvim_create_buf(false, true)
--     local winnr = api.nvim_open_win(bufnr, true, {
--         relative = 'cursor',
--         width = 30,
--         height = #vim.list_extend(vim.fn.getcompletion('', 'color'), 1),
--         row = 1,
--         col = 0,
--         style = 'minimal'
--     })
--     -- 设置窗口高亮
--     api.nvim_buf_set_option(bufnr, 'modifiable', true)
--     api.nvim_buf_set_lines(bufnr, 0, -1, false, vim.fn.getcompletion('', 'color'))
--     api.nvim_buf_set_option(bufnr, 'modifiable', false)
--     api.nvim_win_set_option(winnr, 'cursorline', true)
--     api.nvim_win_set_option(winnr, 'cursorcolumn', false)
--     api.nvim_win_set_option(winnr, 'wrap', false)
--     -- 设置窗口的映射
--     api.nvim_buf_set_keymap(bufnr, 'n', '<CR>', ':lua require("colorschemes").select_colorscheme()<CR>',
--         { nowait = true, noremap = true })
--     api.nvim_buf_set_keymap(bufnr, 'n', 'q', ':lua require("colorschemes").close_colorscheme_window()<CR>',
--         { nowait = true, noremap = true })
-- end

-- function M.select_colorscheme()
--     local colorscheme = api.nvim_get_current_line()
--     api.nvim_set_option('colorscheme', colorscheme)
--     M.close_colorscheme_window()
-- end

-- function M.close_colorscheme_window()
--     local bufnr = api.nvim_get_current_buf()
--     local winnr = api.nvim_get_current_win()
--     api.nvim_win_close(winnr, true)
--     api.nvim_buf_delete(bufnr, {})
-- end

-- return M


-- command! Colorschemes lua require('colorschemes').show_colorschemes()
