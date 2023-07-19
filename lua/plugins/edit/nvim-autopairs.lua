--自动补全括号,支持多种字符

return
{
    'windwp/nvim-autopairs',

    event = "InsertEnter",

    opts =
    {
        check_ts = true, --check treesitter
        ts_config =
        {
            java = false, --don't check treesitter on java
            lua = { "string" }, --do not add a pair on that treesitter node
            javascript = { "template_string" },
        },

        fast_wrap =
        {
            map = "<M-e>",
            chars = { "{", "[", "(", '"', "'" },
            pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
            offset = 0,
            end_key = "$",
            keys = "qwertyuiopzxcvbnmasdfghjkl",
            check_comma = true,
            highlight = "PmenuSel",
            highlight_grey = "LineNr",
        },
    },

    config = function(plugin, opts)
        require("nvim-autopairs").setup(opts)

        local cmp_autopairs = require('nvim-autopairs.completion.cmp')
        local cmp = require('cmp')
        cmp.event:on('confirm_done',cmp_autopairs.on_confirm_done())
    end,
}
