-- see :help lua-guide

require("config.options")
require("config.lazy")

require("config.autocmds")
require("config.keymaps")


-- { "godlygeek/tabular", ft = { "markdown" } }, -- requires
-- 	{ "plasticboy/vim-markdown", ft = { "markdown" } },
-- 	{
-- 		"iamcco/markdown-preview.nvim",
-- 		build = function()
-- 			vim.fn["mkdp#util#install"]()
-- 		end,
-- 		ft = { "markdown" },
-- 		dependencies = {
-- 			{ "dhruvasagar/vim-table-mode" },
-- 		},
-- 	},


-- {
-- 		"chentoast/marks.nvim",
-- 		config = function()
-- 			require("configs.marks").config()
-- 		end,
-- 	},
