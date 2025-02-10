-- Python-specific settings
local util = require('lspconfig/util')

-- Function to find python virtual environment
local function get_python_path(workspace)
    -- Use activated virtualenv if available
    if vim.env.VIRTUAL_ENV then
        return vim.env.VIRTUAL_ENV .. '/bin/python'
    end

    -- Find .venv in workspace directory
    local local_venv = util.path.join(workspace, '.venv/bin/python')
    if util.path.exists(local_venv) then
        return local_venv
    end

    -- Fallback to system Python
    return vim.fn.exepath('python3') or vim.fn.exepath('python')
end

-- Configure Pyright with virtual environment support
require('lspconfig').pyright.setup({
    on_init = function(client)
        client.config.settings.python.pythonPath = get_python_path(client.config.root_dir)
    end,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = 'workspace'
            }
        }
    }
})
