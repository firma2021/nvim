return
{
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features

    event = "VeryLazy",

    opts =
    {
        mappings_style = "nvim-surround",
    },

    config = function(plugin, opts)
        require("nvim-surround").setup(opts)
    end
}
