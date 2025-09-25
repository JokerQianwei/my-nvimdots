return function()
    require("completion.neoconf").setup()
    require("completion.mason").setup()
    require("completion.mason-lspconfig").setup()

    local opts = {
        capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
    }
	-- Configure LSPs that are not supported by `mason.nvim` but are available in `nvim-lspconfig`.
	-- First call |vim.lsp.config()|, then |vim.lsp.enable()| (or use `register_server`, see below)
	-- to ensure the language server is properly configured and starts automatically.
    if vim.fn.executable("dart") == 1 then
        local ok, _opts = pcall(require, "user.configs.lsp-servers.dartls")
        if not ok then
            _opts = require("completion.servers.dartls")
        end
        local final_opts = vim.tbl_deep_extend("keep", _opts, opts)
        require("modules.utils").register_server("dartls", final_opts)
    end

    -- Prefer conda's pylsp if available (fallbacks are handled in server spec)
    do
        local has_pylsp = false
        local conda_prefix = vim.env.CONDA_PREFIX
        if conda_prefix then
            local conda_pylsp = conda_prefix .. "/bin/pylsp"
            has_pylsp = (vim.fn.executable(conda_pylsp) == 1)
        end
        -- Also allow system/Mason pylsp
        if not has_pylsp and vim.fn.executable("pylsp") == 1 then
            has_pylsp = true
        end
        local mason_pylsp = vim.fn.stdpath("data") .. "/mason/bin/pylsp"
        if not has_pylsp and vim.fn.executable(mason_pylsp) == 1 then
            has_pylsp = true
        end

        if has_pylsp then
            local ok, spec = pcall(require, "completion.servers.pylsp")
            if ok then
                local final_opts = vim.tbl_deep_extend("keep", spec, opts)
                require("modules.utils").register_server("pylsp", final_opts)
            end
        end
    end

    pcall(require, "user.configs.lsp")

    -- Start LSPs
    pcall(vim.cmd.LspStart)
end
