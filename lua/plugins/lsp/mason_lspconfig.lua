--mason-lspconfig是 mason.nvim 和 lspconfig 之间的桥梁，使得后两个插件的使用更容易
return
{
    "williamboman/mason-lspconfig",

    event = { "BufReadPre", "BufNewFile" },

    dependencies =
    {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
    },

    opts =
    {
        ensure_installed = --如果这些服务器并没有被安装，则自动安装
        {
            "clangd",
            "cmake",
            "neocmake",

            "pyright",

            "lua_ls",

            "cssls",
            "html",
            "jsonls",
            "quick_lint_js",

            "marksman",

            "sqlls",

            "vimls",

            "yamlls",
        },

        automatic_installation = true, --通过lspconfig设置的服务器，如果没有安装，是否要自动安装
    }
}
