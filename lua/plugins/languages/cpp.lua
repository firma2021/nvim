--添加Treesitter解析器：cpp, c, objc, cuda, proto
--添加语言服务器：clangd
--添加格式化工具: clang-format
--添加语言特定工具链：clangd_extensions.nvim
--添加cmake-tools.nvim进行构建和debug

return
{

    {
        "jay-babu/mason-null-ls.nvim",
        dependencies = { "jose-elias-alvarez/null-ls.nvim" },
        opts = function(_, opts)
            opts.ensure_installed = { "clang-format", }
        end,
    },
    -- {
    --     "p00f/clangd_extensions.nvim",
    --     ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    --     init = function()
    --         return { "clangd" }
    --     end,
    --     opts = function()
    --         return { server = "clangd" }
    --     end,
    -- },
}
