--neovim LSP客户端的配置文件

return
{
  "neovim/nvim-lspconfig",

  event = { "BufReadPre", "BufNewFile" },

  dependencies =
  {
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },

  -- opts =
  -- {
  --   diagnostics = --vim.diagnostic.config()的参数
  --   {
  --     underline = true,
  --     update_in_insert = false,
  --     virtual_text =
  --     {
  --       spacing = 4,
  --       source = "if_many",
  --       prefix = "●",
  --     },
  --     severity_sort = true,
  --   },

  -- config = function(plugin, opts)
  --   --创建自动命令组
  --   vim.api.nvim_create_autocmd(
  --     "BufWritePre",
  --     {
  --       group = vim.api.nvim_create_augroup("LanguageFormat", {}),
  --       callback = function() end,
  --     }
  --   )
  --   vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
  --   vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
  --   vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
  --   vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)


  --   -- Use LspAttach autocommand to only map the following keys
  --   -- after the language server attaches to the current buffer
  --   vim.api.nvim_create_autocmd(
  --     'LspAttach',
  --   {
  --     group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  --     callback = function(ev)

  --       vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc' -- Enable completion triggered by <c-x><c-o>

  --       -- Buffer local mappings.See `:help vim.lsp.*` for documentation on any of the below functions
  --       local opts = { buffer = ev.buf }
  --       vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
  --       vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  --       vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  --       vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
  --       vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
  --       vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
  --       vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
  --       vim.keymap.set('n', '<space>wl', function()
  --         print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  --       end, opts)
  --       vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
  --       vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
  --       vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
  --       vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  --       vim.keymap.set('n', '<space>f', function()
  --         vim.lsp.buf.format { async = true }
  --       end, opts)
  --     end,
  --   }
  -- )

  --   local lspconfig = require('lspconfig')
  --   lspconfig.

  --   local diagnostic_signs =
  --   {
  --     DiagnosticSignError = " ",
  --     DiagnosticSignWarn = " ",
  --     DiagnosticSignHint = " ",
  --     DiagnosticSignInfo = " ",
  --   }
  --   for name, icon in pairs(diagnostic_signs)
  --   do
  --     vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
  --   end

  -- end,
}
