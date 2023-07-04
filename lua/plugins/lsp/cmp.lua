--补全引擎插件。补全源需要从外部仓库安装。
return
{
    "hrsh7th/nvim-cmp", --https://github.com/hrsh7th/nvim-cmp

    version = false,

    event = "InsertEnter",

    dependencies =
    {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
    },

    opts = function()
        vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
        local cmp = require("cmp")
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
                -- completion = cmp.config.window.bordered(),
                -- documentation = cmp.config.window.bordered(),
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
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),                                            -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                    ["<S-CR>"] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace, }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }
            ),

            sources = cmp.config.sources(
                {
                    { name = "nvim_lsp", priority = 1000 },
                    { name = "luasnip",  priority = 900 },
                    { name = "path",     priority = 800 },
                    { name = "buffer",   priority = 250 },

                }
            ),

            formatting =
            {

                format = function(_, item)
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

                    if icons[item.kind] then
                        item.kind = icons[item.kind] .. item.kind
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
