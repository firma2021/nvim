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
    },

    opts = function()
        vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
        local cmp = require("cmp")

        local border_opts =
        {
            border = "single",                                                                    --单线边框
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None", --高亮样式
        }

        return
        {
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
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),

                    ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),

                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<S-CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace, }),
                }
            ),

            sources = cmp.config.sources(
                {
                    { name = "nvim_lsp", priority = 1000 },
                    { name = "luasnip",  priority = 900 },
                    { name = "buffer",   priority = 800 },
                    { name = "path",     priority = 700 },
                }
            ),

            formatting =
            {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, item)
                    local icons =
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
                    --local kind_icons = {
                    --Text = "",
                    --Method = "m",
                    --Function = "",
                    --Constructor = "",
                    --Field = "",
                    --Variable = "",
                    --Class = "",
                    --Interface = "",
                    --Module = "",
                    --Property = "",
                    --Unit = "",
                    --Value = "",
                    --Enum = "",
                    --Keyword = "",
                    --Snippet = "",
                    --Color = "",
                    --File = "",
                    --Reference = "",
                    --Folder = "",
                    --EnumMember = "",
                    --Constant = "",
                    --Struct = "",
                    --Event = "",
                    --Operator = "",
                    --TypeParameter = "",
                    --}

                    if icons[item.kind] then --将Class修改为   Class [nvim-lsp]
                        item.kind = icons[item.kind] .. item.kind .. " [" .. entry.source.name .. "]"
                    end
                    return item
                end,
            },

            experimental =
            {
                ghost_text =
                {
                    hl_group = "CmpGhostText",
                },
            },
        }
    end,
}
