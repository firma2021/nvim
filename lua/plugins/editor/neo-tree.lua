-- return
-- {
--     "nvim-neo-tree/neo-tree.nvim",
--     branch = "v3.x",

--     cmd = "Neotree",

--     dependencies =
--     {
--         "nvim-lua/plenary.nvim",
--         "nvim-tree/nvim-web-devicons",
--         "MunifTanjim/nui.nvim",
--     },

--     init = function()
--         vim.g.neo_tree_remove_legacy_commands = 1 --移除旧版neo-tree中废弃的命令
--         if vim.fn.argc() == 1
--         then                                      --如果用neovim打开一个目录，则加载neo-tree
--             local stat = vim.loop.fs_stat(vim.fn.argv(0))
--             if stat and stat.type == "directory" then
--                 require("neo-tree")
--             end
--         end
--     end,

--     keys =
--     {

--         { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
--         {
--             "<leader>o",
--             function()
--                 if vim.bo.filetype == "neo-tree"
--                 then
--                     vim.cmd.wincmd "p"      --将光标焦点切换到上一个窗口
--                 else
--                     vim.cmd.Neotree "focus" --将光标焦点切换到NeoTree浏览器窗口
--                 end
--             end,
--             desc = "Toggle Explorer Focus",
--         },
--     },

--     opts =
--     {
--         close_if_last_window = true,                                              --如果neo-tree是选项卡中剩下的最后一个窗口，关闭它
--         popup_border_style = "rounded",

--         enable_git_status = true,

--         sources = { "filesystem", "buffers", "git_status", "document_symbols", }, --树状结构源

--         source_selector =
--         {
--             winbar = true, --显示win bar
--             content_layout = "center",
--             sources =
--             {
--                 { source = "filesystem",  display_name = "" .. "File" },
--                 { source = "buffers",     display_name = "󰈙" .. "Bufs" },
--                 { source = "git_status",  display_name = "󰊢" .. "Git" },
--                 { source = "diagnostics", display_name = "󰒡" .. "Diagnostic" },
--             },
--         },

--         default_component_configs =
--         {
--             indent =
--             {
--                 padding = 0,
--                 with_expanders = true,
--                 expander_collapsed = "",
--                 expander_expanded = "",
--                 expander_highlight = "NeoTreeExpander",
--             },
--             icon =
--             {
--                 folder_closed = "",
--                 folder_open = "",
--                 folder_empty = "",
--                 folder_empty_open = "",
--                 default = "󰈙",
--             },
--             modified = { symbol = "" },
--             git_status =
--             {
--                 symbols =
--                 {
--                     added = "",
--                     deleted = "",
--                     modified = "",
--                     renamed = "➜",
--                     untracked = "★",
--                     ignored = "◌",
--                     unstaged = "✗",
--                     staged = "✓",
--                     conflict = "",
--                 },
--             },
--         },

--         open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },

--         filesystem =
--         {
--             bind_to_cwd = false,                    --在vim的cwd和neo-tree的root之间创建双向绑定
--             follow_current_file = true,             --找到并聚焦活动缓冲区中的文件
--             use_libuv_file_watcher = true,          --使用操作系统级文件查看器检测文件更改，而不是nvim事件
--             hijack_netrw_behavior = "open_current", --禁用netrw插件，提供与netrw类似的功能
--         },

--         event_handlers =
--         {
--             {
--                 event = "neo_tree_buffer_enter",                             --进入neovim缓冲区时
--                 handler = function(_) vim.opt_local.signcolumn = "auto" end, --根据需要自动显示或隐藏行号列。如果当前缓冲区中存在标记（例如断点或错误标记），则会显示行号列
--             },
--         },

--         commands = --函数列表，每个函数表示一个全局的自定义命令
--         {
--             --在操作系统中打开文件或文件夹：
--             --根据当前操作系统和可执行文件的可用性，来确定使用哪个命令来打开文件或文件夹
--             --启动一个后台任务，使用相应的命令来打开文件或文件夹；命令的参数是当前树节点的ID或当前文件的路径
--             system_open = function(state)
--                 local cmd
--                 if vim.fn.has "win32" == 1 and vim.fn.executable "explorer" == 1
--                 then
--                     cmd = { "cmd.exe", "/K", "explorer" }
--                 elseif vim.fn.has "unix" == 1 and vim.fn.executable "xdg-open" == 1
--                 then
--                     cmd = { "xdg-open" }
--                 elseif (vim.fn.has "mac" == 1 or vim.fn.has "unix" == 1) and vim.fn.executable "open" == 1
--                 then
--                     cmd = { "open" }
--                 end

--                 if not cmd
--                 then
--                     vim.notify("Available system file opening tool not found!")
--                 end

--                 vim.fn.jobstart(vim.fn.extend(cmd, { state.tree:get_node():get_id() or vim.fn.expand "<cfile>" }),
--                     { detach = true })
--             end,

--             --在树状目录中收起展开的节点，或聚焦到父节点：
--             --获取当前节点的引用
--             --判断当前节点的类型是否为目录或者该节点是否有子节点，并且展开
--             --是，切换节点的展开状态
--             --否，将焦点聚焦到当前节点的父节点
--             parent_or_close = function(state)
--                 local node = state.tree:get_node()
--                 if (node.type == "directory" or node:has_children()) and node:is_expanded()
--                 then
--                     state.commands.toggle_node(state)
--                 else
--                     require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
--                 end
--             end,

--             --在树状目录中展开节点，或选择下一个子节点
--             child_or_open = function(state)
--                 local node = state.tree:get_node()
--                 if node.type == "directory" or node:has_children()
--                 then
--                     if not node:is_expanded() --如果未展开，则展开
--                     then
--                         state.commands.toggle_node(state)
--                     else --如果展开并有子项，选择下一个子项
--                         require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1])
--                     end
--                 else --如果不是目录，则打开它
--                     state.commands.open(state)
--                 end
--             end,

--             --用户选择当前节点的某个信息，复制到剪贴板
--             copy_selector = function(state)
--                 local node = state.tree:get_node()
--                 local filepath = node:get_id()
--                 local filename = node.name
--                 local modify = vim.fn.fnamemodify

--                 local results =
--                 {
--                     e = { val = modify(filename, ":e"), msg = "Extension only" },
--                     f = { val = filename, msg = "Filename" },
--                     F = { val = modify(filename, ":r"), msg = "Filename w/o extension" },
--                     h = { val = modify(filepath, ":~"), msg = "Path relative to Home" },
--                     p = { val = modify(filepath, ":."), msg = "Path relative to CWD" },
--                     P = { val = filepath, msg = "Absolute path" },
--                 }

--                 local messages =
--                 {
--                     { "\nChoose to copy to clipboard:\n", "Normal" },
--                 }

--                 for i, result in pairs(results)
--                 do
--                     if result.val and result.val ~= "" then
--                         vim.list_extend(messages, {
--                             { ("%s."):format(i),           "Identifier" },
--                             { (" %s: "):format(result.msg) },
--                             { result.val,                  "String" },
--                             { "\n" },
--                         })
--                     end
--                 end

--                 vim.api.nvim_echo(messages, false, {})
--                 local result = results[vim.fn.getcharstr()] --通过vim.fn.getcharstr()获取用户选择的选项
--                 if result and result.val and result.val ~= ""
--                 then
--                     vim.notify("Copied: " .. result.val)
--                     vim.fn.setreg("+", result.val)
--                 end
--             end,
--         },

