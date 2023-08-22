local M = {}

M.kind =
{
    Class = "󰠱",
	Color = "󰏘",
    Constant = "󰏿",
    Constructor = "",

	Enum = "",
    EnumMember = "",
    Event = "",

    Field = "󰜢",
    File = "󰈚",
    Folder = "󰉋",
	Fragment = "",
    Function = "󰆧",

    Interface = "",
    Implementation = "",

    Keyword = "󰌋",

    Method = "󰆧",
    Module = "",
	Namespace = "󰌗",
    Number = "",

    Operator = "󰆕",

    Package = "",
    Property = "󰜢",

    Reference = "",

    Snippet = "",
    Struct = "",

	Text = "󰉿",
	Table = "",
    Tag = "",
	TypeParameter = "󰊄",

    Unit = "󰑭",

	Value = "󰎠",
	Variable = "󰀫",

    Object = "󰅩",
	String = "󰉿",
	Array = "[]",
	Boolean = "",
	Null = "󰟢",
}

M.cmp_source =
{
    nvim_lua = "",
	nvim_lsp = "",
	treesitter = "",
	path = "",
	spell = "󰓆",
	buffer = "",
	zsh = "",
    luasnip = "󰃐",

	Copilot = "",
	copilot = "",
    Codeium = "",
	codeium = "",
    TabNine = "",
	cmp_tabnine = "",
}

M.undefined = ""

M.diagnostics =
{
	Error = " ",
	Warn = " ",
	Hint = " ",
	Info = " ",
}

M.component =
{
    LSP = " ",
	DAP = " ",
}

M.widget =
{
	Calendar = "",
	Watch = " ", -- 󰥔
}

M.git =
{
    branch = "",

	added = " ",
	modified = " ",
    removed = " ",

	unstaged = "✗",
    staged = "✓",

    unmerged = "",

    renamed = "➜",

    untracked = "★",

    deleted = "",

	ignored = "◌",
}

M.file_type =
{
    file_default = "󰈚",
    file_symlink = "",

	folder_default = "",
    open = "",

	empty = "",
	empty_open = "",

	folder_symlink = "",
    symlink_open = "",

	arrow_open = "",
	arrow_closed = "",
}

M.lang=
{
	python = " ",
}

M.file_status =
{
	modified = "[+]",
	readonly = "[ro]",
	unnamed = "[no name]",
	newfile = "[new]",
}

M.dap =
{
	Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
	Breakpoint = " ",
	BreakpointCondition = " ",
	BreakpointRejected = { " ", "DiagnosticError" },
	LogPoint = ".>",
}

M.bookmark = "󰃃"

return M
