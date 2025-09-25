# Repository Guidelines

## Project Structure & Module Organization
- `init.lua` bootstraps the config; primary code lives under `lua/`.
- Plugins: specs in `lua/modules/plugins/*.lua`; configs in `lua/modules/configs/**`.
- User overrides in `lua/user/**` (use `lua/user_template/**` as a reference).
- Snippets in `snips/`; helper scripts in `scripts/`; Nix modules/devshell in `nixos/` and `flake.nix`.
- Plugin lockfile: `lazy-lock.json` (managed by lazy.nvim).

## Build, Test, and Development Commands
- Run locally: `nvim` (or `nvim -u init.lua`) to load this config.
- Health check: `nvim --headless "+checkhealth" +qa`.
- Plugin ops (lazy.nvim): `:Lazy sync`, `:Lazy update`, `:Lazy clean`; view errors with `:Lazy log`.
- Treesitter (if present): `:TSUpdate`.
- Nix devshell: `nix develop` then `nvim` (preconfigures `NVIM_APPNAME=nvimdots`).
- Bootstrap on a fresh machine: `./scripts/install.sh`.

## Coding Style & Naming Conventions
- Lua formatting via `stylua` (see `stylua.toml`). Indent with tabs, width 4; column width 120; prefer double quotes; always use call parentheses.
- File names: `snake_case.lua`. Modules expose a local `M` table and return it.
- Place feature code under `lua/modules/<area>/...`; keep functions small, composable, and side‑effect free where possible.

## Testing Guidelines
- No formal unit tests. Use smoke checks:
  - `nvim --headless "+Lazy! sync" "+checkhealth" +qa`
  - Manually verify keymaps, LSP/formatters/DAP behavior.
- Python: ensure Neovim uses the active Conda env (`:checkhealth provider`).

## Commit & Pull Request Guidelines
- Follow Conventional Commits: `feat:`, `fix:`, `refactor:`, `chore:`, `docs:`.
- PRs should include: clear summary, rationale, and screenshots/logs (e.g., `:Lazy log`) for failures.
- If plugin specs change, commit the resulting `lazy-lock.json` update. Avoid committing secrets; keep machine‑specific tweaks in `lua/user/**`.

## Agent‑Specific Instructions
- Prefer minimal diffs; don’t rename top‑level dirs.
- Run `stylua lua/` before submitting.
- Touch CI/Nix files only when necessary; coordinate on lockfile updates.

