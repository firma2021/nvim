return function (other_opts)
	require("lspconfig").clangd.setup(
	{
		on_attach = other_opts.on_attach,
		capabilities = vim.tbl_deep_extend("keep", { offsetEncoding = { "utf-16", "utf-8" } }, other_opts.capabilities), -- keep：保留目标表中已存在的键值对

        single_file_support = true,

		filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },

		-- see clangd --help-hidden
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

            "-j=12",

			"--pch-storage=memory",

			"--pretty",

			"--clang-tidy",

			"--enable-config",
		},
	}
	)
end
