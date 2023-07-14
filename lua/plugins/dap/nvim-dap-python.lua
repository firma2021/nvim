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

    config = function()
        local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
        require("dap-python").setup(path)
    end,
}