--         window =
--         {
--             width = 30,
--             mapping_options =
--             {
--                 noremap = true,
--                 nowait = true,
--             },
--             mappings =
--             {
--                 ["[b"] = "prev_source",
--                 ["]b"] = "next_source",
--                 o = "open",
--                 O = "system_open",
--                 h = "parent_or_close",
--                 l = "child_or_open",
--                 Y = "copy_selector",

--                 ["?"] = "show_help",
--             },
--         },
--     },

--     config = function(_, opts)
--         require("neo-tree").setup(opts)
--         vim.api.nvim_create_autocmd("TermClose", --关闭lazygit终端时，刷新 Neo Tree 插件中的 Git 状态。
--             {
--                 pattern = "*lazygit",
--                 callback = function()
--                     if package.loaded["neo-tree.sources.git_status"] then
--                         require("neo-tree.sources.git_status").refresh()
--                     end
--                 end,
--             }
--         )
--     end,
-- }


-- glyphs = {
--         default = "󰈚",
--         symlink = "",
--         folder = {
--           default = "",
--           empty = "",
--           empty_open = "",
--           open = "",
--           symlink = "",
--           symlink_open = "",
--           arrow_open = "",
--           arrow_closed = "",
--         },
--         git = {
--           unstaged = "✗",
--           staged = "✓",
--           unmerged = "",
--           renamed = "➜",
--           untracked = "★",
--           deleted = "",
--           ignored = "◌",
--         },
return {}
