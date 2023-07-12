return
{
    "ggandor/leap.nvim",

    keys =
    {
      { "s", mode = { "n", "x", "o" }, desc = "leap forward to" }, --向后跳
      { "S", mode = { "n", "x", "o" }, desc = "leap backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "leap from windows" },
    },

    config = function(_, opts)
      local leap = require("leap")
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end

      leap.add_default_mappings(true)

      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
}
