# 常用命令
- `nvim`：在当前仓库直接启动配置验证加载效果；若使用 Nix flake，则通过 `nix develop` 进入 devshell 后执行。
- `:Lazy sync` / `:Lazy update` / `:Lazy clean`：Neovim 内管理插件同步、更新与清理。
- `:Mason`：图形化检查 LSP/Formatter/DAP 的安装状态。
- `stylua .`：在仓库根目录格式化 Lua 代码；提交前可用 `stylua --check .` 做静态检查。
- `nix develop`：进入 flake 提供的开发环境，自动创建 `~/.config/nvimdots` 符号链接与依赖。
- `scripts/install.sh`（或 Windows 下的 `scripts/install.ps1`）：将配置引导安装到 `$XDG_CONFIG_HOME/nvim` 或 `nvimdots`。