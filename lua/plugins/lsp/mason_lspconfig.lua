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

    opts = function()
        local lspconfig = require("lspconfig")

        return
        {
            ensure_installed = --如果这些服务器并没有被安装，则自动安装
            {
                "clangd",
                "cmake",
                "neocmake",
                "pyright",
                "lua_ls",
            },

            automatic_installation = true, --通过lspconfig设置的服务器，如果没有安装，是否要自动安装

            handlers =
            {
                ["lua_ls"] = function()
                    lspconfig.lua_ls.setup
                    {
                        settings =
                        {
                            Lua =
                            {
                                diagnostics =
                                {
                                    globals = { "vim" } --使语言服务器识别 vim global
                                },
                                workspace =
                                {
                                    library = vim.api.nvim_get_runtime_file("", true), --让语言服务器发现Neovim运行时文件
                                },
                            }
                        }
                    }
                end,

                ["clangd"] = function()
                    lspconfig.clangd.setup
                    {
                        filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
                        cmd =
                        {
                            "clangd",
                            "--header-insertion=never",
                            "--query-driver=/opt/homebrew/opt/llvm/bin/clang",
                            "--all-scopes-completion",
                            "--completion-style=detailed",
                        }
                    }
                end
            },


        }
    end
}
