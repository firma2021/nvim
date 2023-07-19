return
{
    "jay-babu/mason-nvim-dap.nvim",

    dependencies =
    {
        "williamboman/mason.nvim",
        "mfussenegger/nvim-dap",
    },

    opts =
    {
        ensure_installed = { "python", },
        handlers = {}, --使用该插件预定义好的adapter。您也可以在nvim-dap中手动配置adapter
    },
}
