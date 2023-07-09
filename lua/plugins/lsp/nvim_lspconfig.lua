--neovim LSP客户端的配置文件

return
{
  "neovim/nvim-lspconfig",

  event = { "BufReadPre", "BufNewFile" },

  keys =
  {
    {"<leader>li", "<cmd>LspInfo<cr>", desc = "LSP information"},
  },

  dependencies =
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },

  config = function(plugin, opts)
    local lspconfig = require('lspconfig')

    lspconfig.clangd.setup
    {
      filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },

      cmd =
      {
          "clangd", --clangd --help-hidden
          "--query-driver=/usr/bin/**/clang-*,/usr/bin/gcc,/usr/bin/g++",
          "--background-index",
          "--background-index-priority=background",
          "--all-scopes-completion",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--header-insertion=iwyu",
          "--header-insertion-decorators",
          "--all-scopes-completion",
          "-j=8",
          "--pch-storage=memory",

          "--log=info",
          "--offset-encoding=utf-8",
          "--pretty",

          "--clang-tidy",

          "--enable-config",
      }
    }

    lspconfig.lua_ls.setup
    {
        settings =
        {
            Lua =
            {
                diagnostics =
                {
                    globals = { "vim" } --使语言服务器识别 vim global
                },
                workspace =
                {
                    library = vim.api.nvim_get_runtime_file("", true), --让语言服务器发现Neovim运行时文件
                },
            }
        }
    }

    --texthl ：标志文本的高亮组
    --numhl ：标志行号的高亮组
    vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError", numhl = "" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn", numhl = "" })
    vim.fn.sign_define("DiagnosticSignHint", { text = " ", texthl = "DiagnosticSignHint", numhl = "" })
    vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo", numhl = "" })

    vim.fn.sign_define("DapStopped", { text = "󰁕 ", texthl = "DiagnosticWarn", numhl = "" })
    vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DiagnosticInfo", numhl = "" })
    vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "DiagnosticError", numhl = "" })
    vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "DiagnosticInfo", numhl = "" })
    vim.fn.sign_define("DapLogPoint", { text = ".>", texthl = "DiagnosticInfo", numhl = "" })

    local diagnostics_on =
    {
      virtual_text = true,  --在诊断范围旁边显示虚拟文本
      severity_sort = true, --按照严重程度排序
      signs = { active = signs }, --左侧显示诊断标志
      update_in_insert = true,
      underline = true, --在诊断范围下方显示下划线
      float =
      {
        focused = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    }

    local text_off = extend_tbl(default_diagnostics, { virtual_text = false })
    local text_and_sign_off = extend_tbl(diagnostics_on, { virtual_text = false, signs = false })
    local diagnostics_off = extend_tbl(diagnostics_on,{ underline = false, update_in_insert = false, virtual_text = false, signs = false, })

    vim.g.diagnostics_mode = 1

    local function toggle_diagnostics()
      vim.g.diagnostics_mode = (vim.g.diagnostics_mode + 1) % 4
      if vim.g.diagnostics_mode == 4
      then
        vim.g.diagnostics_mode = 1
      end

      if vim.g.diagnostics_mode == 1 then
        vim.diagnostic.config(diagnostics_on)
        vim.notify("enable all diagnostics", "info", {title = "LSP diagnostics"})
      elseif vim.g.diagnostics_mode == 2 then
        vim.diagnostic.config(text_off)
        vim.notify("text off", "info", {title = "LSP diagnostics"})
      elseif vim.g.diagnostics_mode == 3 then
        vim.diagnostic.config(text_and_sign_off)
        vim.notify("text and sign off", "info", {title = "LSP diagnostics"})
      else
        vim.diagnostic.config(diagnostics_off)
        vim.notify("disable all diagnostics", {title = "LSP diagnostics"})
      end
    end


    vim.keymap.set("n", "<leader>ud", toggle_diagnostics, {desc = "toggle diagnostics"})

    vim.g.lsp_handlers_enabled = true

    if vim.g.lsp_handlers_enabled then
      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded", silent = true }) --设置悬停窗口的边框
      vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded", silent = true }) ----设置函数参数提示窗口的边框
    end

    local on_attach =
    function(client, bufnr)
      --:help vim.diagnostic.*
      vim.keymap.set("n", "gl", vim.diagnostic.open_float(), { noremap = true, silent = true, desc = "hover diagnostics" }) --将光标定位到出错处后，按下此快捷键，在浮动窗口中显示错误信息
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev(), { noremap = true, silent = true, desc = "previous diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next(), { noremap = true, silent = true, desc = "next diagnostic" })
      vim.keymap.set("n", "<leader>ld", vim.diagnostic.setloclist(), { noremap = true, silent = true, desc = "list diagnostics" }) --在列表中显示所有错误信息

      if client.supports_method("textDocument/codeAction") then
        vim.keymap.set({"n", "v"}, "<leader>la", vim.lsp.buf.code_action(), { noremap = true, silent = true, desc = "LSP code action" })
      end

    end


    vim.api.nvim_create_autocmd( --当LSP服务器连接到当前缓冲区后，执行自动命令
      'LspAttach',               --触发自动命令的事件
      {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'       -- <c-x><c-o>出发补全
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts) -- 详见:help vim.lsp.*
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
          vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
          vim.keymap.set('n', '<space>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, opts)
          vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<space>f', function()
            vim.lsp.buf.format { async = true }
          end, opts)
        end,
      }
    )




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

vim.api.nvim_create_autocmd("BufWritePre",
  {
    callback = function() format() end
  }
)

  end,
}
