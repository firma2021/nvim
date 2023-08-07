return
{
	{
		"catppuccin/nvim",

		lazy = false,
		priority = 1000,

		name = "catppuccin", --插件的自定义名称，用于本地插件目录和显示的名称

		--下面的配置一些是默认的，一些是自定义的，为了方便修改，将插件默认配置也写出了
		opts =
		{
			flavour = "latte", -- latte, frappe, macchiato, mocha
			background = -- :h background
			{
				light = "latte",
				dark = "mocha",
			},
			transparent_background = false, -- disables setting the background color.
			show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
			term_colors = true,    -- sets terminal colors (e.g. `g:terminal_color_0`)
			dim_inactive =         -- dims the background color of inactive window
			{
				enabled = true,
				shade = "dark",
				percentage = 0.15, -- percentage of the shade to apply to the inactive window
			},

			no_italic = false, -- Force no italic
			no_bold = false, -- Force no bold
			no_underline = false, -- Force no underline

			-- Handles the styles of general hi groups (see `:h highlight-args`):
			styles =
			{
				comments = { "italic" },
				conditionals = { "bold" }, -- "italic"
				loops = { "bold" },
				functions = { "bold" }, -- "italic", "bold"
				operators = { "bold" },
				keywords = { "italic" },
				booleans = { "bold", "italic" },

				properties = { "italic" },

				variables = {},
				numbers = {},
				strings = {},
				types = {},
			},

			color_overrides =
			{
				--比原主题的文字颜色更淡，比frappe的背景颜色更深
				frappe =
				{
					rosewater = "#F5E0DC", --玫瑰香水
					flamingo = "#F2CDCD", --火烈鸟
					mauve = "#DDB6F2", --淡紫色
					pink = "#F5C2E7",
					red = "#F28FAD",
					maroon = "#E8A2AF", --栗子色
					peach = "#F8BD96", --桃红色
					yellow = "#FAE3B0",
					green = "#ABE9B3",
					blue = "#96CDFB",
					sky = "#89DCEB",
					teal = "#B5E8E0",
					lavender = "#C9CBFF", --淡紫色，薰衣草色

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
					mantle = "#1A1826", --斗篷，罩子，覆盖物
					crust = "#161320", --外壳，硬皮
				},
			},

			-- 设置所有风格的高亮组
			custom_highlights = function(cp)
				return
				{
					-- 设置LSP诊断信息的虚拟文本提示的背景
					DiagnosticVirtualTextError = { fg = cp.red, bg = cp.none },
					DiagnosticVirtualTextWarn = { fg = cp.pink, bg = cp.none },
					DiagnosticVirtualTextInfo = { fg = cp.blue, bg = cp.none },
					DiagnosticVirtualTextHint = { fg = cp.sky, bg = cp.none },

					LspInfoBorder = { fg = cp.mauve, bg = cp.mantle },

					-- mason面板的文字颜色和界面背景
					MasonNormal = { fg = cp.mauve, bg = cp.mantle },

					-- 弹出式菜单的样式
					Pmenu = { fg = cp.pink, bg = cp.base },
					PmenuBorder = { fg = cp.red, bg = cp.base },
					PmenuSel = { bg = cp.red, fg = cp.base },

					-- nvim-cmp 补全菜单的样式
					CmpItemAbbr = { fg = cp.pink },          --补全项的文字颜色
					CmpItemAbbrMatch = { fg = cp.red, style = { "bold" } }, --补全项中与输入文本匹配的文字颜色
					CmpDoc = { fg = cp.red },
					CmpDocBorder = { fg = cp.red, bg = cp.pink },

					-- Telescope插件
					TelescopeMatching = { fg = cp.red },
					TelescopeResultsDiffAdd = { fg = cp.green },
					TelescopeResultsDiffChange = { fg = cp.yellow },
					TelescopeResultsDiffDelete = { fg = cp.sky },

					-- 设置treesitter语法结构的颜色，如return关键字用红色的粗体显示
					["@keyword.return"] = { fg = cp.red, style = { "bold" } },
					["@error.c"] = { fg = cp.none, style = {} },
					["@error.cpp"] = { fg = cp.none, style = {} },
				}
			end,


			-- 单独设置每个风格的高亮组
			-- highlight_overrides =
			-- {
			--mocha = function(cp)
			-- 	return
			-- 	{
			-- 		-- For base configs.
			-- 		CursorLineNr = { fg = cp.green },
			-- 		Search = { bg = cp.surface1, fg = cp.pink, style = { "bold" } },
			-- 		IncSearch = { bg = cp.pink, fg = cp.surface1 },

			-- For native lsp configs.

			-- 		-- For fidget.
			-- 		FidgetTask = { bg = cp.none, fg = cp.surface2 },
			-- 		FidgetTitle = { fg = cp.blue, style = { "bold" } },

			-- 		-- For treesitter.
			-- 		["@field"] = { fg = cp.rosewater },
			-- 		["@property"] = { fg = cp.yellow },

			-- 		["@include"] = { fg = cp.teal },
			-- 		["@operator"] = { fg = cp.sky },
			-- 		["@keyword.operator"] = { fg = cp.sky },
			-- 		["@punctuation.special"] = { fg = cp.maroon },

			-- 		-- ["@float"] = { fg = cp.peach },
			-- 		-- ["@number"] = { fg = cp.peach },
			-- 		-- ["@boolean"] = { fg = cp.peach },

			-- 		["@constructor"] = { fg = cp.lavender },
			-- 		-- ["@constant"] = { fg = cp.peach },
			-- 		-- ["@conditional"] = { fg = cp.mauve },
			-- 		-- ["@repeat"] = { fg = cp.mauve },
			-- 		["@exception"] = { fg = cp.peach },

			-- 		["@constant.builtin"] = { fg = cp.lavender },
			-- 		-- ["@function.builtin"] = { fg = cp.peach, style = { "italic" } },
			-- 		-- ["@type.builtin"] = { fg = cp.yellow, style = { "italic" } },
			-- 		["@variable.builtin"] = { fg = cp.red, style = { "italic" } },

			-- 		-- ["@function"] = { fg = cp.blue },
			-- 		["@function.macro"] = { fg = cp.red, style = {} },
			-- 		["@parameter"] = { fg = cp.rosewater },
			-- 		["@keyword.function"] = { fg = cp.maroon },
			-- 		["@keyword"] = { fg = cp.red },
			-- 		["@keyword.return"] = { fg = cp.pink, style = {} },

			-- 		-- ["@text.note"] = { fg = cp.base, bg = cp.blue },
			-- 		-- ["@text.warning"] = { fg = cp.base, bg = cp.yellow },
			-- 		-- ["@text.danger"] = { fg = cp.base, bg = cp.red },
			-- 		-- ["@constant.macro"] = { fg = cp.mauve },

			-- 		-- ["@label"] = { fg = cp.blue },
			-- 		["@method"] = { style = { "italic" } },
			-- 		["@namespace"] = { fg = cp.rosewater, style = {} },

			-- 		["@punctuation.delimiter"] = { fg = cp.teal },
			-- 		["@punctuation.bracket"] = { fg = cp.overlay2 },
			-- 		-- ["@string"] = { fg = cp.green },
			-- 		-- ["@string.regex"] = { fg = cp.peach },
			-- 		-- ["@type"] = { fg = cp.yellow },
			-- 		["@variable"] = { fg = cp.text },
			-- 		["@tag.attribute"] = { fg = cp.mauve, style = { "italic" } },
			-- 		["@tag"] = { fg = cp.peach },
			-- 		["@tag.delimiter"] = { fg = cp.maroon },
			-- 		["@text"] = { fg = cp.text },

			-- 		-- ["@text.uri"] = { fg = cp.rosewater, style = { "italic", "underline" } },
			-- 		-- ["@text.literal"] = { fg = cp.teal, style = { "italic" } },
			-- 		-- ["@text.reference"] = { fg = cp.lavender, style = { "bold" } },
			-- 		-- ["@text.title"] = { fg = cp.blue, style = { "bold" } },
			-- 		-- ["@text.emphasis"] = { fg = cp.maroon, style = { "italic" } },
			-- 		-- ["@text.strong"] = { fg = cp.maroon, style = { "bold" } },
			-- 		-- ["@string.escape"] = { fg = cp.pink },

			-- 		-- ["@property.toml"] = { fg = cp.blue },
			-- 		-- ["@field.yaml"] = { fg = cp.blue },

			-- 		-- ["@label.json"] = { fg = cp.blue },

			-- 		["@function.builtin.bash"] = { fg = cp.red, style = { "italic" } },
			-- 		["@parameter.bash"] = { fg = cp.yellow, style = { "italic" } },

			-- 		["@field.lua"] = { fg = cp.lavender },
			-- 		["@constructor.lua"] = { fg = cp.flamingo },

			-- 		["@constant.java"] = { fg = cp.teal },

			-- 		["@property.typescript"] = { fg = cp.lavender, style = { "italic" } },
			-- 		-- ["@constructor.typescript"] = { fg = cp.lavender },

			-- 		-- ["@constructor.tsx"] = { fg = cp.lavender },
			-- 		-- ["@tag.attribute.tsx"] = { fg = cp.mauve },

			-- 		["@type.css"] = { fg = cp.lavender },
			-- 		["@property.css"] = { fg = cp.yellow, style = { "italic" } },

			-- 		["@property.cpp"] = { fg = cp.text },

			-- 		-- ["@symbol"] = { fg = cp.flamingo },
			-- 	}
			-- end,
			-- },

			integrations =
			{
				aerial = true,
				alpha = true,
				barbecue = false,
				dashboard = false,
				flash = true,
				gitsigns = true,
				indent_blankline = { enabled = true, colored_indent_levels = true, },
				markdown = true,
				mason = true,
				neotree = { enabled = true, show_root = true, transparent_panel = true },
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
				treesitter_context = true,
				overseer = true,
				telescope =
				{
					enabled = true,
					--style = "nvchad" 无边框，不好看
				},
				illuminate = true,
				which_key = true,


			},

			--Catppuccin can pre compute the results of your configuration and store the results in a compiled lua file.
			--By default catppuccin writes the compiled results into the system's cache directory.
			--You can change the cache dir using:
			compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
		},

		config = function(plugin, opts)
			require("catppuccin").setup(opts)
			vim.cmd.colorscheme("catppuccin")
		end,
	},
}
