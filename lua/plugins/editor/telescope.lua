--根据文件名或文件中的内容，模糊搜索文件；会调用ripgrep程序
--see :help telescope and :help telescope.setup()

return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.2",

    version = false, --使用最新的提交

    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim", --安装这个模糊搜索算法，显著提高性能
            cond = function()
                return vim.fn.executable("make") == 1 --需要安装gcc/clang 和make
            end,
            build = "make",
        },
    },

    cmd = "Telescope",

    keys = {
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

        return {
            defaults = {
                initial_mode = "insert", --insert

                prompt_prefix = "❯",
                selection_caret = "❯",

                path_display = { "smart" }, --"truncate"

                sorting_strategy = "ascending", --上升

                layout_config = {
                    horizontal = { prompt_position = "top", preview_width = 0.55 },
                    vertical = { mirror = false },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },

                mappings = {
                    i = {
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
        }
    end,

    config = function(plugin, opts)
        local telescope = require("telescope")
        telescope.setup(opts)

        local conditional_func = function(condition, func, ...)
            if condition and type(func) == "function" then
                return func(...)
            end
        end

        local is_available = function(plug)
            local status, lazy_config = pcall(require, "lazy.core.config")
            return status and lazy_config.plugins[plug] ~= nil
        end

        conditional_func(pcall(require, "notify"), telescope.load_extension, "notify")
        conditional_func(pcall(require, "aerial"), telescope.load_extension, "aerial")
        conditional_func(is_available("telescope-fzf-native.nvim"), telescope.load_extension, "fzf")
    end,
}