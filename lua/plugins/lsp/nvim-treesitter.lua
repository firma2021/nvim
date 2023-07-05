--提供一个简单易用的方法，以在neovim中使用tree-sitter的接口；
--提供一些基于tree-sitter的基本功能，例如语法高亮。

return
{
    "nvim-treesitter/nvim-treesitter",

    version = false,
    build = ":TSUpdate",                                                            --当插件被安装或更新后，执行此命令，将所有安装好的解析器更新到最近的版本
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdateSync" },                                                       --执行此命令后，加载插件

    keys =                                                                          --按下这些键后，加载插件
    {
        { "<c-space>", desc = "Increment selection" },                              --Ctrl + Space, 设置或取消标记
        { "<bs>",      mode = "x",                  desc = "Decrement selection" }, --backspace
    },

    opts =
    {
        ensure_installed = --表中列出的解析器应当总是已安装；可以填all
        {
            "c",
            "cpp",
            "cmake",
            --"cuda",
            --"proto",

            "python",

            "lua",
            "luadoc",
            "luap",

            "bash",

            "vim",
            "vimdoc",

            "query",

            "markdown",
            "markdown_inline",

            "html",
            "css",
            "javascript",
            "typescript",
            "tsx",
            "json",

            "yaml",
        },

        sync_install = false,    -- 同步安装解析器，仅对ensure_installed选项有效

        auto_install = true,     --在进入缓冲区时，自动安装缺失的解析器;如果没有在本地安装tree-sitter命令行界面，建议设置为false

        ignore_install = { "" }, --列出忽略安装的解析器 (for "all")

        highlight =
        {
            enable = true,
            disable = {},                              --禁用语法高亮的语言对应的解析器，其值可以是一个回调函数function(lang, buf)
            additional_vim_regex_highlighting = false, --同时启用vim的语法高亮(:h syntax)，可能会影响性能并得到重复的高亮。
        },

        incremental_selection = -- 启用增量选择
        {
            enable = true,
            keymaps =
            {
                init_selection = '<C-space>', -- set to `false` to disable one of the mappings
                node_incremental = '<C-space>',
                scope_incremental = '<tab>',
                node_decremental = '<bs>',
            }
        },

        indent = -- 启用基于Treesitter的代码格式化(=) . NOTE: This is an experimental feature.
        {
            enable = true,
            disable = {},
        },
    },

    config = function(plugin, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}

-- set foldmethod=expr
-- set foldexpr=nvim_treesitter#foldexpr()
-- set nofoldenable                     " Disable folding at startup.