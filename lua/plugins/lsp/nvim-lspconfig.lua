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

    --texthl ：标志文本的高亮组; numhl ：标志行号的高亮组
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

    vim.diagnostic.config(diagnostics_on)

    -- see :help vim.lsp.*
    --see :help vim.diagnostic.*

    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = "goto previous diagnostic" })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "goto next diagnostic" })
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, { noremap = true, silent = true, desc = "open floating diagnostic message" }) --将光标定位到出错处后，按下此快捷键，在浮动窗口中显示错误信息
    vim.keymap.set("n", "<leader>ld", vim.diagnostic.setloclist, { noremap = true, silent = true, desc = "open diagnostics list" }) --在列表中显示所有错误信息

  end
}
