local bind = require("keymap.bind")
local map_cmd = bind.map_cmd

return {
	-- 禁用方向键，强制使用 hjkl
	["nvi|<Up>"] = map_cmd("<Nop>"):with_noremap():with_silent():with_desc("cursor: Disable Up arrow"),
	["nvi|<Down>"] = map_cmd("<Nop>"):with_noremap():with_silent():with_desc("cursor: Disable Down arrow"),
	["nvi|<Left>"] = map_cmd("<Nop>"):with_noremap():with_silent():with_desc("cursor: Disable Left arrow"),
	["nvi|<Right>"] = map_cmd("<Nop>"):with_noremap():with_silent():with_desc("cursor: Disable Right arrow"),
}
