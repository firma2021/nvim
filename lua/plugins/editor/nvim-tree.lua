return
{
	"nvim-tree/nvim-tree.lua",

	lazy = true,

    cmd =
	{
		"NvimTreeToggle",
		"NvimTreeOpen",
		"NvimTreeFindFile",
		"NvimTreeFindFileToggle",
		"NvimTreeRefresh",
    },

	dependencies =
	{
		"nvim-tree/nvim-web-devicons",
	},

	keys =
	{

		{ "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "nvim-tree" },
		{ "<leader>E", "<cmd>NvimTreeFindFile<cr>", desc = "nvim-tree" },
	},

    opts = function()
        local file_type = require("plugins.util.icons").file_type
        local gut_ui = require("plugins.util.icons").git
        local bookmark_ui = require("plugins.util.icons").bookmark
	-- 下面的配置大多为自定义配置，有少量默认配置
	return
    {
        filters =
		{
            dotfiles = false,
			custom = { ".DS_Store" }, -- Custom list of vim regex for file/directory names that will not be shown.
		},
		disable_netrw = true,
		hijack_netrw = true,
		hijack_cursor = true, -- 高亮显示光标所在文件的文件名的第一个字母
		hijack_unnamed_buffer_when_opening = false,
		sync_root_with_cwd = true,
        update_focused_file =
		{
			enable = true,
			update_root = true,
		},
        view =
		{
			adaptive_size = false,
			side = "left",
			width = 30,
			preserve_window_proportions = true,
		},

        renderer =
		{
			group_empty = true,
			highlight_git = true,
			highlight_opened_files = "all",
			special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md", "CMakeLists.txt", "Makefile" }, -- A list of filenames that gets highlighted

			indent_markers =
			{
				enable = true,
				inline_arrows = true,
                icons =
				{
					corner = "└",
					edge = "│",
					item = "│",
					bottom = "─",
					none = " ",
          		},
        	},

			icons =
			{
				git_placement = "after",

				glyphs =
				{
					default = file_type.file_default,
                    symlink = file_type.file_symlink,
                    bookmark = bookmark_ui,

					folder =
					{
                        default = file_type.folder_default,

						empty = file_type.empty,
                        empty_open = file_type.empty_open,

                        open = file_type.open,

						symlink = file_type.folder_symlink,
                        symlink_open = file_type.symlink_open,

						arrow_open = file_type.arrow_open,
						arrow_closed = file_type.arrow_closed,
					},
					git =
					{
						unstaged = gut_ui.unstaged,
                        staged = gut_ui.staged,
						unmerged = gut_ui.unmerged,
						renamed = gut_ui.renamed,
						untracked = gut_ui.untracked,
						deleted = gut_ui.deleted,
						ignored = gut_ui.ignored,
					},
				},
			},
  		},
    }
	end,

	config = function(plugin, opts)
		require("nvim-tree").setup(opts)
	end,
}
