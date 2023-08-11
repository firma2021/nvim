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

M.lang =
{
	default_icon = {
    icon = "󰈚",
    name = "Default",
  },

  c = {
    icon = "",
    name = "c",
  },

  css = {
    icon = "",
    name = "css",
  },

  dart = {
    icon = "",
    name = "dart",
  },

  deb = {
    icon = "",
    name = "deb",
  },

  Dockerfile = {
    icon = "",
    name = "Dockerfile",
  },

  html = {
    icon = "",
    name = "html",
  },

  jpeg = {
    icon = "󰉏",
    name = "jpeg",
  },

  jpg = {
    icon = "󰉏",
    name = "jpg",
  },

  js = {
    icon = "󰌞",
    name = "js",
  },

  kt = {
    icon = "󱈙",
    name = "kt",
  },

  lock = {
    icon = "󰌾",
    name = "lock",
  },

  lua = {
    icon = "",
    name = "lua",
  },

  mp3 = {
    icon = "󰎆",
    name = "mp3",
  },

  mp4 = {
    icon = "",
    name = "mp4",
  },

  out = {
    icon = "",
    name = "out",
  },

  png = {
    icon = "󰉏",
    name = "png",
  },

  py = {
    icon = "",
    name = "py",
  },

  ["robots.txt"] = {
    icon = "󰚩",
    name = "robots",
  },

  toml = {
    icon = "",
    name = "toml",
  },

  ts = {
    icon = "󰛦",
    name = "ts",
  },

  ttf = {
    icon = "",
    name = "TrueTypeFont",
  },

  rb = {
    icon = "",
    name = "rb",
  },

  rpm = {
    icon = "",
    name = "rpm",
  },

  vue = {
    icon = "󰡄",
    name = "vue",
  },

  woff = {
    icon = "",
    name = "WebOpenFontFormat",
  },

  woff2 = {
    icon = "",
    name = "WebOpenFontFormat2",
  },

  xz = {
    icon = "",
    name = "xz",
  },

  zip = {
    icon = "",
    name = "zip",
  },
}

return M
