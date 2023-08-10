--补全引擎。补全源需要从外部仓库安装
--see :help cmp

--nvim本身提供了较完备但不太好用的补全功能，见 :help ins-completion
--因此需要安装这个插件

return
{
    "hrsh7th/nvim-cmp", --https://github.com/hrsh7th/nvim-cmp

    version = false,

	lazy = true,
    event = "InsertEnter",

    dependencies = --补全源
    {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lua", --nvim lua API补全
        "f3fora/cmp-spell",     --在拼写检查模式下提供补全
        "hrsh7th/cmp-calc",     --数学表达式补全

		{
			"saadparwaiz1/cmp_luasnip", --将luasnip作为补全源

			dependencies =
			{
				"L3MON4D3/LuaSnip", --snippets补全引擎
				dependencies =
				{
					{ "rafamadriz/friendly-snippets" }, --补全源, 一个预设的VS Code风格的snippets
				},

				opts =
				{
    				history = true,
    				delete_check_events = "TextChanged",
  				},

				keys =
				{
					{
						"<tab>",
						function()
							return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
						end,
						expr = true, silent = true, mode = "i",
					},
					{ "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
					{ "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
  				},

				config = function()
					local luasnip_loader = require("luasnip.loaders.from_vscode")
					luasnip_loader.lazy_load() --加快启动速度
					luasnip_loader.lazy_load({ paths = { "~/.config/nvim/snippets/" } }) --加载自定义snippets

					local luasnip = require("luasnip")
					luasnip.config.setup(
						{
							region_check_events = "CursorHold,InsertLeave,InsertEnter", --跳转到snippets结尾的事件
							delete_check_events = "TextChanged,InsertEnter", --清除snippets的事件
						}
					)
				end,
        	},
		}
    },

    opts = function()
        vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        local char_exists = function() --检查光标前是否存在非空白字符
            local line_and_col = vim.api.nvim_win_get_cursor(0)
            local line = line_and_col[1]
            local col = line_and_col[2]
            return col ~= 0 and --列不为0
                vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") ==
                nil    --取当前光标位置所在行的文本内容，然后使用  sub  函数提取指定列位置的字符
        end

        return
        {
            preselect = cmp.PreselectMode.None,

            snippet = --指定snippet引擎
            {
                expand = function(args)
                    luasnip.lsp_expand(args.body) --使用luasnip
                end,
            },

            window =
            {
                completion =
                {
					border = "rounded",
					winhighlight = "Normal:CmpPmenu,FloatBorder:FloatBorder,CursorLine:Visual,Search:PmenuSel",
				},
                documentation =
				{
					border = "rounded",                                                                   --圆边框，single为方边框
					winhighlight = "Normal:CmpDoc", --高亮样式
        		},
            },

            completion =
            {
                completeopt = "menu,menuone",
            },

            -- see Wiki: example mappings
            mapping = cmp.mapping.preset.insert(
                {
                    --cmp.SelectBehavior.Select 选择补全项
                    --cmp.SelectBehavior.Insert 选择补全项并插入
                    --cmp.SelectBehavior.Replace 选择补全项，并用补全项替换原有的文本

                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-u>"] = cmp.mapping.scroll_docs(4),

                    ["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert, }),

                    ["<C-Space>"] = cmp.mapping.complete(), --弹出补全框
                    ["<C-e>"] = cmp.mapping.close(),    --关闭补全框

                    ["<tab>"] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        elseif char_exists() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                          cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                          luasnip.jump(-1)
                        elseif char_exists() then
                            cmp.complete()
                        else
                          fallback()
                        end
                      end, { 'i', 's' }),
                }
            ),

            sources = cmp.config.sources(
                {
                    { name = "nvim_lsp", },
                    { name = "luasnip", },
                    {
                        name = "buffer",
                        option =
                        {
                            get_bufnrs = function()
                                return vim.api.nvim_list_bufs() --获取打开的所有缓冲区ID表
                            end
                        }
                    },
                    { name = "treesitter",  },
                    { name = "path",        },
                    { name = "calc",        },
                    { name = "nvim_lua",    },
                    { name = "spell", 		},
                }
            ),

            formatting =
            {
                fields = { "abbr", "kind", "menu" },

                format = function(entry, item)
					local kind_icons = {}
                    local source_icons = {}

					item.kind = string.format("%s %s", " " .. kind_icons[item.kind] .. " ", item.kind)
                    item.menu = source_icons[entry.source.name] .. " " .. entry.source.name
                    return item
                end,
            },

            experimental =
            {
                ghost_text = --假如你输入了#inc，补全项是#include, 则在你输入的#inc后面，用阴影显示lude
                {
                    hl_group = "CmpGhostText",
                },
            },
        }
    end,

    config = function(plugin, opts)
        local cmp = require("cmp")
        cmp.setup(opts)

        --配置特定类型的文件
        cmp.setup.filetype("gitcommit",
            {
                sources = cmp.config.sources(
                    {
                        { name = "cmp_git" },
                    },
                    {
                        { name = "buffer" },
                    }
                ),
            }
        )

        -- 该功能与flash.lua冲突
        cmp.setup.cmdline(
            { "/", "?" },
            {
                mapping = cmp.mapping.preset.cmdline(),
                sources =
                {
                    { name = "buffer" },
                },
            }
        )

        -- 该功能与noice.lua冲突
        cmp.setup.cmdline(":",
            {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources(
                    { --分组
                        { name = "path" },
                    },
                    {
                        { name = "cmdline" },
                    }
                ),
            }
        )
    end,
}
