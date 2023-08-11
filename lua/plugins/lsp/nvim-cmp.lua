--补全引擎。补全源需要从外部仓库安装
--see :help cmp

-- nvim本身提供了较完备但不太好用的补全功能，因此需要安装这个插件。见 :help ins-completion
-- 可以通过vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"设置当前缓冲区（buffer）的自动补全函数（omnifunc）为LSP的自动补全函数
-- "omni" 是 "omniscient" 的缩写，意思是 无所不知的; 按下 <c-x> <c-o> 后, 弹出补全菜单。这个补全功能很弱，基本不会使用

return
{
    "hrsh7th/nvim-cmp", --https://github.com/hrsh7th/nvim-cmp

    version = false,

	lazy = true,
    event = "InsertEnter",

    dependencies = --补全源
    {
        {"hrsh7th/cmp-nvim-lsp"},
        {"hrsh7th/cmp-buffer"},
        {"hrsh7th/cmp-path"},
        {"hrsh7th/cmp-cmdline"},
        {"hrsh7th/cmp-nvim-lua"}, --nvim lua API补全
        {"f3fora/cmp-spell"},     --在拼写检查模式下提供补全
        {"hrsh7th/cmp-calc"},     --数学表达式补全
        { "lukas-reineke/cmp-under-comparator" },
		{ "ray-x/cmp-treesitter" },
		{
			"saadparwaiz1/cmp_luasnip", --将luasnip作为补全源

			dependencies =
			{
				"L3MON4D3/LuaSnip", --snippets补全引擎
				dependencies =
				{
					{ "rafamadriz/friendly-snippets" }, --补全源, 一个预设的VS Code风格的snippets
				},

				config = function()
					local luasnip = require("luasnip")
					luasnip.setup(
                    {
						history = true,
						update_events = "TextChanged,TextChangedI",
						delete_check_events = "TextChanged,InsertLeave",
					}
                    )

					local luasnip_loader = require("luasnip.loaders.from_vscode")
					luasnip_loader.lazy_load()
					luasnip_loader.lazy_load({ paths = { "~/.config/nvim/snippets/" } }) --加载自定义snippets
				end,
        	},
		}
    },

    opts = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        return
        {
            preselect = cmp.PreselectMode.Item,

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
					winhighlight = "Normal:CmpPmenu,CursorLine:PmenuSel,Search:PmenuSel",
				},
                documentation =
				{
					border = "rounded", --圆边框，single为方边框
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
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),

                    ["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace, }),

                    ["<C-Space>"] = cmp.mapping.complete(), --弹出补全框
                    ["<C-w>"] = cmp.mapping.close(),    --关闭补全框

                    ["<tab>"] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_locally_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                          cmp.select_prev_item()
                        elseif luasnip.locally_jumpable(-1) then
                          luasnip.jump(-1)
                        else
                          fallback()
                        end
                      end, { 'i', 's' }),
                }
            ),

            sorting =
			{
				priority_weight = 2,
                comparators =
				{
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					require("cmp-under-comparator").under,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
        		},
            },

            sources = cmp.config.sources(
                {
                    { name = "nvim_lsp" },
					{ name = "nvim_lua",    },
                    { name = "luasnip", },
                    { name = "treesitter",  },
                    { name = "path" },
					{ name = "spell" },
                    { name = "calc", },
					{
                        name = "buffer",
                        option =
                        {
                            get_bufnrs = function()
                                return vim.api.nvim_list_bufs() --获取打开的所有缓冲区ID表
                            end
                        }
                    },
					-- { name = "codeium" },
                }
            ),

            formatting =
            {
                fields = { "abbr", "kind", "menu" },

                format = function(entry, item)
					local kind_icons = require("plugins.util.icons").kind
                    local source_icons = require("plugins.util.icons").cmp_source
					local undef_icons = require("plugins.util.icons").undefined

					item.kind = string.format("%s %s", (kind_icons[item.kind] or undef_icons), item.kind)
                    item.menu = string.format(" %s %s", (source_icons[entry.source.name] or undef_icons), entry.source.name)

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

            matching =
			{
				disallow_partial_fuzzy_matching = false,
			},
            performance =
			{
				async_budget = 1,
				max_view_entries = 120,
			},
        }
    end,

    config = function(plugin, opts)
        local cmp = require("cmp")
        cmp.setup(opts)

        vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

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
