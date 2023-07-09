--一个绚丽的，可配置的neovim通知管理器

return
{
    "rcarriga/nvim-notify",

    enent = "VeryLazy",

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
        timeout = 6000,
        max_height = function()
            return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
            return math.floor(vim.o.columns * 0.75)
        end,

        stages = "static", -- 使用最朴素的特效 "fade", "slide", "fade_in_slide_out", "static"
        fps = 1,
        on_close = nil,

        render = "default", --显示时间和消息发出者，占用的空间较大

        level = "TRACE", -- ERROR > WARN > INFO > DEBUG > TRACE

        on_open = function(win)
            vim.api.nvim_win_set_config(win, { zindex = 1000 }) --把窗口的堆叠顺序设置为最前面，覆盖其他窗口
            --if not vim.g.ui_notifications_enabled then vim.api.nvim_win_close(win, true) end
            --如果禁用消息通知，立刻关闭通知，g.ui_notifications_enabled在options.lua中定义
          end,
    },

    config = function(plugin, opts)
        local notify = require("notify")
        notify.setup(opts)

        vim.notify = notify
    end,
}
