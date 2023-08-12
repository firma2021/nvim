--neovim并未内置 DAP（Debug Adapter Protocol）客户端，因此需要nvim-dap插件作为客户端
--nvim-dap为dap客户端，并不是adapter,您还需要配置adapter, 如adp.configurations.python = {...}
--并让nvim-dap启动adapter, 如dap.adapters.python = {...}

-- see :help dap.txt

return
{
    "mfussenegger/nvim-dap",

    lazy = true,
    cmd =
	{
		"DapSetLogLevel",
		"DapShowLog",
		"DapContinue",
		"DapToggleBreakpoint",
		"DapToggleRepl",
		"DapStepOver",
		"DapStepInto",
		"DapStepOut",
		"DapTerminate",
	},

    dependencies =
    {
        --绚丽的debugger UI
        {
            "rcarriga/nvim-dap-ui",

            keys =
            {
                { "<leader>du", function() require("dapui").toggle({}) end, desc = "toggle UI for DAP" },
                { "<leader>de", function() require("dapui").eval() end,     desc = "eval dapui",  mode = { "n", "v" } },
            },

            opts =
            {
                controls =
                {
                    enabled = true,
					element = "repl",
					icons =
					{
						pause = "" ,
						play = "",
						step_into = "",
						step_over = "",
						step_out = "",
						step_back = "",
						run_last = "↻",
						terminate = "󰝤",
					},
      			}
			},

			config = function(_, opts)
				local dap = require("dap")
				local dapui = require("dapui")

				dapui.setup(opts)

				--在DAP启动后，自动打开UI；DAP关闭前，自动关闭UI
				dap.listeners.after.event_initialized["dapui_config"] =function() dapui.open({})end
				dap.listeners.before.event_terminated["dapui_config"] = function()dapui.close({}) end
				dap.listeners.before.event_exited["dapui_config"] = function() dapui.close({}) end

			end,
        },

        {
            "theHamsta/nvim-dap-virtual-text", -- 在debug界面中，用虚拟文本显示变量的值
            opts = {},
        },

        {
            "folke/which-key.nvim",
            optional = true,
            opts =
			{
                defaults =
				{
                    ["<leader>d"] = { name = "debug" },
                    ["<leader>da"] = { name = "adapters" },
                },
            },
        },

        -- mason.nvim integration
        {
            "jay-babu/mason-nvim-dap.nvim",
            dependencies = "mason.nvim",
            cmd = { "DapInstall", "DapUninstall" },
            opts = {
                -- Makes a best effort to setup the various debuggers with
                -- reasonable debug configurations
                automatic_installation = true,

                -- You can provide additional configuration to the handlers,
                -- see mason-nvim-dap README for more information
                handlers = {},

                -- You'll need to check that you have the required things installed
                -- online, please don't ask me how to install them :)
                ensure_installed = {
                    -- Update this to ensure that you have the debuggers for the langs you want
                },
            },
        },
    },


    keys =
	{
        {
            "<leader>db",
            function() require("dap").toggle_breakpoint() end,
            desc = "toggle breakpoint at line"

        },

        {
            "<leader>dc",
            function() require("dap").continue() end,
            desc = "start or continue the debugger"
        },

        {
            "<leader>dB",
            function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
            desc =
            "Breakpoint Condition"
        },


        {
            "<leader>dC",
            function() require("dap").run_to_cursor() end,
            desc =
            "Run to Cursor"
        },
        {
            "<leader>dg",
            function() require("dap").goto_() end,
            desc =
            "Go to line (no execute)"
        },
        {
            "<leader>di",
            function() require("dap").step_into() end,
            desc =
            "Step Into"
        },
        {
            "<leader>dj",
            function() require("dap").down() end,
            desc =
            "Down"
        },
        { "<leader>dk", function() require("dap").up() end, desc = "Up" },
        {
            "<leader>dl",
            function() require("dap").run_last() end,
            desc =
            "Run Last"
        },
        {
            "<leader>do",
            function() require("dap").step_out() end,
            desc =
            "Step Out"
        },
        {
            "<leader>dO",
            function() require("dap").step_over() end,
            desc =
            "Step Over"
        },
        {
            "<leader>dp",
            function() require("dap").pause() end,
            desc =
            "Pause"
        },
        {
            "<leader>dR",
            function() require("dap").repl.toggle() end,
            desc =
            "Toggle REPL(Read-Eval-Print Loop)"
        },
        {
            "<leader>ds",
            function() require("dap").session() end,
            desc =
            "Session"
        },
        {
            "<leader>dt",
            function() require("dap").terminate() end,
            desc =
            "Terminate"
        },
        {
            "<leader>dw",
            function() require("dap.ui.widgets").hover() end,
            desc =
            "Widgets"
        },
    },

    config = function()
        vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

        local dap_icons =
        {
            Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
            Breakpoint = " ",
            BreakpointCondition = " ",
            BreakpointRejected = { " ", "DiagnosticError" },
            LogPoint = ".>",
        }

        for name, sign in pairs(dap_icons)
        do
            sign = type(sign) == "table" and sign or { sign }
            vim.fn.sign_define(
                "Dap" .. name,
                { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
            )
        end
    end,
}

-- vim.fn.sign_define("DapStopped", { text = "󰁕 ", texthl = "DiagnosticWarn", numhl = "" })
-- vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DiagnosticInfo", numhl = "" })
-- vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "DiagnosticError", numhl = "" })
-- vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "DiagnosticInfo", numhl = "" })
-- vim.fn.sign_define("DapLogPoint", { text = ".>", texthl = "DiagnosticInfo", numhl = "" })
