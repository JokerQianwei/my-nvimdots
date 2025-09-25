# 任务完成检查单
- 修改 Lua 后运行 `stylua --check .` 或 `stylua .` 保证风格一致。
- 启动 `nvim` 检查无启动报错、确认相关插件正确加载（可用 `:Lazy` 查看状态）。
- 如新增或移除插件，确保 `lazy-lock.json` 根据需要更新。
- 与 LSP/格式化相关改动，进入对应文件类型执行保存测试自动格式化和诊断展示。
- 若改动 Nix 集成，使用 `nix flake check` 或重新进入 `nix develop` 验证环境能成功构建。