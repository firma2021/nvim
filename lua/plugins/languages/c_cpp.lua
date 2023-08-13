return
{
	{
        "nvim-treesitter/nvim-treesitter",

		opts = function(plugin, opts)
			vim.list_extend(opts.ensure_installed, { "c", "cpp" }) --" cuda","proto", (Protobuf)
		end,
	},

	{
        "neovim/nvim-lspconfig",

        opts =
		{
            servers =
			{
                clangd =
				{
                    keys =
					{
						{ "<leader>cR", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "switch source/header (C/C++)" },
                    },

                    capabilities =
					{
						offsetEncoding = { "utf-16" },
                    },

					cmd =
					{
						"clangd",

						"--query-driver=/usr/bin/**/clang-*,/usr/bin/gcc,/usr/bin/g++",

						"--background-index",
						"--background-index-priority=background",

						"--all-scopes-completion",
						"--completion-style=detailed",
						"--function-arg-placeholders",
						"--header-insertion=iwyu",
						"--header-insertion-decorators",
						"--all-scopes-completion",

						"-j=12",

						"--pch-storage=memory",

						"--pretty",

						"--clang-tidy",

						"--enable-config",
                    },

                    init_options =
					{
						usePlaceholders = true,
						completeUnimported = true,
						clangdFileStatus = true,
					},
				},
            },
    	},
    },

  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies =
	{

      "williamboman/mason.nvim",
      optional = true,
      opts = function(_, opts)
        if type(opts.ensure_installed) == "table" then
          vim.list_extend(opts.ensure_installed, { "codelldb" })
        end
      end,
    },
    opts = function()
      local dap = require("dap")
      if not dap.adapters["codelldb"] then
        require("dap").adapters["codelldb"] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "codelldb",
            args = {
              "--port",
              "${port}",
            },
          },
        }
      end
      for _, lang in ipairs({ "c", "cpp" }) do
        dap.configurations[lang] = {
          {
            type = "codelldb",
            request = "launch",
            name = "Launch file",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
          },
          {
            type = "codelldb",
            request = "attach",
            name = "Attach to process",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end,
  },
}
