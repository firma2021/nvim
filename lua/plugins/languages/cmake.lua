--添加neocmake语言服务器
--添加Treesitter解析器：cmake

return
{
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            opts.ensure_installed = { "cmake" }
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = function(_, opts)
            opts.ensure_installed = { "neocmake" }
        end,
    },
}
