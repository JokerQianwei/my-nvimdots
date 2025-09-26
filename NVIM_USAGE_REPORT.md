# nvimdots 配置使用报告

> 本指南基于当前仓库的 nvimdots 配置（入口 `init.lua`），按“先开箱、后进阶、自定义最后”的节奏帮助你掌握主要特性与快捷键。

- github 链接： `https://github.com/ayamir/nvimdots?tab=readme-ov-file`
- 按下<leader>ps, 同步所有插件
- 插件的安装路径： `~/.local/share/nvim/site/lazy`
- 配置文件路径：`~/.config/nvim`
- 配置自定义映射路径： `/Users/joker/.config/nvim/lua/user/keymap/core.lua`
- 需要把终端字体改为Nerd Font字体

<C-h> 和 <C-l>: 切换窗口
<C-w>v : split 一个垂直窗口
<C-w>s : split 一个水平窗口

<leader>li: check LSP info

go： 打开代码的大纲

- <leader>ff: 搜索文件
  - 然后可以使用 <Tab> 和 <shift + Tab> 在已经打开的标签页中预览
- <leader>fp: 搜索文本 patterns
- <leader>fd: 访问最近的文件列表
- LSP 提示的适合，可以使用 <Tab>, <S-Tab>来导航；<C-w>关闭提示窗口

<C-p> 查看快捷键


## 1. 快速上手

### 1.1 启动与基础概念

- 直接运行 `nvim`，若使用 Nix flake，可在 `nix develop` 环境内启动。
- `<Space>` 是全局 `<leader>` 键；多数插件映射均以 `<leader>` 开头。
- 配置首次启动会自动创建缓存目录（备份、会话、交换文件等）。

### 1.2 插件管理

- 使用 `lazy.nvim`（`lua/keymap/init.lua`）
  - `<leader>ph`：打开 Lazy 面板
  - `<leader>ps` / `<leader>pu` / `<leader>px`：同步、更新、清理插件
- 推荐遇到问题先运行 `:Lazy sync`，查看 `:Lazy log` 获取错误详情。

### 1.3 依赖管理

- `mason.nvim` 负责安装 LSP/格式化/DAP 组件。
  - 运行 `:Mason` 查看依赖状态。
  - `lua/core/settings.lua` 中的 `lsp_deps`、`null_ls_deps`、`dap_deps`、`treesitter_deps` 控制默认安装清单。

## 2. 基础编辑体验

### 2.1 文件与缓冲区

- `NvimTree`
  - `<C-n>`：通过 Edgy 左侧面板开关文件树
  - `<leader>nf` / `<leader>nr`：定位当前文件、刷新树
- 缓冲区 & 标签页（`lua/keymap/ui.lua`）
  - `<A-i>/<A-o>` ：循环切换缓冲区，`<A-S-i>/<A-S-o>` 移动当前缓冲区
  - `<A-1>…<A-9>`：跳转到指定序号缓冲区
  - `tn/tj/tk/to`：新建、切换、关闭标签页

### 2.2 编辑增强

- 常用内置映射（`lua/keymap/editor.lua`）
  - `<C-s>` 保存、`<C-q>` 保存并退出、`<A-S-q>` 强制退出
  - 视觉模式 `J/K` 移动选区行，`<`/`>` 调整缩进
  - `Y/D` 复制/删除到行尾，`n/N` 搜索结果居中定位
  - `<Esc>`：退出高亮或关闭 Flash
- 注释：`gcc` 行注释、`gc` 操作符模式、`gb` 块注释，视觉模式支持 `gc`/`gb`
- 代码块移动/选择：`<leader>w/j/k/c/C` 结合 Hop 快速跳转；`o|m` 使用 Treehopper 选择语法节点
- 会话管理：`<leader>ss/sl/sd` 保存、加载、删除会话（persisted.nvim）

### 2.3 格式化与诊断

- `<A-S-f>`：手动格式化，`<A-f>`：切换保存时自动格式化
- 诊断
  - `g[` / `g]`：跳转诊断
  - `<leader>lx`：显示当前行问题；`<leader>ld/lp/lw` 栈式查看文档或工程诊断（Trouble）
  - `<leader>lv`：切换虚拟诊断行，`<leader>lh`：切换 LSP inlay hints

