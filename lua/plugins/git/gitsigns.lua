--为编辑的文件提供git集成：在最左侧的符号列显示文件的修改状态
--see :help gitsigns.txt

return
{
	"lewis6991/gitsigns.nvim",

	lazy = true,
	event = { "BufReadPre", "BufNewFile" },

	enabled = vim.fn.executable "git" == 1,

	-- 大部分配置使用默认值，只设置了图标和快捷键
	opts =
	{
		signs =
		{
			add          = { text = "+" },
			change       = { text = "~" },
			delete       = { text = "_" },
			topdelete    = { text = "‾" },
			changedelete = { text = "~" },
			untracked    = { text = "┆" },
		},

		current_line_blame = false, --在普通模式下，在行尾显示git blame

		on_attach = function(buffer)
			local gs = package.loaded.gitsigns

			--在Git中，"hunk"是指在代码版本控制过程中发生更改的一段代码，通常为一组连续的行
			vim.keymap.set("n", "]g", gs.next_hunk, { buffer = buffer, desc = "next hunk" })
			vim.keymap.set("n", "[g", gs.prev_hunk, { buffer = buffer, desc = "prev hunk" })

			vim.keymap.set({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>", { buffer = buffer, desc = "stage hunk" })
			vim.keymap.set({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>", { buffer = buffer, desc = "reset hunk" })

			vim.keymap.set("n", "<leader>gS", gs.stage_buffer, { buffer = buffer, desc = "stage buffer" })
            vim.keymap.set("n", "<leader>gu", gs.undo_stage_hunk, { buffer = buffer, desc = "undo stage Hunk" })

			vim.keymap.set("n", "<leader>gR", gs.reset_buffer, { buffer = buffer, desc = "reset buffer" })
			vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { buffer = buffer, desc = "preview hunk" })

			vim.keymap.set("n", "<leader>gb", function() gs.blame_line({ full = true }) end, { buffer = buffer, desc = "full blame line" })

			vim.keymap.set("n", "<leader>gd", gs.diffthis, { buffer = buffer, desc = "diff this" })
			vim.keymap.set("n", "<leader>gD", function() gs.diffthis("~") end, { buffer = buffer, desc = "diff this ~" })

			vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { buffer = buffer, desc = "select hunk" }) --text对象

		end,
	}

}
