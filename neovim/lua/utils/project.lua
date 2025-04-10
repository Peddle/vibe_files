local M = {}

local Path = require('plenary.path')

-- Helper function to find the nearest ancestor directory containing one of the specified markers.
-- Searches upwards from start_dir until a marker is found, or until stop_dir_path (if provided),
-- the HOME directory, or the filesystem root is reached.
local function find_ancestor(start_dir_path, markers, stop_dir_path)
    local start_dir = Path:new(start_dir_path)
    if not start_dir:exists() or not start_dir:is_dir() then
      -- Fallback or error handling if start_dir is invalid
      return nil
    end

    local current_dir = start_dir
    local stop_path = stop_dir_path and Path:new(stop_dir_path)

    while current_dir and current_dir:absolute() ~= '/' and current_dir:absolute() ~= vim.fn.getenv("HOME") do
        -- Check stop condition first
        if stop_path and current_dir:absolute() == stop_path:absolute() then
            -- Check the stop directory itself for markers before stopping
            for _, marker in ipairs(markers) do
                if current_dir:joinpath(marker):exists() then
                    return current_dir:absolute()
                end
            end
            return nil -- Reached stop directory without finding marker
        end

        -- Check for markers in the current directory
        for _, marker in ipairs(markers) do
            if current_dir:joinpath(marker):exists() then
                return current_dir:absolute()
            end
        end

        -- Move to the parent directory
        local parent_dir = current_dir:parent()
        -- Check for root or infinite loop condition
        if not parent_dir or parent_dir:absolute() == current_dir:absolute() then
            break
        end
        current_dir = parent_dir
    end

    -- If the loop finishes without returning, check the last directory (e.g., HOME or /) if it wasn't the stop_path
    if current_dir and (not stop_path or current_dir:absolute() ~= stop_path:absolute()) then
         for _, marker in ipairs(markers) do
            if current_dir:joinpath(marker):exists() then
                return current_dir:absolute()
            end
        end
    end

    return nil -- Marker not found
end


-- Enhanced helper function to find project root (VCS or language-specific)
function M.find_project_root(bufnr)
  bufnr = bufnr or vim.api.nvim_get_current_buf() -- Default to current buffer
  local filepath = vim.api.nvim_buf_get_name(bufnr)
  local current_cwd = vim.fn.getcwd()

  if not filepath or filepath == '' then return current_cwd end -- Use CWD if no file path

  local filedir_path = Path:new(filepath):parent()
  if not filedir_path or not filedir_path:exists() then return current_cwd end -- Use CWD if file path is weird

  local filedir_abs = filedir_path:absolute()

  -- Define root markers
  local vcs_markers = { '.git', '.svn', '.hg' }
  -- Define language markers (add more as needed)
  local lang_marker_map = {
    python = { 'pyproject.toml', 'setup.py', 'setup.cfg', 'requirements.txt', 'ruff.toml' },
    javascript = { 'package.json', '.node-version', '.nvmrc' },
    typescript = { 'package.json', 'tsconfig.json', '.node-version', '.nvmrc' },
    javascriptreact = { 'package.json', '.node-version', '.nvmrc' },
    typescriptreact = { 'package.json', 'tsconfig.json', '.node-version', '.nvmrc' },
    lua = { '.luarocks', 'rockspec' },
    -- Add more filetypes and their markers here
  }

  -- Find the nearest VCS root directory
  local vcs_root_dir = find_ancestor(filedir_abs, vcs_markers)
  local stop_dir = vcs_root_dir or vim.fn.getenv("HOME") -- Stop searching at VCS root or HOME

  -- Determine relevant language markers based on filetype
  local ft = vim.bo[bufnr].filetype
  local lang_markers = lang_marker_map[ft] or {}

  -- Find the nearest language-specific project root directory, stopping at the stop_dir
  local lang_root_dir = nil
  if #lang_markers > 0 then
    lang_root_dir = find_ancestor(filedir_abs, lang_markers, stop_dir)
  end

  -- Determine the CWD priority: Language Root > VCS Root > Neovim CWD
  if lang_root_dir then
    return lang_root_dir
  elseif vcs_root_dir then
    return vcs_root_dir
  else
    return current_cwd -- Fallback to Neovim CWD
  end
end

return M
