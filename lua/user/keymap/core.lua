local bind = require("keymap.bind")
local map_cmd = bind.map_cmd

return {
	-- 普通模式：; 移到行尾
	["n|;"] = map_cmd("$"):with_silent():with_noremap():with_desc("cursor: Move to end of line"),
	-- 普通模式：s 移到第一个非空白字符
	["n|s"] = map_cmd("^"):with_silent():with_noremap():with_desc("cursor: Move to first non-blank"),
}
