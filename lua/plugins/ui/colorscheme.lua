return
{
    {
        "catppuccin/nvim",
        priority = 1000,

        name = "catppuccin",

        opts =
        {
            flavour = "latte", -- latte, frappe, macchiato, mocha
            background =       -- :h background
            {
                light = "latte",
                dark = "frappe",
            },
            transparent_background = false, -- disables setting the background color.
            show_end_of_buffer = false,     -- shows the '~' characters after the end of buffers
            term_colors = true,             -- sets terminal colors (e.g. `g:terminal_color_0`)
            dim_inactive =
            {
                enabled = false,   -- dims the background color of inactive window
                shade = "dark",
                percentage = 0.15, -- percentage of the shade to apply to the inactive window
            },

            no_italic = false,    -- Force no italic
            no_bold = false,      -- Force no bold
            no_underline = false, -- Force no underline

            styles =
            {                            -- Handles the styles of general hi groups (see `:h highlight-args`):
                comments = { "italic" }, -- Change the style of comments
                conditionals = { "italic" },
                loops = {},
                functions = {},
                keywords = {},

                strings = {},
                variables = {},
                numbers = {},
                booleans = {},
                properties = {},
                types = {},
                operators = {},
            },

            color_overrides = {},
            custom_highlights = {},

            integrations =
            {
                alpha = true,
                cmp = true,
                gitsigns = true,
                illuminate = true,
                indent_blankline = { enabled = true },
                lsp_trouble = true,
                mini = true,
                native_lsp =
                {
                    enabled = true,
                    virtual_text =
                    {
                        errors = { "italic" },
                        hints = { "italic" },
                        warnings = { "italic" },
                        information = { "italic" },
                    },
                    underlines =
                    {
                        errors = { "underline" },
                        hints = { "undercurl" },
                        warnings = { "undercurl" },
                        information = { "undercurl" },
                    },
                    inlay_hints =
                    {
                        background = true,
                    },
                },
                navic = { enabled = true },
                neotest = true,
                noice = true,
                notify = true,
                nvimtree = true,
                semantic_tokens = true,
                telescope = true,
                treesitter = true,
                which_key = true,
            },
        },

        config = function(plugin, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin")
            print("123")
        end,
    },
}
