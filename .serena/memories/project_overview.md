# 项目概览
- 这是基于 ayamir/nvimdots 的跨平台 Neovim 配置，入口在 `init.lua`，在非 VSCode 环境加载 `core` 模块。
- 配置采用 modular 结构，`lua/core` 负责基础设置（目录创建、选项、事件、插件加载器 lazy.nvim、默认主题等），`lua/modules` 下拆分插件声明 (`modules/plugins`) 和插件配置 (`modules/configs`)，`lua/keymap` 统一管理快捷键。
- 通过 `core/settings.lua` 暴露大量可选项（格式化策略、诊断展示、颜色方案、GUI/Neovide/AI Chat 等），`modules.utils.extend_config` 支持用户在 `lua/user` 下覆盖。
- 项目附带 `nixos/` flake，提供 NixOS / home-manager 支持；`scripts/install.{sh,ps1}` 用于一键安装符号链接；`snips` 存放 luasnip 片段，`tutor` 为教学资源。