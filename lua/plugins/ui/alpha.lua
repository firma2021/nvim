--起始页面

return
{
	{
		"goolord/alpha-nvim",

		lazy = true,
		event = "BufWinEnter", -- latter than "VimEnter",

		dependencies = { 'nvim-tree/nvim-web-devicons' },

		-- 在neo-tree窗口下，无法打开alpha。切换到非neo-tree窗口，以启动alpha
		-- 下面的函数 获取当前标签页的所有窗口, 如果当前窗口是neo-tree, 则切换到其他窗口
		keys =
		{
			{
				"<leader>h",

				function()
					local wins = vim.api.nvim_tabpage_list_wins(0)
					if #wins > 1 and vim.api.nvim_get_option_value("filetype", { win = wins[1] }) == "neo-tree" then
						vim.fn.win_gotoid(wins[2])
					end
					require("alpha").start(false, require("alpha").default_config) --alpha.start(on_vimenter, conf)
				end,

				desc = "home (dashboard)"
			}
		},

		opts = function()
			local dashboard = require("alpha.themes.dashboard")

			dashboard.section.header.val = { "beyond the sky, into the firmament." }

			dashboard.section.buttons.val =
			{
				dashboard.button("t", " " .. " theme change", ":Telescope colorscheme <CR>"),
                dashboard.button("n", " " .. " new file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("p", " " .. " find project", ":Telescope projects <CR>"),
				dashboard.button("r", " " .. " recent files", ":Telescope oldfiles <CR>"),
				dashboard.button("f", " " .. " frecency files", ":Telescope frecency <CR>"),
				dashboard.button("i", " " .. " Find file", ":Telescope find_files <CR>"),
				dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
				dashboard.button("s", " " .. " Restore Session", [[:lua require("persistence").load() <cr>]]),
				dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
				dashboard.button("l", "󰒲 " .. " Lazy", ":Lazy<CR>"),
				dashboard.button("q", " " .. " Quit nvim", ":qa<CR>"),
			}

			vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#04A5E5" })
			vim.api.nvim_set_hl(0, "AlphaButtons", { fg = "#E95678",  })
			vim.api.nvim_set_hl(0, "AlphaShortcut", { fg = "#CBA6F7", })
			vim.api.nvim_set_hl(0, "AlphaFooter", { fg = "#FF8700",  })

			dashboard.section.header.opts.hl = "AlphaHeader"
			dashboard.section.buttons.opts.hl = "AlphaButtons"
            dashboard.section.footer.opts.hl = "AlphaFooter"

			for _, button in ipairs(dashboard.section.buttons.val) do
				button.opts.hl = "AlphaButtons"
				button.opts.hl_shortcut = "AlphaShortcut"
			end

			dashboard.opts.layout[1].val = 8

			return dashboard
		end,

		config = function(dashboard, dashboard_opts)
			require("alpha").setup(dashboard_opts.opts)

			local function make_footer()
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
				local version = vim.version()
				return "Neovim " .. version.major .. "." .. version.minor .. "." .. version.patch
					.. "⚡ Neovim loaded " .. stats.count .. " plugins in " .. ms .. "ms"
			end

			-- footer中显示了neovim的加载时间，这个时间需要在LazyVimStarted事件发生后再显示，否则显示为0
			vim.api.nvim_create_autocmd(
				"User", -- 通用的用户事件
				{
					pattern = "LazyVimStarted",
					callback = function()
						dashboard_opts.section.footer.val = make_footer()
						pcall(vim.cmd.AlphaRedraw) -- 重新绘制 Alpha dashboard
					end,
					desc = "Add Alpha dashboard footer",
				}
			)
		end,
	}
}
