--状态栏
--see :help lualine.txt

return
{
	"nvim-lualine/lualine.nvim",

	lazy = true,
	event =  { "BufReadPost", "BufNewFile" },

    dependencies =
	{
		"arkav/lualine-lsp-progress",
		"stevearc/aerial.nvim",
	},

    opts = function()

        local function has_dot_git_dir()
            local gitdir = vim.fs.find(".git", {limit = 1, upward = true, type = "directory", path = vim.fn.expand("%:p:h"),})
            return #gitdir > 0
        end

        local icons = require("plugins.util.icons")
		local watch =icons.widget.Watch
        local diag = icons.diagnostics
		local git = icons.git
        local com = icons.component
        local py = icons.lang.python
        local fs = icons.file_status

		return
		{
			options =
			{
				theme = "catppuccin",

				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },

				disabled_filetypes =
				{
					statusline = { "alpha", "lazy", },
					winbar = {},
				},


				globalstatus = true, --只有一个全局状态栏，而不是每个窗口都有一个

				--每隔2秒刷新状态栏，如果有特定事件发生而没有到达刷新时间，不保证会刷新状态栏
				refresh =
				{
					statusline = 3000,
					tabline = 3000,
					winbar = 3000,
				},
			},

			sections =
			{
				lualine_a =
				{
                    "mode",
					{ "datetime", style = watch .. "%H:%M" },
				},

				lualine_b =
				{
                    {
                        "branch",
                        icon = git.branch,
						color = {fg = "#04A5E5", gui = "bold"},
						cond = has_dot_git_dir,
					},
					{
						"diff",
						symbols =
						{
							added = git.added,
							modified = git.modified,
							removed = git.removed,
                        },
                        -- source =
                        -- {
						-- 	added = vim.b.gitsigns_status_dict.added,
						-- 	modified = vim.b.gitsigns_status_dict.changed,
                        --  removed = vim.b.gitsigns_status_dict.removed,
						-- },
						cond = has_dot_git_dir,
					},
				},

				lualine_c =
				{
					{
						"diagnostics",
                        sources = { "nvim_diagnostic" },
						sections = { 'error', 'warn', 'info', 'hint' }, -- use default value
                        symbols =
						{
							error =diag.Error,
							warn = diag.Warn,
							info = diag.Info,
							hint = diag.Hint,
						},
					},
					{
						function()
							local clients = vim.lsp.get_active_clients() --获取活跃的LSP客户端
							if next(clients) == nil then
								return "no active lsp"
							end

							local msg = ""

							local buf_ft = vim.api.nvim_buf_get_option(0, "filetype") --获取当前缓冲区文件类型

							for index, client in ipairs(clients) do
								local filetypes = client.config.filetypes
								if
									filetypes
									and vim.fn.index(filetypes, buf_ft) ~= -1 --检查当前缓冲区的文件类型是否在lSP支持的文件类型列表中
								then
									msg = msg .. "[+" .. client.name .. "]"
								else
									msg = msg .. "[-" .. client.name .. "]"
								end
							end

							return msg
						end,

						icon = com.LSP,

						color = { fg = "#ec5f67", gui = "bold" },
					},
                    {
						"lsp_progress",
					},
					{
						function()
							return com.DAP .. require("dap").status()
						end,

						cond = function()
							return package.loaded["dap"] and require("dap").status() ~= ""
						end,

						color = function()
							local hl = vim.api.nvim_get_hl(0, { name = "Debug" })
							local fg = hl and hl.fg
							return fg and { fg = string.format("#%06x", fg) } --如果fg不为空，返回6位16进制字符串
						end,
                    },
                    {
                        function()
                            local path = os.getenv("VIRTUAL_ENV") -- python virtual env
							if path then
								return py .. path:sub(path:match(".*/()"))
							end
							path = os.getenv("CONDA_DEFAULT_ENV") --python conda virtual env
                            if path then
                                return py .. path:sub(path:match(".*/()"))
                            end
							return py .."invalid venv"
						end,
						cond = function ()
							return vim.api.nvim_buf_get_option(0, "filetype") == "python" and (os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_DEFAULT_ENV"))
                        end,

						color = { "#F28FAD", gui = "bold" },
					}
				},

                lualine_x =
				{
					{
						function() return "msg" .. require("noice").api.status.message.get_hl() end,
						cond = package.loaded["noice"] and require("noice").api.status.message.has,
          			},
					{
						function() return "cmd" .. require("noice").api.status.command.get() end,
						cond = package.loaded["noice"] and require("noice").api.status.command.has,
						color = { fg = "#ff9e64" },
					},
					{
						function() return "mode" .. require("noice").api.status.mode.get() end,
						cond = package.loaded["noice"] and require("noice").api.status.mode.has,
						color = { fg = "#ff9e64" },
					},
					{
						function() return "lazy" .. require("lazy.status").updates() end,
						cond = require("lazy.status").has_updates,
						color = { fg = "#ff9e64" },
					},
				},
                lualine_y =
				{
					{
						"filetype",
						icon_only = true,
                    },
                    {
						"filename",
						file_status = true, --显示文件状态
						newfile_status = true, --显示新文件(创建后未写入的文件)的状态
                        symbols =
						{
							modified = fs.modified,
							readonly = fs.readonly,
							unnamed = fs.unnamed,
							newfile = fs.newfile,
						},
					},
                    {
						"filesize",
                    },
                    {
						function()
                            return " " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
						end,
					},
                    {
                        "encoding",
					},
                    {
                        "fileformat",
                        symbols =
						{
							unix = " ".."LF",
							dos = " ".."CRLF",
							mac = " ".."CR",
						},
					},
				},
                lualine_z =
				{
                    {
						"location",
				 	},
                    {
						"progress",
					},
				},
			},

			--非活动窗口的状态栏。在之前的配置中，我们规定只使用一个全局状态栏，因此这项配置是多余的。
            inactive_sections =
			{
				lualine_a = {},
				lualine_b = {},
                lualine_c =
				{
					{
						"filename",
						file_status = true, --显示文件状态
						newfile_status = true, --显示新文件(创建后未写入的文件)的状态
                        symbols =
						{
							modified = "[+]",
							readonly = "[-]",
							unnamed = "[no name]",
							newfile = "[new]",
						},
					},
				},
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},

            winbar =
			{
                lualine_a =
				{
					{
						"filename",
						file_status = false, --不显示文件状态
						newfile_status = false, --不显示新文件(创建后未写入的文件)的状态
						path = 3, --绝对路径，使用波浪号表示家目录
					},
				},
				lualine_b =
				{
					{
						"aerial",
					},
				},

				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},

            inactive_winbar =
			{
				lualine_a = {},
				lualine_b = {},
                lualine_c =
				{
					{
						"filename",
						path = 3, --绝对路径，使用波浪号表示家目录
					},
				},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},

			--这些插件可以改变状态栏的样式
            extensions =
			{
                "aerial",
                "lazy",
				"man",
				"neo-tree",
                "nvim-dap-ui",
                "overseer",
				"quickfix",
                "toggleterm",
				{ sections = { lualine_a = { "filetype" }, }, filetypes = { "DiffviewFiles" }, }, --自定义插件
			},
		}
	end,
}
