--根据文件名或文件中的内容，模糊搜索文件；会调用ripgrep程序
--see :help telescope and :help telescope.setup()

return
{
    "nvim-telescope/telescope.nvim",

    dependencies =
	{
        { "nvim-lua/plenary.nvim" },

        {
            "nvim-telescope/telescope-fzf-native.nvim", --安装这个模糊搜索算法，显著提高性能
            cond = function()
                return vim.fn.executable("make") == 1 --需要安装gcc/clang 和make
            end,
            build = "make",
        },
		{ "debugloop/telescope-undo.nvim" }, -- fuzzy find undo history
		{
			"ahmedkhalf/project.nvim", --superior project management solution
			event = { "CursorHold", "CursorHoldI" },
			config = function ()
				require("project_nvim").setup({ignore_lsp = { "codeium" }, })
			end,
		},
        {
            "nvim-telescope/telescope-frecency.nvim",
            dependencies =
			{
				{ "kkharji/sqlite.lua" },
            },
		},
		{ "jvgrootveld/telescope-zoxide" },
		{ "nvim-telescope/telescope-live-grep-args.nvim" },
    },

    lazy = true,

    cmd = "Telescope",

    keys =
	{
        --git
        { "<leader>gb", "<cmd>Telescope git_branches<CR>",                  desc = "Git branches" },
        { "<leader>gc", "<cmd>Telescope git_commits<CR>",                   desc = "Git commits" },
        { "<leader>gs", "<cmd>Telescope git_status<CR>",                    desc = "Git status" },
        { "<leader>,",  "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch buffer" },
        { "<leader>:",  "<cmd>Telescope command_history<cr>",               desc = "Command history" },

        { "<leader>ff", "<cmd>Telescope find_files<CR>",                    desc = "Find files" },
        {
            "<leader>fF",
            function()
                require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
            end,
            desc = "Find all files",
        },

        { "<leader>fg",    "<cmd>Telescope live_grep<CR>",                 desc = "telescope live_grep" },
        { "<leader>fo",    "<cmd>Telescope oldfiles<CR>",                  desc = "telescope oldfiles" },
        { "<leader>f<cr>", "<cmd>Telescope resume<CR>",                    desc = "resume telescope search" },
        { "<leader>fa",    "<cmd>Telescope autocommands<cr>",              desc = "Find auto commands" },
        { "<leader>fb",    "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Current file fuzzy find" },
        { "<leader>fc",    "<cmd>Telescope command_history<cr>",           desc = "Command history" },
        { "<leader>fC",    "<cmd>Telescope commands<cr>",                  desc = "Find commands" },
        { "<leader>fd",    "<cmd>Telescope diagnostics<cr>",               desc = "find diagnostics" },
        { "<leader>fw",    "<cmd>Telescope grep_string<cr>",               desc = "Find for word under cursor" },
        { "<leader>fh",    "<cmd>Telescope help_tags<cr>",                 desc = "find nvim help tags" },
        { "<leader>fH",    "<cmd>Telescope highlights<cr>",                desc = "find highlight groups" },
        { "<leader>fk",    "<cmd>Telescope keymaps<cr>",                   desc = "Find keymaps" },
        { "<leader>fm",    "<cmd>Telescope man_pages<cr>",                 desc = "Find man pages" },
        { "<leader>fM",    "<cmd>Telescope marks<cr>",                     desc = "Jump to mark" },
        { "<leader>fo",    "<cmd>Telescope vim_options<cr>",               desc = "Vim options" },
        { "<leader>fr",    "<cmd>Telescope registers<cr>",                 desc = "Find registers" },

        {
            "<leader>ft",
            function()
                require("telescope.builtin").colorscheme({ enable_preview = true })
            end,
            desc = "find themes",
        },

        {
            "<leader>ls",
            function()
                local status, _ = pcall(require, "aerial")
                if status then
                    require("telescope").extensions.aerial.aerial()
                else
                    require("telescope.builtin").lsp_document_symbols()
                end
            end,
            desc = "Search symbols (telescope plugin)",
        },

        {
            "<leader>/",
            function()
                require("telescope.builtin").current_buffer_fuzzy_find(
                    require("telescope.themes").get_dropdown({ winblend = 10, previewer = false })
                )
            end,
            desc = "[/] Fuzzily search in current buffer",
        },

        {
            "<leader>gf",
            function()
                require("telescope.builtin").git_files()
            end,
            desc = "Search [G]it [F]iles",
        },
    },

    opts = function()
        local actions = require("telescope.actions")

        return
		{
            defaults =
			{
                vimgrep_arguments =
                {
                    "rg",
					"-L", --ripgrep will follow symbolic links while traversing directories
					"--color=never",
					"--no-heading", -- Don't group matches by each file.
					"--with-filename", --Display the file path for matches. This is the default when more than one file is searched.
					"--line-number", -- Show line numbers (1-based). This is enabled by default when searching in aterminal.
					"--column", -- Show column numbers (1-based). This only shows the column numbers for the first match on each line. This does not try to account for Unicode. One byte is equal to one column.This implies --line-number.
					"--smart-case", -- 如果pattern全为小写字母，则大小写不敏感
                },

				initial_mode = "insert", --insert

                prompt_prefix = "  ",
                selection_caret = "❯",

                path_display = { "absolute" },

                sorting_strategy = "ascending", --上升

                layout_config =
				{
                    horizontal = { prompt_position = "top", preview_width = 0.55 },
                    vertical = { mirror = false },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },

                file_ignore_patterns = { "node_modules" },

                mappings =
				{
                    i =
					{
                        ["<C-n>"] = actions.cycle_history_next,
                        ["<C-p>"] = actions.cycle_history_prev,
                        ["<down>"] = actions.cycle_history_next,
                        ["<up>"] = actions.cycle_history_prev,

                        ["<C-u>"] = actions.preview_scrolling_up, --上下滚动预览窗口中的内容
                        ["<C-d>"] = actions.preview_scrolling_down,

                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,

                        ["<C-c>"] = actions.close,
                    },
                    n = { q = actions.close },
                },
            },

			extensions =
            {
                fzf =
				{
					fuzzy = false,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
				frecency =
				{
					show_scores = true,
					show_unindexed = true,
					ignore_patterns = { "*.git/*", "*/tmp/*" },
                },
                live_grep_args =
				{
					auto_quoting = true, -- enable/disable auto-quoting
					-- define mappings, e.g.
						mappings =
					{ -- extend mappings
						i = {
							["<C-k>"] = require("telescope-live-grep-args.actions").quote_prompt(),
							["<C-i>"] = require("telescope-live-grep-args.actions").quote_prompt({ postfix = " --iglob " }),
						},
					},
                },
                undo =
				{
					side_by_side = true,
                    mappings =
					{ -- this whole table is the default
                        i =
						{
							-- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
							-- you want to use the following actions. This means installing as a dependency of
							-- telescope in it's `requirements` and loading this extension from there instead of
							-- having the separate plugin definition as outlined above. See issue #6.
							["<cr>"] = require("telescope-undo.actions").yank_additions,
							["<S-cr>"] = require("telescope-undo.actions").yank_deletions,
							["<C-cr>"] = require("telescope-undo.actions").restore,
						},
					},
				},
			},
        }
    end,

    config = function(plugin, opts)
        local telescope = require("telescope")
        telescope.setup(opts)

		telescope.load_extension("aerial")
		telescope.load_extension("frecency")
		telescope.load_extension("fzf")
		telescope.load_extension("live_grep_args")
		telescope.load_extension("notify")
		telescope.load_extension("projects")
		telescope.load_extension("undo")
		telescope.load_extension("zoxide")
    end,
}
