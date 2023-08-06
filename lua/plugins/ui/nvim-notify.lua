--一个绚丽的，可配置的neovim通知管理器

return
{
	"rcarriga/nvim-notify",

	lazy = true,
	event = "VeryLazy",

	keys =
	{
		{
			"<leader>un",
			function()
				require("notify").dismiss({ silent = true, pending = true })
			end,
			desc = "dismiss all notifications",
		},
		{
			"<leader>uh",
			"<cmd>Notifications<cr>",
			desc = "notifications history",
		},
	},

	opts =
	{
		timeout = 8000,

		stages = "static", -- 使用最朴素的特效。其它可选项为 "fade", "slide", "fade_in_slide_out", "static"
		fps = 1,

		render = "default", --显示时间和消息发出者，占用的空间较大

		level = "TRACE", -- ERROR > WARN > INFO > DEBUG > TRACE

		on_open = function(win)
			vim.api.nvim_set_option_value("winblend", 0, { scope = "local", win = win }) -- 设置窗口的透明度为全不透明
			vim.api.nvim_win_set_config(win, { zindex = 90 })                   --把窗口的堆叠顺序设置为最前面，覆盖其他窗口
		end,
		on_close = nil,

		max_height = function()
			return math.floor(vim.o.lines * 0.75)
		end,
		max_width = function()
			return math.floor(vim.o.columns * 0.75)
		end,
		minimum_width = 50,
	},

	config = function(plugin, opts)
		local notify = require("notify")
		notify.setup(opts)

		vim.notify = notify

		local fortune = {
			"暮色苍茫看劲松，乱云飞渡仍从容。",
			"天生一个仙人洞，无限风光在险峰。",
			"道路是曲折的，前途是光明的。",
			"坐地日行八万里,巡天遥看一千河。",
			"世上无难事，只要肯登攀。",
			"物质不灭，不过粉碎。",
			[[亲爱的同志，没有一条路无风无浪，
	        会有孤独，会有悲伤，也会有无尽的希望。]],
			"准备好了吗？这一程会短暂而漫长。",
			"去学着他的样子坚定扬起远行的帆。",
			[[历史螺旋上升波浪前进，
	        所以低谷时一定要微笑着信念放心中。]],
			"燃烧自己，耗尽一生，追寻真理",
			"完成比完美更重要。",
			[[朱雀桥边野草花，乌衣巷口夕阳斜。
			旧时王谢堂前燕，飞入寻常百姓家。"]],

		}
		vim.notify(fortune[math.random(1, #fortune)])
	end,
}
