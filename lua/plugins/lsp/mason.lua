return
{
    "williamboman/mason.nvim",
    build = ":MasonUpdate", -- :MasonUpdate updates registry contents

    event = "VeryLazy",

    config = function ()
        require("mason").setup()
    end,

}
