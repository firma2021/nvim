return
{
    "L3MON4D3/LuaSnip",

    dependencies =
    {
        { "rafamadriz/friendly-snippets" },
    },

    --快捷键已在nvim-cmp.lua中配置
    config = function()
        local luasnip_loader = require("luasnip.loaders.from_vscode")        --使用现有的VS Code风格的snippets， 如friendly-snippets
        luasnip_loader.lazy_load()
        luasnip_loader.lazy_load({ paths = { "~/.config/nvim/snippets/" } }) --加载自定义snippets

        local luasnip = require("luasnip")
        luasnip.config.setup(
            {
                region_check_events = "CursorHold,InsertLeave,InsertEnter",
                delete_check_events = "TextChanged,InsertEnter",
            }
        )
    end,
}
