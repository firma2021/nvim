--提供一些基于tree-sitter的基本功能, 如语法高亮
--see :help nvim-treesitter
--use plugin: nvim-treesitter/playground to show concrete syntax tree

return
{
    "nvim-treesitter/nvim-treesitter",

    version = false,

    build = ":TSUpdate", --当插件被安装或更新后，执行此命令，将所有安装好的解析器更新到最近的版本

    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },

    event = { "BufReadPost", "BufNewFile" },

    cmd = { "TSUpdateSync" }, --执行此命令后，加载插件

    --按下这些键后，加载插件
    keys = {
        { "<c-space>", desc = "Increment selection" },  --Ctrl + Space, 设置或取消标记
        { "<bs>",      mode = "x",                  desc = "Decrement selection" }, --backspace
    },

    main = "nvim-treesitter.configs",

    opts =
	{
        --表中列出的解析器应当总是已安装；可以填all
        ensure_installed =
		{
            "c",
            "cpp",
            "make",
            "cmake",
            --"cuda",
            --"proto",

            "python",

            "lua",
            "luadoc", --用于生成Lua代码文档的工具
            "luap", --在Lua中进行模式匹配的库

            "bash",

            "vim",
            "vimdoc",

            "sql",
            "query",

            "regex",

            "markdown",
            "markdown_inline",

            "html",
            "css",
            "javascript",
            "typescript",
            "tsx",
            "json",

            "toml", --一种配置文件格式
            "yaml",

            "gitignore",

            --"rust",
            --"go",
        },

        sync_install = false, -- 同步安装解析器，仅对ensure_installed选项有效

        auto_install = true, --在进入缓冲区时，自动安装缺失的解析器; 如果没有在本地安装tree-sitter命令行界面，建议设置为false

        ignore_install = { "" }, --列出忽略安装的解析器 (for "all")

        highlight = {
            enable = true,
            disable = function(lang, buf) --禁用语法高亮的语言对应的解析器，其值可以是一个回调函数function
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
            additional_vim_regex_highlighting = false, --同时启用vim的语法高亮(:h syntax)，可能会影响性能并得到重复的高亮。
        },

        -- 启用增量选择
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<c-space>",
                node_incremental = "<c-space>",
                node_decremental = "<M-space>", --M为Meta键，即 "Alt" 键或 "Option" 键
                scope_incremental = "<c-s>",
            },
        },

        -- 启用基于Treesitter的代码格式化(=) . NOTE: This is an experimental feature.
        indent = {
            enable = true,
            disable = {},
        },

        textobjects = {
            select = {
                enable = true,
                lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["aa"] = "@parameter.outer",
                    ["ia"] = "@parameter.inner",
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                },
                include_surrounding_whitespace = false,
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    ["]m"] = "@function.outer",
                    ["]]"] = "@class.outer",
                },
                goto_next_end = {
                    ["]M"] = "@function.outer",
                    ["]["] = "@class.outer",
                },
                goto_previous_start = {
                    ["[m"] = "@function.outer",
                    ["[["] = "@class.outer",
                },
                goto_previous_end = {
                    ["[M"] = "@function.outer",
                    ["[]"] = "@class.outer",
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<leader>a"] = "@parameter.inner",
                },
                swap_previous = {
                    ["<leader>A"] = "@parameter.inner",
                },
            },
        },
    },
}
