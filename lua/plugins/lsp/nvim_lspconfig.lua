--neovim LSP客户端的配置文件

return
{
  "neovim/nvim-lspconfig",

  event = { "BufReadPre", "BufNewFile" },

  dependencies =
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },

  config = function(plugin, opts)
    local lspconfig = require('lspconfig')

    --clangd --help-hidden
    lspconfig.clangd.setup
    {
      filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },

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

    vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError", numhl = "" })
    vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn", numhl = "" })
    vim.fn.sign_define("DiagnosticSignHint", { text = " ", texthl = "DiagnosticSignHint", numhl = "" })
    vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo", numhl = "" })

    vim.diagnostic.config(
      {
        virtual_text = true,  --类似于vscode的error len插件，在出错行后面显示错误信息
        severity_sort = true, --按照严重程度排序
        signs = true,
        update_in_insert = true,
        underline = false,
        float =
        {
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      }
    )

    local opts = { noremap = true, silent = true }                   --禁用递归映射，不输出信息
    -- 全局键位映射。详见:help vim.diagnostic.*
    vim.keymap.set('n', '<space>E', vim.diagnostic.open_float, opts) --将光标定位到出错处后，按下此快捷键，在浮动窗口中显示错误信息
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts) --在列表中显示所有错误信息



    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })                  --设置鼠标悬停窗口的边框
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }) --设置函数参数提示窗口的边框


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
  end,
}
