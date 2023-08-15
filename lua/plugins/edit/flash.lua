--快速跳转插件，对字符移动和搜索也有改进
--对字符移动的改进：<f-char> 跳转到第一个char,按f跳转到下一个char,按F跳转到上一个char
--对搜索的改进： </-string> 会对待搜索的字符串给出高亮跳转键

--类似的插件有: leap.nvim配合flit.nvim(flit的意思是轻快地飞过); hop

return
{
	{
		"folke/flash.nvim",

		event = "VeryLazy",

		opts = {},

		keys =
		{
		{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" }, --单词跳转
		{ "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" }, --块跳转
		{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
		{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
		{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
		},
    },

	{
		"nvim-telescope/telescope.nvim",

		opts = function(plugin, opts)
			local function flash(prompt_bufnr)
                require("flash").jump(
					{
						pattern = "^",
						label = { after = { 0, 0 } },
                        search =
						{
							mode = "search",
							exclude =
							{
								function(win)
								return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= "TelescopeResults"
								end,
							},
						},
						action = function(match)
							local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
							picker:set_selection(match.pos[1] - 1)
						end,
                    }
				)
			end
			opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {mappings = { n = { s = flash }, i = { ["<c-s>"] = flash }}, })
		end,
	}
}
