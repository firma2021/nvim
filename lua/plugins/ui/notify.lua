--一个绚丽的，可配置的neovim通知管理器
return
{
    "rcarriga/nvim-notify",
    lazy = "VeryLazy",

    keys =
    {
        {
            "<leader>un",
            function()
                require("notify").dismiss({ silent = true, pending = true })
            end,
            desc = "Dismiss all Notifications",
        },
    },
    opts =
    {
        timeout = 3000,
        max_height = function()
            return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
            return math.floor(vim.o.columns * 0.75)
        end,
    },
}
