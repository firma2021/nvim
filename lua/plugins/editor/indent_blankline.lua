--显示缩进线
return
{
    "lukas-reineke/indent-blankline.nvim",

    event = { "BufReadPost", "BufNewFile" },

    opts =
    {
        -- char = "▏",
        char = "│",
        filetype_exclude =
        {
            "null-ls-info",
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "Trouble",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "lazyterm",
            "terminal",
            "lspinfo",
            "toggleterm",
            "TelescopePrompt",
            "log",
            "markdown",
        },

        show_trailing_blankline_indent = false,
        show_current_context = true,
        show_current_context_start = true,
        context_patterns =
        {
            'class',
            'function',
            'method',
            'element',
            '^if',
            '^while',
            '^for',
            '^object',
            '^table',
            'block',
            'arguments',
        },
    },
}
