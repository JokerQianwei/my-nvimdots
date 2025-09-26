local bind = require("keymap.bind")
local map_cmd = bind.map_cmd

return {
	-- 普通模式：; 移到行尾
	["n|;"] = map_cmd("$"):with_silent():with_noremap():with_desc("cursor: Move to end of line"),
	-- 普通模式：s 移到第一个非空白字符
	["n|s"] = map_cmd("^"):with_silent():with_noremap():with_desc("cursor: Move to first non-blank"),

	-- 插入模式：在 ")" 前按冒号会先越过括号再输入冒号
	["i|:"] = map_cmd("v:lua._smart_colon()")
		:with_expr()
		:with_silent()
		:with_noremap()
		:with_desc("insert: Smart ':' skip )"),
}
