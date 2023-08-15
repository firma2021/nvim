local function config_diagnostics()
	local diagnostics =
	{
		virtual_text =	--在诊断范围旁边显示虚拟文本
		{
			spacing = 4,
			source = "if_many",
			prefix = "●", -- "icons" if neovim version >= 0.10.0
        },

        severity_sort = true,   --按照严重程度排序

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
end

return config_diagnostics
