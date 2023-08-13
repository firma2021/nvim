--简单的自动化的session管理器
return
{
    "folke/persistence.nvim",

	lazy = true,
    event = "BufReadPre",

    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" } },

    keys =
    {
      { "<leader>qs", function() require("persistence").load() end, desc = "restore session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "restore last session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "stop saving current session" },
    },

}
