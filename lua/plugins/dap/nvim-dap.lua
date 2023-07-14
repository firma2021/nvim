--neovim并未内置 DAP（Debug Adapter Protocol）客户端，因此需要nvim-dap插件作为客户端。

return
{
    "mfussenegger/nvim-dap",

    dependencies =
    {
        {
            "rcarriga/nvim-dap-ui", --绚丽的debugger UI
            keys =
            {
                { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
                { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
            },
            opts =
            {

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

        -- virtual text for the debugger
        {
            "theHamsta/nvim-dap-virtual-text",
            opts =
            {
                enabled = true,                        -- enable this plugin (the default)
                enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
                highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
                highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
                show_stop_reason = true,               -- show stop reason when stopped for exceptions
                commented = false,                     -- prefix virtual text with comment string
                only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
                all_references = false,                -- show virtual text on all all references of the variable (not only definitions)
                clear_on_continue = false,             -- clear virtual text on "continue" (might cause flickering when stepping)
                --- A callback that determines how a variable is displayed or whether it should be omitted
                display_callback = function(variable, buf, stackframe, node, options)
                if options.virt_text_pos == 'inline' then
                    return ' = ' .. variable.value
                else
                    return variable.name .. ' = ' .. variable.value
                end
                end,
                -- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
                virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',

                -- experimental features:
                all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
                virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
                virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
                                                    -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
            },
        },

        -- which key integration
        {
            "folke/which-key.nvim",
            optional = true,
            opts = {
                defaults = {
                    ["<leader>d"] = { name = "+debug" },
                    ["<leader>da"] = { name = "+adapters" },
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
            "<leader>dr",
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
