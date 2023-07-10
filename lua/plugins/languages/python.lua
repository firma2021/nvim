--添加Treesitter解析器：python和toml
--添加语言服务器：pyright和ruff_lsp
--添加null-ls格式化源：black
--添加debug工具：debugpy

return
{
    {
        "nvim-treesitter/nvim-treesitter",
        opts = function(_, opts)
            opts.ensure_installed = { "python", "toml" }
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = function(_, opts)
            opts.ensure_installed = { "pyright", "ruff_lsp" }
        end,
    },
    {
        "jay-babu/mason-null-ls.nvim",
        dependencies = { "jose-elias-alvarez/null-ls.nvim" },
        opts = function(_, opts)
            opts.ensure_installed = { "black" }
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        opts = function(_, opts)
            opts.ensure_installed = { "python" }
        end,
    },
    {
        "linux-cultist/venv-selector.nvim",
        opts = {},
        keys =
        {
            { "<leader>lv", "<cmd>:VenvSelect<cr>", desc = "Select VirtualEnv" }
        },
    },
    {
        "mfussenegger/nvim-dap-python",
        dependencies = { "mfussenegger/nvim-dap" },
        ft = "python", --lazy-load on filetype
        event = "User AstroFile",
        config = function()
            require("dap-python").setup("python", {})
        end,
    },
}
