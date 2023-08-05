return
{
    {
        "catppuccin/nvim",

        lazy = false,
        priority = 1000,

        name = "catppuccin",

		--下面的配置一些是默认的，一些是自定义的，为了方便修改，将插件默认配置也写出了。
        opts =
        {
            flavour = "latte", -- latte, frappe, macchiato, mocha
            background =       -- :h background
            {
                light = "latte",
                dark = "macchiato",
            },
            transparent_background = false, -- disables setting the background color.
            show_end_of_buffer = false,     -- shows the '~' characters after the end of buffers
            term_colors = true,             -- sets terminal colors (e.g. `g:terminal_color_0`)
            dim_inactive = -- dims the background color of inactive window
            {
                enabled = true,
                shade = "dark",
                percentage = 0.15, -- percentage of the shade to apply to the inactive window
            },

            no_italic = false,    -- Force no italic
            no_bold = false,      -- Force no bold
            no_underline = false, -- Force no underline

			-- Handles the styles of general hi groups (see `:h highlight-args`):
            styles =
            {
                comments = { "italic" }, -- Change the style of comments
                conditionals = { "italic" },
                loops = { "bold"},
                functions = {"italic", "bold"},
                keywords = {"italic"},

                strings = {},
                variables = {},
                numbers = {},
                booleans = {"bold", "italic"},
                properties = {"italic"},
                types = {},
                operators = {"bold"},
            },

            color_overrides =
			{
				mocha =
				{
					rosewater = "#F5E0DC",
					flamingo = "#F2CDCD",
					mauve = "#DDB6F2",
					pink = "#F5C2E7",
					red = "#F28FAD",
					maroon = "#E8A2AF",
					peach = "#F8BD96",
					yellow = "#FAE3B0",
					green = "#ABE9B3",
					blue = "#96CDFB",
					sky = "#89DCEB",
					teal = "#B5E8E0",
					lavender = "#C9CBFF",

					text = "#D9E0EE",
					subtext1 = "#BAC2DE",
					subtext0 = "#A6ADC8",
					overlay2 = "#C3BAC6",
					overlay1 = "#988BA2",
					overlay0 = "#6E6C7E",
					surface2 = "#6E6C7E",
					surface1 = "#575268",
					surface0 = "#302D41",

					base = "#1E1E2E",
					mantle = "#1A1826",
					crust = "#161320",
				},
			},

			-- 设置所有风格（亮色，暗色）的高亮组
            custom_highlights = {},

			highlight_overrides =
			{
				mocha = function(cp)
					return
					{
						-- For base configs.
						CursorLineNr = { fg = cp.green },
						Search = { bg = cp.surface1, fg = cp.pink, style = { "bold" } },
						IncSearch = { bg = cp.pink, fg = cp.surface1 },

						-- For native lsp configs.
						DiagnosticVirtualTextError = { bg = cp.none },
						DiagnosticVirtualTextWarn = { bg = cp.none },
						DiagnosticVirtualTextInfo = { bg = cp.none },
						DiagnosticVirtualTextHint = { fg = cp.rosewater, bg = cp.none },

						DiagnosticHint = { fg = cp.rosewater },
						LspDiagnosticsDefaultHint = { fg = cp.rosewater },
						LspDiagnosticsHint = { fg = cp.rosewater },
						LspDiagnosticsVirtualTextHint = { fg = cp.rosewater },
						LspDiagnosticsUnderlineHint = { sp = cp.rosewater },

						-- For fidget.
						FidgetTask = { bg = cp.none, fg = cp.surface2 },
						FidgetTitle = { fg = cp.blue, style = { "bold" } },

						-- For treesitter.
						["@field"] = { fg = cp.rosewater },
						["@property"] = { fg = cp.yellow },

						["@include"] = { fg = cp.teal },
						["@operator"] = { fg = cp.sky },
						["@keyword.operator"] = { fg = cp.sky },
						["@punctuation.special"] = { fg = cp.maroon },

						-- ["@float"] = { fg = cp.peach },
						-- ["@number"] = { fg = cp.peach },
						-- ["@boolean"] = { fg = cp.peach },

						["@constructor"] = { fg = cp.lavender },
						-- ["@constant"] = { fg = cp.peach },
						-- ["@conditional"] = { fg = cp.mauve },
						-- ["@repeat"] = { fg = cp.mauve },
						["@exception"] = { fg = cp.peach },

						["@constant.builtin"] = { fg = cp.lavender },
						-- ["@function.builtin"] = { fg = cp.peach, style = { "italic" } },
						-- ["@type.builtin"] = { fg = cp.yellow, style = { "italic" } },
						["@variable.builtin"] = { fg = cp.red, style = { "italic" } },

						-- ["@function"] = { fg = cp.blue },
						["@function.macro"] = { fg = cp.red, style = {} },
						["@parameter"] = { fg = cp.rosewater },
						["@keyword.function"] = { fg = cp.maroon },
						["@keyword"] = { fg = cp.red },
						["@keyword.return"] = { fg = cp.pink, style = {} },

						-- ["@text.note"] = { fg = cp.base, bg = cp.blue },
						-- ["@text.warning"] = { fg = cp.base, bg = cp.yellow },
						-- ["@text.danger"] = { fg = cp.base, bg = cp.red },
						-- ["@constant.macro"] = { fg = cp.mauve },

						-- ["@label"] = { fg = cp.blue },
						["@method"] = { style = { "italic" } },
						["@namespace"] = { fg = cp.rosewater, style = {} },

						["@punctuation.delimiter"] = { fg = cp.teal },
						["@punctuation.bracket"] = { fg = cp.overlay2 },
						-- ["@string"] = { fg = cp.green },
						-- ["@string.regex"] = { fg = cp.peach },
						-- ["@type"] = { fg = cp.yellow },
						["@variable"] = { fg = cp.text },
						["@tag.attribute"] = { fg = cp.mauve, style = { "italic" } },
						["@tag"] = { fg = cp.peach },
						["@tag.delimiter"] = { fg = cp.maroon },
						["@text"] = { fg = cp.text },

						-- ["@text.uri"] = { fg = cp.rosewater, style = { "italic", "underline" } },
						-- ["@text.literal"] = { fg = cp.teal, style = { "italic" } },
						-- ["@text.reference"] = { fg = cp.lavender, style = { "bold" } },
						-- ["@text.title"] = { fg = cp.blue, style = { "bold" } },
						-- ["@text.emphasis"] = { fg = cp.maroon, style = { "italic" } },
						-- ["@text.strong"] = { fg = cp.maroon, style = { "bold" } },
						-- ["@string.escape"] = { fg = cp.pink },

						-- ["@property.toml"] = { fg = cp.blue },
						-- ["@field.yaml"] = { fg = cp.blue },

						-- ["@label.json"] = { fg = cp.blue },

						["@function.builtin.bash"] = { fg = cp.red, style = { "italic" } },
						["@parameter.bash"] = { fg = cp.yellow, style = { "italic" } },

						["@field.lua"] = { fg = cp.lavender },
						["@constructor.lua"] = { fg = cp.flamingo },

						["@constant.java"] = { fg = cp.teal },

						["@property.typescript"] = { fg = cp.lavender, style = { "italic" } },
						-- ["@constructor.typescript"] = { fg = cp.lavender },

						-- ["@constructor.tsx"] = { fg = cp.lavender },
						-- ["@tag.attribute.tsx"] = { fg = cp.mauve },

						["@type.css"] = { fg = cp.lavender },
						["@property.css"] = { fg = cp.yellow, style = { "italic" } },

						["@property.cpp"] = { fg = cp.text },

						-- ["@symbol"] = { fg = cp.flamingo },
					}
				end,
			},

            integrations =
            {
                aerial = true,
				alpha = true,
				barbecue = false,
				dashboard = false,
				flash = true,
                gitsigns = true,
                indent_blankline =
				{
					enabled = true,
					colored_indent_levels = true,
				},
				mason = true,
				mini = true,
				neotree = true,
                mini = true,
				noice = true,
				cmp = true, -- nvim-cmp
				dap =
				{
					enabled = true, -- enable nvim-dap
					enable_ui = true, -- enable nvim-dap-ui
				},
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
                        hints = { "underline" },
                        warnings = { "underline" },
                        information = { "underline" },
                    },
                    inlay_hints =
                    {
                        background = true,
                    },
                },
                notify = true, -- nvim-notify
                nvimtree = false, -- nvim-tree.lua
				treesitter = true,
				overseer = true,
                telescope =
				{
					enabled = true,
					-- style = "nvchad"
				},
				illuminate = true,
                which_key = true,
            },

			--Catppuccin can pre compute the results of your configuration and store the results in a compiled lua file.
			--By default catppuccin writes the compiled results into the system's cache directory.
			--You can change the cache dir using:
			compile_path = vim.fn.stdpath "cache" .. "/catppuccin",
        },

        config = function(plugin, opts)
            require("catppuccin").setup(opts)
            vim.cmd.colorscheme("catppuccin")
        end,
    },

    {
        "folke/tokyonight.nvim",

        lazy = false,
        priority = 1000,

        opts =
        {
             -- your configuration comes here
            -- or leave it empty to use the default settings
            style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
            light_style = "day", -- The theme is used when the background is set to light
            transparent = false, -- Enable this to disable setting the background color
            terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
            styles = {
                -- Style to be applied to different syntax groups
                -- Value is any valid attr-list value for `:help nvim_set_hl`
                comments = { italic = true },
                keywords = { italic = true },
                functions = {},
                variables = {},
                -- Background styles. Can be "dark", "transparent" or "normal"
                sidebars = "dark", -- style for sidebars, see below
                floats = "dark", -- style for floating windows
            },
            sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
            day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
            hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
            dim_inactive = false, -- dims inactive windows
            lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

            --- You can override specific color groups to use other groups or a hex color
            --- function will be called with a ColorScheme table
            ---@param colors ColorScheme
            on_colors = function(colors) end,

            --- You can override specific highlights to use other groups or a hex color
            --- function will be called with a Highlights and ColorScheme table
            ---@param highlights Highlights
            ---@param colors ColorScheme
            on_highlights = function(highlights, colors) end,
        },

        config = function(plugin, opts)
            require("tokyonight").setup(opts)
            --vim.cmd("colorscheme tokyonight")
        end
    }
}
