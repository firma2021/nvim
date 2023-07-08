--根据文件名或文件中的内容，模糊搜索文件；会调用ripgrep程序

return
{
    'nvim-telescope/telescope.nvim',

    tag = '0.1.2',

    version = false, --使用最新的提交

    dependencies =
    {
        'nvim-lua/plenary.nvim',
        { "nvim-telescope/telescope-fzf-native.nvim", enabled = vim.fn.executable "make" == 1, build = "make" },
    },

    cmd = "Telescope",

    keys =
    {
        --git
        { "<leader>gb",    "<cmd>Telescope git_branches<CR>", desc = "Git branches (telescope plugin)" },
        { "<leader>gc",    "<cmd>Telescope git_commits<CR>",  desc = "Git commits (telescope plugin)" },
        { "<leader>gs",    "<cmd>Telescope git_status<CR>", desc = "Git status (telescope plugin)" },

        --find
        { "<leader>fb",    "<cmd>Telescope buffers<cr>", desc = "Find buffers (telescope plugin)" },
        { "<leader>ff",    ":Telescope find_files<CR>", desc = "Find files (telescope plugin)" },
        { "<leader>fg",    ":Telescope live_grep<CR>", desc = "telescope live_grep" },
        { "<leader>fo",    ":Telescope oldfiles<CR>", desc = "telescope oldfiles" },
        { "<leader>fr",    ":Telescope resume<CR>",                                    desc = "telescope resume" },

        { "<leader>f<CR>", function() require("telescope.builtin").resume() end,       desc = "Resume previous search" },
        { "<leader>f'",    function() require("telescope.builtin").marks() end,        desc = "Find marks" },

        {
            "<leader>fc",
            function() require("telescope.builtin").grep_string() end,
            desc =
            "Find for word under cursor"
        },
        { "<leader>fC", function() require("telescope.builtin").commands() end,   desc = "Find commands" },
        { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find files" },
        {
            "<leader>fF",
            function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
            desc = "Find all files",
        },
        {
            "<leader>fh",
            function() require("telescope.builtin").help_tags() end,
            desc =
            "Find help"
        },
        {
            "<leader>fk",
            function() require("telescope.builtin").keymaps() end,
            desc =
            "Find keymaps"
        },
        {
            "<leader>fm",
            function() require("telescope.builtin").man_pages() end,
            desc =
            "Find man"
        },
        {
            "<leader>fo",
            function() require("telescope.builtin").oldfiles() end,
            desc =
            "Find history"
        },
        {
            "<leader>fr",
            function() require("telescope.builtin").registers() end,
            desc =
            "Find registers"
        },
        {
            "<leader>ft",
            function() require("telescope.builtin").colorscheme { enable_preview = true } end,
            desc = "Find themes"
        },


        { "<leader>fw", function() require("telescope.builtin").live_grep() end, desc = "Find words" },
        {
            "<leader>fW",
            function()
                require("telescope.builtin").live_grep {
                    additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
                }
            end,
            desc = "Find words in all files",
        },

        {
            "<leader>ls",
            function()
                local aerial_avail, _ = pcall(require, "aerial")
                if aerial_avail then
                    require("telescope").extensions.aerial.aerial()
                else
                    require("telescope.builtin").lsp_document_symbols()
                end
            end,
            desc = "Search symbols",
        }
    },

    opts = function()
        local actions = require "telescope.actions"

        return
        {
            defaults =
            {
                prompt_prefix = "❯",
                selection_caret = "❯",

                path_display = { "smart" },     --"truncate"

                sorting_strategy = "ascending", --上升

                layout_config =
                {
                    horizontal = { prompt_position = "top", preview_width = 0.55 },
                    vertical = { mirror = false },
                    width = 0.87,
                    height = 0.80,
                    preview_cutoff = 120,
                },

                mappings =
                {
                    i =
                    {
                        ["<C-n>"] = actions.cycle_history_next,
                        ["<C-p>"] = actions.cycle_history_prev,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                    },
                    n = { q = actions.close },
                },
            }
        }
    end,

    config = function(plugin, opts)
        local telescope = require "telescope"
        telescope.setup(opts)

        local conditional_func = function(condition, func, ...)
            if condition and type(func) == "function"
            then
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
    end
}
