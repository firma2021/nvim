--补全引擎插件。补全源需要从外部仓库安装。
return
{
    "hrsh7th/nvim-cmp", --https://github.com/hrsh7th/nvim-cmp

    version = false,

    event = "InsertEnter",

    dependencies = --补全源
    {
        "hrsh7th/cmp-nvim-lsp",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lua", --nvim lua API补全
        "f3fora/cmp-spell",     --在拼写检查模式下提供补全
        "hrsh7th/cmp-calc",     --数学表达式补全
        {
            "L3MON4D3/LuaSnip",
            config = function()
                local luasnip_loader = require("luasnip.loaders.from_vscode")
                luasnip_loader.lazy_load()
                luasnip_loader.lazy_load({ paths = { "~/.config/nvim/snippets/" } })
                --require("luasnip.loaders.from_vscode").lazy_load({paths = {"~/.config/nvim/snippets/"}})

                --local keymap = vim.api.nvim_set_keymap
                --local opts = { noremap = true, silent = true }
                --keymap("i", "<c-n>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
                --keymap("s", "<c-n>", "<cmd>lua require'luasnip'.jump(1)<CR>", opts)
                --keymap("i", "<c-e>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)
                --keymap("s", "<c-e>", "<cmd>lua require'luasnip'.jump(-1)<CR>", opts)

                local luasnip = require("luasnip")
                luasnip.config.setup(
                    {
                        region_check_events = "CursorHold,InsertLeave,InsertEnter",
                        delete_check_events = "TextChanged,InsertEnter",
                    }
                )
            end,
            dependencies =
            {
                { "rafamadriz/friendly-snippets" },
            },
        },
    },

    opts = function()
        vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
        local cmp = require("cmp")

        local border_opts =
        {
            border = "rounded",                                                                   --圆边框，single为方边框
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None", --高亮样式
        }


        return
        {
            preselect = cmp.PreselectMode.None,

            snippet = --指定代码段引擎
            {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body) --使用luasnip
                end,
            },

            window =
            {
                completion = cmp.config.window.bordered(border_opts), --显示补全菜单的边框
                documentation = cmp.config.window.bordered(border_opts),
            },

            completion =
            {
                completeopt = "menu,menuone,noinsert",
            },

            mapping = cmp.mapping.preset.insert(
                {
                    --cmp.SelectBehavior.Select 选择补全项
                    --cmp.SelectBehavior.Insert 选择补全项并插入
                    --cmp.SelectBehavior.Insert 选择补全项，并用补全项替换原有的文本

                    ["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),

                    ["<CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace, }),

                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-u>"] = cmp.mapping.scroll_docs(4),

                    ["<C-l>"] = cmp.mapping.complete(), --弹出补全框
                    ["<C-e>"] = cmp.mapping.abort(),    --中止补全，不显示补全框

                    ["<tab>"] = cmp.mapping(function(fallback)
                        local luasnip = require("luasnip")

                        local char_exists = function() --检查光标前是否存在非空白字符
                            local line_and_col = vim.api.nvim_win_get_cursor(0)
                            local line = line_and_col[1]
                            local col = line_and_col[2]
                            return col ~= 0 and --列不为0
                                vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") ==
                                nil             --取当前光标位置所在行的文本内容，然后使用  sub  函数提取指定列位置的字符
                        end

                        if cmp.visible()
                        then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable()
                        then
                            luasnip.expand_or_jump()
                        elseif char_exists()
                        then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }
            ),

            sources = cmp.config.sources(
                {
                    { name = "nvim_lsp", priority = 1000 },
                    { name = "luasnip",  priority = 900 },
                    {
                        name = "buffer",
                        priority = 800,
                        option =
                        {
                            get_bufnrs = function()
                                return vim.api.nvim_list_bufs() --获取打开的所有缓冲区ID表
                            end
                        }
                    },
                    { name = "treesitter", priority = 700 },
                    { name = "path",       priority = 600 },
                    { name = "calc",       priority = 500 },
                    { name = "nvim_lua",   priority = 400 },
                    { name = "spell",      priority = 300 },
                }
            ),

            formatting =
            {
                fields =
                {
                    cmp.ItemField.Abbr,
                    cmp.ItemField.Kind,
                    cmp.ItemField.Menu,
                },

                format = function(entry, item)
                    local kind_icons =
                    {
                        Array = " ",
                        Boolean = " ",
                        Class = " ",
                        Color = " ",
                        Constant = " ",
                        Constructor = " ",
                        Copilot = " ",
                        Enum = " ",
                        EnumMember = " ",
                        Event = " ",
                        Field = " ",
                        File = " ",
                        Folder = " ",
                        Function = " ",
                        Interface = " ",
                        Key = " ",
                        Keyword = " ",
                        Method = " ",
                        Module = " ",
                        Namespace = " ",
                        Null = " ",
                        Number = " ",
                        Object = " ",
                        Operator = " ",
                        Package = " ",
                        Property = " ",
                        Reference = " ",
                        Snippet = " ",
                        String = " ",
                        Struct = " ",
                        Text = " ",
                        TypeParameter = " ",
                        Unit = " ",
                        Value = " ",
                        Variable = " ",
                    }

                    local source_icons =
                    {
                        nvim_lsp = "ﲳ",
                        nvim_lua = "",
                        treesitter = "",
                        path = "ﱮ",
                        buffer = "﬘",
                        zsh = "",
                        luasnip = "",
                        spell = "",
                    }

                    if kind_icons[item.kind] --将Class修改为   Class [nvim-lsp]
                    then
                        item.kind = kind_icons[item.kind] .. item.kind
                    end

                    if source_icons[entry.source.name]
                    then
                        item.menu = source_icons[entry.source.name] .. " " .. entry.source.name
                    end
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

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
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

        -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(":",
            {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources(
                    {
                        { name = "path" },
                    },
                    {
                        { name = "cmdline" },
                    }
                ),
            }
        )

        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local cap = require("lspconfig").util.default_config.capabilities
        cap = vim.tbl_deep_extend("force", cap, capabilities)
    end,
}
