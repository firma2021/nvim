--将Neovim作为语言服务器使用，以注入LSP诊断、代码建议。
return
{
    "jose-elias-alvarez/null-ls.nvim",

    event = { "BufReadPre", "BufNewFile" },

    dependencies = { "mason.nvim" },

    config = function()
        local null_ls = require("null-ls")

        null_ls.setup(
            {
                debug = false, --禁用debug模式

                sources =
                {
                    null_ls.builtins.formatting.shfmt,        --shell
                    null_ls.builtins.formatting.stylua,       --lua
                    null_ls.builtins.formatting.clang_format, --c/c++
                    null_ls.builtins.formatting.black.with({ extra_args = { "--fast" } }),
                    null_ls.builtins.completion.spell,

                    null_ls.builtins.code_actions.gitsigns,

                    null_ls.builtins.diagnostics.clang_check,
                    null_ls.builtins.diagnostics.shellcheck,
                    null_ls.builtins.diagnostics.flake8,
                },

                diagnostics_format = "[#{s}] #{m}",

                on_attach = function(_)
                    vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting_sync']]) --创建一个名为"Format"的命令，执行LSP format
                    -- if client.resolved_capabilities.document_formatting then
                    --   vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
                    -- end
                end,
            }
        )
    end,
}
