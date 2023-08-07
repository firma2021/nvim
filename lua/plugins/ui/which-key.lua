--弹出一个窗口，展示您将要输入的可能的快捷键。
return
{
    "folke/which-key.nvim",

	lazy = true,
    event = {"CursorHold", "CursorHoldI"},

    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300 --300毫秒后显示which-key
    end,

    opts =
    {
    },

    config = function(plugin, opts)
        local wk = require("which-key")
        wk.setup(opts)


        local defaults =
        {
            mode = { "n", "v" },
            ["g"] = { name = "goto" },
            ["gz"] = { name = "surround" },
            ["]"] = { name = "next" },
            ["["] = { name = "prev" },
            ["<leader><tab>"] = { name = "tabs" },
            ["<leader>b"] = { name = "buffer" },
            ["<leader>c"] = { name = "code" },
            ["<leader>f"] = { name = "find (telescope plugin)" },
            ["<leader>g"] = { name = "git" },
            ["<leader>l"] = { name = "LSP management" },
            ["<leader>q"] = { name = "quit/session" },
            ["<leader>s"] = { name = "search" },
            ["<leader>u"] = { name = "ui" },
            ["<leader>w"] = { name = "windows" },
            ["<leader>x"] = { name = "diagnostics/quickfix" },
            ["<leader>p"] = { name = "package management" },
        }

        wk.register(defaults)
    end,
}
