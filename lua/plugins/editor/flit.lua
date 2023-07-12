--filt的意思是轻快地飞过
return
{
    "ggandor/flit.nvim",

    keys = function()
      local ret = {}
      for index, key in ipairs({ "f", "F", "t", "T" }) do
        ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
      end
      return ret
    end,

    opts = { labeled_modes = "nx" },
}
