--自动高亮与光标所在单词相同或相关的其它单词
return
{
    "RRethy/vim-illuminate",

	lazy = true,
    event = { "BufReadPost", "BufNewFile" },

    keys =
    {
      { "]]", desc = "next word reference" },
      { "[[", desc = "prev word reference" },
    },

    opts =
    {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides =
      {
        providers = { "lsp" },
      },
    },

    config = function(plugin, opts)
      require("illuminate").configure(opts)

      vim.keymap.set("n", "]]", function() require("illuminate")["goto_next_reference"](false) end, { desc = "goto_next_reference (vim-illuminate)", })
	  vim.keymap.set("n", "[[", function() require("illuminate")["goto_prev_reference"](false) end, { desc = "goto prev reference (vim-illuminate)", })
    end,

}
