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
	{
    	"williamboman/mason-lspconfig.nvim",
        opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {"lua_ls",})
		end,
  	},
    -- settings =
	-- {
    --     Lua =
	-- 	{
    --     workspace = {
            --   checkThirdParty = false,
            -- },
            -- completion = {
            --   callSnippet = "Replace",
            -- },
	-- 	},
	-- },
}
