return
{
    "mfussenegger/nvim-dap-python",

    dependencies = { "mfussenegger/nvim-dap" },

    ft = "python",

    event = { "BufReadPost", "InsertEnter" },

    config = function()
        require("dap-python").setup("python", {})
    end,
}
