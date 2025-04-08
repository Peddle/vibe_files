-- Python-specific settings for Neovim (ftplugin/python.lua)
-- Forces 4-space indentation and fixes continuation indent issues

-- Create local function for setting Python indentation
local function setup_python_indent()
  -- Force 4-space indentation (PEP 8 standard)
  vim.bo.tabstop = 4
  vim.bo.softtabstop = 4
  vim.bo.shiftwidth = 4
  vim.bo.expandtab = true
  vim.bo.autoindent = true
  
  -- Explicitly override the global settings that might be affecting indentation
  vim.opt_local.tabstop = 4
  vim.opt_local.softtabstop = 4
  vim.opt_local.shiftwidth = 4
  vim.opt_local.expandtab = true
  
  -- This explicitly controls continuation indentation for Python
  vim.g.python_indent = {
    open_paren = 'shiftwidth()',  -- Use exactly one shiftwidth (4 spaces)
    nested_paren = 'shiftwidth()', -- Same for nested parens
    continue = 'shiftwidth()'      -- Same for line continuations
  }
  
  -- Set additional indent options
  vim.opt_local.smartindent = true
  vim.opt_local.autoindent = true
  vim.opt_local.fileformat = "unix"
  
  -- Add indentation keys to control behavior after brackets
  vim.opt_local.cinkeys = '0{,0},0),0],:,!^F,o,O,e'
  vim.opt_local.indentkeys = '0{,0},0),0],:,!^F,o,O,e'

  -- Vim's Python indent plugin settings
  vim.g.pyindent_open_paren = 4     -- Indent after open paren
  vim.g.pyindent_nested_paren = 4   -- Indent for nested parens
  vim.g.pyindent_continue = 4       -- Indent for continued lines
 end

-- Run the setup function immediately
setup_python_indent()

-- Also set up an autocmd to ensure these settings are applied
vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = setup_python_indent
})
