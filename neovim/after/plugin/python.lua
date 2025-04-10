-- Enhanced Python-specific settings for better import resolution
local util = require('lspconfig/util')

local function get_python_path(workspace)
    -- Use activated virtualenv if available
    if vim.env.VIRTUAL_ENV then
        return vim.env.VIRTUAL_ENV .. '/bin/python'
    end

    -- Find .venv or venv in workspace directory
    for _, pattern in ipairs({'/.venv/', '/venv/'}) do
        local local_venv = util.path.join(workspace, pattern .. 'bin/python')
        if util.path.exists(local_venv) then
            return local_venv
        end
    end

    -- Check for Poetry virtual environment
    local poetry_venv = vim.fn.trim(vim.fn.system('poetry env info -p 2>/dev/null'))
    if vim.v.shell_error == 0 and poetry_venv ~= "" then
        return poetry_venv .. '/bin/python'
    end

    -- Fallback to system Python
    return vim.fn.exepath('python3') or vim.fn.exepath('python')
end

require('lspconfig').pyright.setup({
    on_init = function(client)
        client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
    end,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'workspace',
                autoImportCompletions = true  -- Enable auto-imports
            }
        }
    },
    capabilities = require("cmp_nvim_lsp").default_capabilities()
})

-- Python-specific indentation rules (PEP 8 standard)
vim.api.nvim_create_autocmd("FileType", {
    pattern = "python",
    callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.shiftwidth = 4
        vim.opt_local.tabstop = 4
        vim.opt_local.softtabstop = 4
    end,
})

-- Add autoimport command for Python
vim.api.nvim_create_user_command("ImportPython", function()
    vim.lsp.buf.execute_command({
        command = "pyright.organizeimports",
        arguments = {vim.uri_from_bufnr(0)},
    })
end, {})

-- Keybinding for auto-importing
vim.keymap.set("n", "<leader>ii", ":ImportPython<CR>", { noremap = true, silent = true })
