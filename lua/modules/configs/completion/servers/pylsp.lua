-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/pylsp.lua

-- Function to find the appropriate Python LSP command
local function get_pylsp_cmd()
	-- Check for conda environment
	local conda_prefix = vim.env.CONDA_PREFIX
	if conda_prefix then
		local conda_pylsp = conda_prefix .. "/bin/pylsp"
		if vim.fn.executable(conda_pylsp) == 1 then
			return { conda_pylsp }
		end
	end
	
	-- Check for virtual environment
	local venv = vim.env.VIRTUAL_ENV
	if venv then
		local venv_pylsp = venv .. "/bin/pylsp"
		if vim.fn.executable(venv_pylsp) == 1 then
			return { venv_pylsp }
		end
	end
	
	-- Fall back to Mason installed pylsp
	local mason_pylsp = vim.fn.stdpath("data") .. "/mason/bin/pylsp"
	if vim.fn.executable(mason_pylsp) == 1 then
		return { mason_pylsp }
	end
	
	-- Final fallback to system pylsp
	return { "pylsp" }
end

return {
	cmd = get_pylsp_cmd(),
	filetypes = { "python" },
	settings = {
		pylsp = {
			plugins = {
				-- Lint
				ruff = {
					enabled = true,
					select = {
						-- enable pycodestyle
						"E",
						-- enable pyflakes
						"F",
					},
					ignore = {
						-- ignore E501 (line too long)
						-- "E501",
						-- ignore F401 (imported but unused)
						-- "F401",
					},
					extendSelect = { "I" },
					severities = {
						-- Hint, Information, Warning, Error
						F401 = "I",
						E501 = "I",
					},
				},
				flake8 = { enabled = false },
				pyflakes = { enabled = false },
				pycodestyle = { enabled = false },
				mccabe = { enabled = false },

				-- Code refactor
				rope = { enabled = true },

				-- Formatting
				black = { enabled = true },
				pyls_isort = { enabled = false },
				autopep8 = { enabled = false },
				yapf = { enabled = false },
			},
		},
	},
}
