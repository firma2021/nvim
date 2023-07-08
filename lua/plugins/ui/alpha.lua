--
return
{
    {
        "goolord/alpha-nvim",

        event = "VimEnter",

        dependencies = { 'nvim-tree/nvim-web-devicons' },

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

            local fortune =
            {
                "暮色苍茫看劲松，乱云飞渡仍从容。",
                "天生一个仙人洞，无限风光在险峰。",
                "道路是曲折的，前途是光明的。",
                "坐地日行八万里,巡天遥看一千河。",
                "世上无难事，只要肯登攀。",
                "物质不灭，不过粉碎。",
                "亲爱的同志，没有一条路无风无浪，会有孤独，会有悲伤，也会有无尽的希望。",
                "追备好了吗？这一程会短暂而漫长。",
                "去学着他的样子坚定扬起远行的帆。",
                "历史螺旋上升波浪前进，所以低谷时一定要微笑着信念放心中。",
                "燃烧自己，追寻真理。",
            }

            vim.api.nvim_create_autocmd(
                "User",
                {
                    pattern = "LazyVimStarted",
                    callback = function()
                        local stats = require("lazy").stats()
                        local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

                        dashboard.section.footer.val =
                            fortune[math.random(1, #fortune)] .. "\n" .. "⚡ Neovim loaded " ..
                            stats.count .. " plugins in " .. ms .. "ms"
                        pcall(vim.cmd.AlphaRedraw)
                    end,
                }
            )
        end,
    }
}
