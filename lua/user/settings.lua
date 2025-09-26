-- Please check `lua/core/settings.lua` to view the full list of configurable settings
local settings = {}

-- Examples
settings["use_ssh"] = false

settings["colorscheme"] = "catppuccin"

-- Neovide: 光标跳转轨迹动画（机控覆盖）
settings["neovide_config"] = {
    -- 朴素/流行：关闭粒子，仅保留轻微平滑拖尾
    cursor_vfx_mode = "",
    cursor_trail_size = 0.4,
    cursor_animation_length = 0.1,
    cursor_antialiasing = true,
    cursor_animate_in_insert_mode = false,
    cursor_animate_command_line = false,
}

return settings
