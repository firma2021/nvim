--添加Treesitter解析器：lua
--添加语言服务器：lua_ls
--添加格式化工具：stylua

return
{
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            opts.ensure_installed = { "lua", "luap" }
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = function(_, opts)
            opts.ensure_installed = { "lua_ls" }
        end,
    },
    {
        "jay-babu/mason-null-ls.nvim",
        dependencies = { "jose-elias-alvarez/null-ls.nvim" },
        opts = function(_, opts)
            opts.ensure_installed = { "stylua", "luacheck" }
        end,
    },
}
