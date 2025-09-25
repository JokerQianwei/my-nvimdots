# 代码风格
- Lua 代码使用 stylua（配置见 `stylua.toml`）：行宽 120、Unix 换行、制表符缩进宽度 4、默认使用双引号、函数调用一律保留括号。
- 项目大量使用模块化 require 约定，插件声明表以仓库名为键（如 `completion["nvimdev/lspsaga.nvim"]`），建议新增条目时遵循该风格并保持键名为字符串常量。
- 键位定义借助 `keymap.bind` 提供的链式 API（`map_cr(...):with_silent():with_desc(...)`），扩展映射时尽量复用这一模式，描述文本使用英文，引入 `user` 覆盖时遵循相同接口。