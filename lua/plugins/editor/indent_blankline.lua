--显示缩进线,即使在空行上也可以显示
--see :help indent_blankline.txt
return
{
    "lukas-reineke/indent-blankline.nvim",

    event = { "BufReadPost", "BufNewFile" },

    opts =
    {
        char = "┊",
        filetype_exclude =
        {
            "null-ls-info",
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
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
