local function resolve_python_interpreter()
	local conda_prefix = vim.env.CONDA_PREFIX
	if conda_prefix and #conda_prefix > 0 then
		local python_in_conda = conda_prefix .. "/bin/python"
		if vim.loop.fs_stat(python_in_conda) then
			return python_in_conda
		end
	end

	local python3_path = vim.fn.exepath("python3")
	if python3_path ~= "" then
		return python3_path
	end

	local python_path = vim.fn.exepath("python")
	if python_path ~= "" then
		return python_path
	end

	return "python3"
end

return function()
	require("modules.utils").load_plugin("sniprun", {
		borders = "single",
		inline_messages = 0,
		interpreter_options = {
			Python3_original = {
				interpreter = resolve_python_interpreter(),
			},
		},
		display = {
			"Classic", -- "display results in the command-line area
			"VirtualTextOk", -- "display ok results as virtual text (multiline is shortened)
			"VirtualTextErr", -- "display error results as virtual text
			-- "TempFloatingWindow", -- "display results in a floating window
			"LongTempFloatingWindow", -- "same as above, but only long results. To use with VirtualText
			-- "Terminal"                 -- "display results in a vertical split
		},
	})
end