## 3. 搜索与导航

### 3.1 查找文件与内容

- `search.nvim + telescope/fzf`（`lua/keymap/tool.lua`）
  - `<C-p>`：打开命令面板（或 fzf 键位列表）
  - `<leader>ff`：文件集合、`<leader>fp`：模糊查找模式
  - `<leader>fs`（视觉模式）/`<leader>Sp`：搜索选中文本；`<leader>Sf`：在当前文件替换
  - `<leader>fc`：进入自定义集合（Files/Patterns/Git/Session 等 tab）
  - `<leader>fr`/`<leader>fR`：恢复上一次搜索

### 3.2 结构与大纲

- `dropbar.nvim` 自动显示当前文件上层符<!--  -->��号
- `go` 或 `gto`：工作/浮动符号大纲（Trouble 或 Telescope）
- Treesitter 文本对象：`af/if` 函数、`ac/ic` 类块，配合 `[[`, `]]` 等跳转

## 4. LSP 与补全链路

### 4.1 自动安装与启用

- 首启或运行 `:Lazy sync` 会触发 `mason-lspconfig` 注册 `bashls`, `clangd`, `gopls`, `lua_ls`, `jsonls`, `html` 等常用 LSP。
- 对于未由 Mason 支持的语言，可在 `lua/user/configs/lsp-servers/*.lua` 中注册，系统会通过 `modules.utils.register_server` 启用。

### 4.2 补全体验（`nvim-cmp`）

- Tab 循环候选，`<S-Tab>` 反向；`<CR>` 接受当前项
- 来源标签：`[LSP]`, `[SNIP]`, `[TMUX]`, `[CPLT]` 等
- LuaSnip 已预装，支持 `friendly-snippets`；`snips/snippets` 提供 Go/C/C++ 示例片段

### 4.3 其他 LSP 功能

- `K`：悬浮文档；`ga`：代码操作；`gr/gR`：重命名（文件/工程范围）
- `gd/gD`：定义预览/跳转；`gh/gm`：引用/实现；`gci/gco`：调用关系视图
- `gs`：签名帮助；`NullLsToggle <source>`：切换 none-ls 源

## 5. 终端、调试与工具链

### 5.1 内置终端（toggleterm）

- `<C-\>`：水平终端；`<A-\>` 或 `<F5>`：垂直终端；`<A-t>`：浮动终端
- 终端模式 `<Esc><Esc>` 返回普通模式；`<leader>gg` 打开 LazyGit 浮窗

### 5.2 调试（nvim-dap）

- `<leader>dr/dq/dt`：继续、停止、切换断点
- `<leader>dn/di/du/dc/dl`：单步执行/运行到光标/重跑
- `<leader>dB`：带条件断点；`<leader>do`：打开 REPL
- DAP 会在会话开始时自动打开 DAP UI，并在退出后恢复原布局

### 5.3 搜索替换与快速命令

- `GrugFar`：比原生更安全的项目替换界面；组合键 `<leader>S*` 打开并带预填参数
- `:SudaWrite` (`<A-s>`)：在需要 sudo 权限的文件中保存
- `Diffview`：`<leader>gd/gD` 打开/关闭差异视图

## 6. Git 工作流

- `gitsigns`（缓冲区加载时自动生效）
  - `]g/[g`：跳转 hunk，`<leader>gs/gr/gR`：暂存、重置 hunk/缓冲区
  - `<leader>gp`：预览 hunk，`<leader>gb`：行追责
- Fugitive：`gps/gpl` 快速推拉；`<leader>gG` 打开交互式 Git 面板
- `advanced-git-search.nvim` 集成于 `<leader>fg` 子菜单

## 7. 界面与体验

- 默认主题来自 Catppuccin 分支，可在 `lua/core/settings.lua` 将 `colorscheme` 改为不同风味（latte/mocha/frappe/macchiato）
- 状态栏 `lualine`：自动显示 LSP 进度、Git 状态、诊断；面向透明背景做了颜色处理
- `smart-splits`：`<A-h/j/k/l>` 调整窗口尺寸，`<leader>Wh/Wj/Wk/Wl` 交换窗口
- `indent-blankline`、`paint.nvim`、`todo-comments` 提供缩进线、语义高亮、“TODO” 汇总

