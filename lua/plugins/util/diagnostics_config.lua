local function config_diagnostics()
    local diagnostics =
    {
        virtual_text = --在诊断范围旁边显示虚拟文本
        {
            spacing = 4,
            source = "if_many",
            prefix = vim.fn.has("nvim-0.10.0") == 0 and "●" or
			function(diagnostic)
                local icons = require("plugins.util.icons").diagnostics
                for d, icon in pairs(icons) do
                    if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                        return icon
                    end
                end
            end,
        },

        severity_sort = true,         --按照严重程度排序

        signs = { active = "signs" }, --左侧显示诊断标志

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

    vim.diagnostic.config(diagnostics)

    if vim.fn.has("nvim-0.10.0") ~= 0 then
    	vim.api.nvim_create_autocmd("LspAttach",
		{
			callback = function(args)
				local buffer = args.buf
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint
				if client.supports_method('textDocument/inlayHint') then
					inlay_hint(buffer, true)
				end
			end,
		}
	)
    end

end

return config_diagnostics
