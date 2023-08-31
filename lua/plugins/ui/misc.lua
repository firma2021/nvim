return
{
    {
        "nvim-lua/plenary.nvim",
        lazy = true,
    },
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
	},
    {
        "MunifTanjim/nui.nvim",
        lazy = true,
    },
	{
        "stevearc/dressing.nvim",

        lazy = true,

        init = function() --init选项会破坏懒加载
			local lazy = require("lazy")
			vim.ui.select = function(...)
				lazy.load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end

			vim.ui.input = function(...)
				lazy.load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	}
}
