--超级强大的自动括号补全插件,支持多种字符
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


        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        disable_in_macro = false,       --记录和执行宏的时候，禁用
        disable_in_visualblock = false, --开启可视块模式后插入时，禁用
        disable_in_replace_mode = true,
        ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
        enable_moveright = true,
        enable_afterquote = true,         --在引号后添加括号对
        enable_check_bracket_line = true, --在同一行检查括号
        enable_bracket_in_quote = true,   --
        enable_abbr = false,              --触发缩写
        break_undo = true,                --切换break undo序列的基本规则
        map_cr = true,
        map_bs = true,   -- <BS>键
        map_c_h = false, -- <C-h>键删除一个括号对
        map_c_w = false, -- <c-w>尝试删除一个括号对
    },

    config = function(plugin, opts)
        local npairs = require("nvim-autopairs")
        npairs.setup(opts)
    end,
}
