--自动高亮与光标所在单词相同或相关的其它单词
return
{
    "RRethy/vim-illuminate",

    event = { "BufReadPost", "BufNewFile" },

    keys =
    {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
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

    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set("n", key, function()
          require("illuminate")["goto_" .. dir .. "_reference"](false)
        end, { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer })
      end

      map("]]", "next")
      map("[[", "prev")

    end,

}
