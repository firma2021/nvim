-- luadoc:  用于生成Lua代码文档的工具
-- luap: 在Lua中进行模式匹配的库

return
{
	{
		"nvim-treesitter/nvim-treesitter",

		opts = function(plugin, opts)
			vim.list_extend(opts.ensure_installed, { "lua", "luadoc", "luap",})
		end,
	},
    -- settings =
	-- {
    --     Lua =
	-- 	{
    --         diagnostics =
	-- 		{
	-- 			globals = { "vim" },
	-- 			disable = { "different-requires" },
	-- 		},
    --         workspace =
	-- 		{
	-- 			library = {
	-- 				[vim.fn.expand("$VIMRUNTIME/lua")] = true,
	-- 				[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
	-- 			},
	-- 			maxPreload = 100000,
	-- 			preloadFileSize = 10000,
	-- 		},
	-- 		format = { enable = false },
	-- 		telemetry = { enable = false },
	-- 		-- Do not override treesitter lua highlighting with lua_ls's highlighting
	-- 		semantic = { enable = false },
	-- 	},
	-- },
}
