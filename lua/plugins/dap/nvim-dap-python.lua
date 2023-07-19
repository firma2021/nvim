--与python调试器debugpy进行通信

return
{
    "mfussenegger/nvim-dap-python",

    dependencies = { "mfussenegger/nvim-dap" },

    ft = "python",

    keys =
    {
        {
            "<leader>dm",
            function()
                require('dap-python').test_method()
            end,
            desc = "debug python run"
        }
    },

    config = function(plugin, opts)
        local path = require("mason-registry").get_package("debugpy"):get_install_path() .. "/venv/bin/python"
        require("dap-python").setup(path, opts)
    end,
}
