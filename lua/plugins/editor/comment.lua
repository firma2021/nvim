return
{
    "numToStr/Comment.nvim",

    event = { "BufReadPost" },

    keys =
    {
      { "gc", mode = { "n", "v" }, desc = "toggle comment (linewise)" },
      { "gb", mode = { "n", "v" }, desc = "toggle comment (blockwise)" },
    },

    opts = function()
      local status, commentstring = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
      return status and commentstring and { pre_hook = commentstring.create_pre_hook() } or {}
    end,

    config = function(plugin, opts)
        require("Comment").setup(opts)

        vim.keymap.set( {"n"}, "<leader>/", function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end, { desc = "Toggle comment line" })
        vim.keymap.set( "v", "<leader>/", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", { desc = "Toggle comment for selection" })
    end
}
