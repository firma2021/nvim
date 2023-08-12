local M = {}

M.widget =
{
	Calendar = "",
	Watch = "󰥔",
}

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

return M
