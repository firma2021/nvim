local util = require("util") --require了 util/init.lua的返回值

--lazy.nvim能够在加载插件时，设置插件的键位映射。
--如果已经设置了插件的键位映射，则不再重复设置相同的键位映射。

map({"n", "v", "o"}, "H", "^", {desc = "map 'H' to '^'"}) --normal, visual, operator模式下的映射
map({ "n", "v", "o" }, "L", "$", { desc = "map 'L' to '$'" })

map("n", "<leader>us", function() util.toggle("spell") end, {desc = "toggle spell check"})
