return
{
    "nvimdev/guard.nvim",
    event = "VeryLazy",

	config = function ()
		local ft = require("guard.filetype")

        ft("c,cpp"):fmt("clang-format"):lint('clang-tidy')
		ft("python"):fmt("black"):append("isort"):lint("pylint")
		ft("typescript,javascript,typescriptreact"):fmt("prettier")
		ft("lua"):fmt("stylua"):lint("luacheck")
		ft("json"):fmt({cmd = "jq",stdin = true,})
		ft("sh"):fmt("shfmt"):lint("shellcheck")

        require('guard').setup(
		{
			fmt_on_save = true,
			lsp_as_default_formatter = true, -- Use lsp if no formatter was defined for this filetype
        }
	)
	end,
}
