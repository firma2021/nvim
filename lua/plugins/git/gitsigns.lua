--为编辑的文件提供git集成
--see :help gitsigns.txt

return
{
    "lewis6991/gitsigns.nvim",

    event = { "BufReadPre", "BufNewFile" },

    enabled = vim.fn.executable "git" == 1,

	-- 大部分配置使用默认值，只设置了图标和快捷键
    opts =
    {
        signs =
        {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked    = { text = "┆" },
        },

        on_attach = function(buffer)
          local gs = package.loaded.gitsigns

          --在Git中，"hunk"是指在代码版本控制过程中发生更改的一段代码，通常为一组连续的行
          vim.keymap.set("n", "]g", gs.next_hunk, { buffer = buffer, desc = "next hunk" })
          vim.keymap.set("n", "[g", gs.prev_hunk, { buffer = buffer, desc = "prev hunk" })
          vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { buffer = buffer, desc = "preview hunk" })
          vim.keymap.set({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", { buffer = buffer, desc = "reset hunk" })

          vim.keymap.set("n", "<leader>gl", function() gs.blame_line() end, { buffer = buffer, desc = "blame line" })
          vim.keymap.set("n", "<leader>gL", function() gs.blame_line({ full = true }) end, { buffer = buffer, desc = "full blame line" })

          vim.keymap.set({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", { buffer = buffer, desc = "stage hunk" })

          vim.keymap.set("n", "<leader>ghS", gs.stage_buffer, { buffer = buffer, desc = "Stage Buffer" })

          vim.keymap.set("n", "<leader>ghu", gs.undo_stage_hunk, { buffer = buffer, desc = "Undo Stage Hunk" })
          vim.keymap.set("n", "<leader>ghR", gs.reset_buffer, { buffer = buffer, desc = "Reset Buffer" })


          vim.keymap.set("n", "<leader>ghd", gs.diffthis, { buffer = buffer, desc = "Diff This" })
          vim.keymap.set("n", "<leader>ghD", function() gs.diffthis("~") end, { buffer = buffer, desc = "Diff This ~" })

          vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { buffer = buffer, desc = "GitSigns Select Hunk" }) --text对象
        end,
    }

  }
