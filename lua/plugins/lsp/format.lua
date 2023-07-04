return {}

--判断LSP客户端是否支持格式化代码。
--如果LSP客户端支持格式化代码，但其配置文件中禁用了格式化功能，也返回false
-- local function is_lsp_client_formatting_supported(lsp_client)
--     if
--         lsp_client.config and lsp_client.config.capabilities and lsp_client.config.capabilities.documentFormattingProvider == false
--     then
--         return false
--     end

--     if
--         lsp_client.supports_method("textDocument/formatting") or lsp_client.supports_method("textDocument/rangeFormatting")
--     then
--         return true
--     else
--         return false
--     end
-- end

-- --获取当前缓冲区上，支持格式化的LSP客户端
-- function get_formatters(buffer_number)
--     local file_type = vim.bo[buffer_number].file_type
--     local lsp_clients = vim.lsp.get_active_clients({ bufnr = buffer_number })

--     local null_ls = package.loaded["null-ls"] and
--         require("null-ls.sources").get_available(file_type, "NULL_LS_FORMATTING") or
--         {}


--     local ret =
--     {
--         active = {},
--         available = {},
--         inactive = {},
--         null_ls = null_ls,
--     }

--     for index, lsp_client in ipairs(lsp_clients)
--     do
--         if is_lsp_client_formatting_supported(lsp_client)
--         then
--             if (#null_ls > 0 and lsp_client.name == "null-ls") or #null_ls == 0 --#用于获取数组长度
--             then
--                 table.insert(ret.active, lsp_client)
--             else
--                 table.insert(ret.available, lsp_client)
--             end
--         else
--             table.insert(ret.inactive, lsp_client)
--         end
--     end

--     return ret
-- end

-- function notify(formatters)
--     local lines = { "# Active:" }

--     for index, client in ipairs(formatters.active) do
--         local line = "- **" .. client.name .. "**"
--         if client.name == "null-ls" then
--             line = line .. " (" .. table.concat(vim.tbl_map(function(f)
--                 return "`" .. f.name .. "`"
--             end, formatters.null_ls), ", ") .. ")"
--         end
--         table.insert(lines, line)
--     end

--     if #formatters.available > 0 then
--         table.insert(lines, "")
--         table.insert(lines, "# Disabled:")
--         for _, client in ipairs(formatters.available) do
--             table.insert(lines, "- **" .. client.name .. "**")
--         end
--     end

--     local notify = require("notify")
--     notify(
--         table.concat(lines, "\n"),
--         vim.log.levels.INFO,
--         {
--             title = "Formatting",
--             on_open = function(win)
--                 vim.api.nvim_win_set_option(win, "conceallevel", 3)
--                 vim.api.nvim_win_set_option(win, "spell", false)
--                 local buf = vim.api.nvim_win_get_buf(win)
--                 vim.treesitter.start(buf, "markdown")
--             end,
--         }
--     )
-- end

-- function format()
--     local buf_num = vim.api.nvim_get_current_buf() --获取当前缓冲区的编号

--     if vim.b.autoformat == false
--     then
--         return
--     end

--     local formatters = get_formatters(buf_num)
--     local client_ids = vim.tbl_map(function(client) return client.id end, formatters.active) --vim.tbl_map将一个函数应用于表中的每个元素，返回一个新表

--     if #client_ids == 0
--     then
--         notify(formatters)
--         return
--     else
--         notify(formatters)
--     end

--     local ftable =
--     {
--         bufnr = buf_num,
--         filter = function(client)
--             return vim.tbl_contains(client_ids, client.id)
--         end,
--         formatting_options = nil,
--         timeout_ms = nil,
--     }

--     vim.lsp.buf.format(ftable)
-- end
