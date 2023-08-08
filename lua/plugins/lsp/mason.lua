--轻便的跨平台的包管理器，可以容易地安装和管理LSP服务器，DAP服务器，代码检查工具，格式化工具。
--安装路径为neovim的stdpath。

--该插件会尽可能加载少的组件以优化启动速度，不推荐懒加载它。

--尽管许多包可以在NeoVim中直接使用，但推荐使用第三方插件进一步集成这些包。
--推荐安装的第三方插件有：
--mason-lspconfig.nvim (LSP)
--nvim-dap-ui (DAP)
--null-ls.nvim (linter, formatter)

return
{
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents

    cmd = { "Mason", "MasonLog" },

    keys =
    {
        { "<leader>pm",  "<cmd>Mason<cr>",    desc = "Mason (install and manage LSP servers)" },
        { "<leader>pM", "<cmd>MasonUpdateAll<cr>", desc = "Mason update all" }
    },


    opts = --基本使用默认配置，只稍微修改了ui
    {
		ui =
        {
            border = "rounded",
			icons =
            {
                package_installed = "󰄳",
                package_pending = "",
                package_uninstalled = "󰊠"
            },
        }
    }
}
