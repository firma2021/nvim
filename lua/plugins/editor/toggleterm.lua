return
{
    "akinsho/toggleterm.nvim",
	version = "*", -- install the latest stable version of plugins that support Semver

	lazy = true,

    cmd =
	{
        "ToggleTerm",
        "TermExec", --usage: TermExec cmd="ls -lh"
		"ToggleTermSetName",
		"ToggleTermToggleAll",
		"ToggleTermSendVisualLines",
		"ToggleTermSendCurrentLine",
		"ToggleTermSendVisualSelection",
	},

    opts =
    {
        size = 10, --终端的大小

        on_create = function() --终端第一次创建时执行的函数
          vim.opt.foldcolumn = "0" --隐藏折叠列
          vim.opt.signcolumn = "no" --隐藏标记列
        end,

        open_mapping = [[<F7>]],

        direction = "float",
        persist_mode = false, -- if set to true (default) the previous terminal mode will be remembered

        float_opts =
        {
          border = "curved", --弧形
        },

		start_in_insert = true,
    },

    --count是终端的id,用来触发终端。
    --输入:5ToggleTerm<CR> 触发5号终端，且vim.v.count的值被设置为5。
    config = function(plugin, opts)
		print("hello world!!!!")
      require("toggleterm").setup(opts)
	  print("hello world!")
      local function toggle_term_cmd(cmd_string)
        local global_terms = {}

        opts = { cmd = cmd_string, hidden = false } --hidden为true时，该终端不能被 :ToggleTerm命令打开

        local num = vim.v.count > 0 and vim.v.count or 1

        if not global_terms[opts.cmd]
        then
          global_terms[opts.cmd] = {}
        end

        if not global_terms[opts.cmd][num]
        then
          if not opts.count then opts.count = vim.tbl_count(global_terms) * 100 + num end
          if not opts.on_exit then opts.on_exit = function() global_terms[opts.cmd][num] = nil end end
          global_terms[opts.cmd][num] = require("toggleterm.terminal").Terminal:new(opts)
        end

        global_terms[opts.cmd][num]:toggle()
      end

      --vim.keymap.set(mode, keymap, cmd, keymap_opts)
      if vim.fn.executable "gitui" == 1
      then
       vim.keymap.set( "n", "<leader>gg", function() toggle_term_cmd("gitui") end, { desc = "ToggleTerm gitui"})
       vim.keymap.set( "n", "<leader>tl", function() toggle_term_cmd("lazygit") end, { desc = "ToggleTerm gitui"})
      end

      if vim.fn.executable "node" == 1
      then
       vim.keymap.set( "n", "<leader>tn", function() toggle_term_cmd("node") end, { desc = "ToggleTerm node" })
      end

      if vim.fn.executable "gdu" == 1
      then
       vim.keymap.set( "n", "<leader>tu", function() toggle_term_cmd("gdu") end, { desc = "ToggleTerm gdu" })
      end

      if vim.fn.executable "btm" == 1
      then
       vim.keymap.set( "n", "<leader>tt", function() toggle_term_cmd("btm") end, { desc = "ToggleTerm btm" })
      end

      local python = vim.fn.executable "python" == 1 and "python" or vim.fn.executable "python3" == 1 and "python3"
      if python
      then
        vim.keymap.set( "n", "<leader>tp", function() toggle_term_cmd(python) end, { desc = "ToggleTerm python" })
      end

      vim.keymap.set( "n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "ToggleTerm float" })
      vim.keymap.set( "n", "<leader>th", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", { desc = "ToggleTerm horizontal split" })
      vim.keymap.set( "n", "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", { desc = "ToggleTerm vertical split" })
      vim.keymap.set( {"n", "t"}, "<F7>", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
    end
}