## 8. AI 协作

- `CodeCompanion` 默认开启（可在 `settings.use_chat` 置为 `false` 关闭）
  - `<leader>cc`：通过右侧 Edgy 面板打开对话
  - `<leader>cs`：切换模型（Telescope 列表）
  - `<leader>ck>`：打开命令动作菜单，`<leader>ca` 将选区加入对话
- 环境变量：默认读取 `CODE_COMPANION_KEY`，模型列表定义在 `lua/core/settings.lua`。

## 9. 高级定制

1. 复制 `lua/user_template/` 至 `lua/user/`，仅把需要覆盖的文件保持有效。
2. 通过 `modules.utils.extend_config` 与 core 配置合并：
   - `lua/user/settings.lua`：开关功能、覆盖颜色/模型等
   - `lua/user/options.lua`：覆盖 Neovim 原生选项
   - `lua/user/keymap/*.lua`：增删自定义映射
   - `lua/user/plugins/*.lua`：追加/禁用插件
3. 修改完成后运行 `stylua .`、`nvim` 检查是否无错误。

## 10. 故障排查建议

| 场景            | 排查步骤                                                                  |
| --------------- | ------------------------------------------------------------------------- |
| 启动报错        | `:Lazy log` 查看堆栈，必要时 `:Lazy clean` 后重新同步                     |
| 补全/LSP 无响应 | `:LspInfo`/`<leader>lr` 重启；确认 Mason 中对应服务已安装                 |
| 格式化异常      | `<A-f>` 暂停自动格式化，检查 `formatter_block_list` 设置或 `NullLsToggle` |
| 调试 UI 无响应  | `:Mason` 确认 `dap_deps` 安装，`<leader>dq` 结束会话重试                  |
| AI 对话失败     | 确认环境变量 `CODE_COMPANION_KEY`，使用 `<leader>cs` 更换免费模型         |

## 11. 快捷键总览（常用）

| 范畴     | 快捷键                                 | 说明                                         |
| -------- | -------------------------------------- | -------------------------------------------- |
| 插件管理 | `<leader>ph/ps/pu/px`                  | Lazy 面板 / 同步 / 更新 / 清理               |
| 文件树   | `<C-n>` / `<leader>nf` / `<leader>nr`  | 切换 Edgy 左栏 / 定位 / 刷新                 |
| 缓冲区   | `<A-i>/<A-o>`，`<A-1>…<A-9>`           | 下一/上一缓冲区，直接跳转                    |
| 保存退出 | `<C-s>` / `<C-q>` / `<A-S-q>`          | 保存 / 保存退出 / 强制退出                   |
| 搜索     | `<leader>ff/fp/fs`，`<leader>fc`       | 查找文件/模式/选区，打开集合                 |
| 替换     | `<leader>Ss/Sp/Sf`                     | GrugFar 面板 / 项目替换 / 当前文件           |
| LSP      | `gd/gD/gh/gm`，`ga`，`gr/gR`           | 定位/预览/引用/实现，代码操作，重命名        |
| 诊断     | `<leader>ld/lp/lw`，`g[/g]`            | 文档/项目/工作区诊断，前后跳转               |
| 格式化   | `<A-S-f>` / `<A-f>`                    | 手动格式化 / 切换保存时格式化                |
| Git      | `]g/[g`，`<leader>gs/gr/gp/gd`         | 下一/上一 hunk，暂存/重置/预览/打开 diffview |
| 终端     | `<C-\>` / `<A-\>` / `<A-t>`            | 水平 / 垂直 / 浮动终端                       |
| 调试     | `<leader>dr/dq/dt`，`<leader>di/dn/du` | 继续 / 停止 / 断点，步进操作                 |
| 会话     | `<leader>ss/sl/sd`                     | 保存 / 加载 / 删除会话                       |
| AI       | `<leader>cc/cs/ck/ca`                  | 打开对话 / 选模型 / 操作菜单 / 加入选区      |

---

如需更深入的改造，可继续参阅 `lua/modules/configs/` 内各插件的原始配置，以及官方 Wiki 获取最新特性。祝使用愉快！
