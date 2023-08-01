--起始页面

return
{
    {
        "goolord/alpha-nvim",

        event = "VimEnter",

        dependencies = { 'nvim-tree/nvim-web-devicons' },

        keys =
        {
            {"<leader>h",

            function()
                local wins = vim.api.nvim_tabpage_list_wins(0) --获取当前标签页的所有窗口
                if #wins > 1 and vim.api.nvim_get_option_value("filetype", { win = wins[1] }) == "neo-tree" --如果当前窗口是neo-tree
                then
                  vim.fn.win_gotoid(wins[2]) ----在neo-tree窗口下，无法打开alpha。切换到非neo-tree窗口，以启动alpha
                end
                require("alpha").start(false, require("alpha").default_config) --alpha.start(on_vimenter, conf)
              end,
            desc = "home"}
        },

        opts = function()
            local dashboard = require("alpha.themes.dashboard")

            dashboard.section.header.val = { "beyond the sky, into the firmament." }

            dashboard.section.buttons.val =
            {
                dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
                dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
                dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
                dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
                dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
                dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
                dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
                dashboard.button("q", " " .. " Quit nvim", ":qa<CR>"),
            }

            for _, button in ipairs(dashboard.section.buttons.val) do
                button.opts.hl = "AlphaButtons"
                button.opts.hl_shortcut = "AlphaShortcut"
            end

            dashboard.section.header.opts.hl = "AlphaHeader"
            dashboard.section.buttons.opts.hl = "AlphaButtons"
            dashboard.section.footer.opts.hl = "AlphaFooter"
            dashboard.opts.layout[1].val = 8

            return dashboard
        end,

        config = function(_, dashboard)
            require("alpha").setup(dashboard.opts)

            vim.api.nvim_create_autocmd(
                "User",
                {
                    pattern = "LazyVimStarted",
                    desc = "Add Alpha dashboard footer",
                    callback = function()
                        local stats = require("lazy").stats()
                        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

                        dashboard.section.footer.val =
                            "⚡ Neovim loaded " ..
                            stats.count .. " plugins in " .. ms .. "ms"
                        pcall(vim.cmd.AlphaRedraw)
                    end,
                }
            )
        end,
    }
}
