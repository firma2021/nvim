local auto_format = true

local function toggle_auto_format()
    auto_format = not auto_format
    if auto_format then
        vim.notify("enabled format on save", "info", {title = "format"})
    else
        vim.notify("disabled format on save", "warn", {title = "format"})
    end
end

--判断LSP客户端是否支持格式化代码。
--如果LSP客户端支持格式化代码，但其配置文件中禁用了格式化功能，也返回false
local function is_lsp_client_support_format(lsp_client)
    if
        lsp_client.config and lsp_client.config.capabilities and lsp_client.config.capabilities.documentFormattingProvider == false
    then
        return false
    end

    return lsp_client.supports_method("textDocument/formatting") or lsp_client.supports_method("textDocument/rangeFormatting")
end

--获取当前缓冲区上，所有支持格式化的LSP客户端
local function get_formatters(buffer_number)
    local file_type = vim.bo[buffer_number].file_type
    local lsp_clients = vim.lsp.get_active_clients({ bufnr = buffer_number })

    local null_ls = package.loaded["null-ls"] and
        require("null-ls.sources").get_available(file_type, "NULL_LS_FORMATTING") or
        {}


    local ret =
    {
        support = {}, --支持格式化的活动LSP客户端
        not_support = {}, --不支持格式化的活动LSP客户端
        null_ls = null_ls,
    }

    for index, lsp_client in ipairs(lsp_clients)
    do
        if is_lsp_client_formatting_supported(lsp_client)
        then
            if lsp_client.name ~= "null-ls"
            then
                table.insert(support, lsp_client)
            end
        else
            table.insert(ret.not_support, lsp_client)
        end
    end

    return ret
end

local function notify(formatters)
    local msg = { "available LSP client:" }

    for index, client in ipairs(formatters.support) do
        table.insert(msg, "  " .. client.name)
    end

    table.insert(msg, "")
    table.insert(msg, "LSP client that does not support formatting: ")

    for index, client in ipairs(formatters.not_support) do
        table.insert(msg, "  " .. client.name)
    end

    vim.notify(table.concat(msg, "\n"), "info", {title = "Formatting"})
end

function format()
    if vim.b.autoformat == false then return end

    local buf_num = vim.api.nvim_get_current_buf() --获取当前缓冲区的编号
    local formatters = get_formatters(buf_num)

    local client_ids = vim.tbl_map(function(client) return client.id end, formatters.support) --vim.tbl_map将一个函数应用于表中的每个元素，返回一个新表


    local ftable =
    {
        bufnr = buf_num,
        filter = function(client)
            return vim.tbl_contains(client_ids, client.id)
        end,
        formatting_options = nil,
        timeout_ms = nil,
    }

    vim.lsp.buf.format(ftable)
end
