-- Tab naming and management functionality
local M = {}

-- Set up tab display configuration
vim.opt.showtabline = 2  -- Always show tabline
vim.opt.tabline = '%!v:lua.custom_tabline()'

-- Custom tabline function
_G.custom_tabline = function()
  local tabline = ''
  for i = 1, vim.fn.tabpagenr('$') do
    -- Select the highlighting
    if i == vim.fn.tabpagenr() then
      tabline = tabline .. '%#TabLineSel#'
    else
      tabline = tabline .. '%#TabLine#'
    end
    
    -- Set the tab page number (for mouse clicks)
    tabline = tabline .. '%' .. i .. 'T'
    
    -- Get custom name or default to tab number
    local tabpage = vim.api.nvim_list_tabpages()[i]
    local success, custom_name = pcall(function() 
      return vim.api.nvim_tabpage_get_var(tabpage, 'custom_tab_name') 
    end)
    
    if success and custom_name then
      tabline = tabline .. ' ' .. custom_name .. ' '
    else
      tabline = tabline .. ' Tab ' .. i .. ' '
    end
  end
  
  -- Fill the rest of the line
  tabline = tabline .. '%#TabLineFill#%T'
  return tabline
end

-- Tab rename command
vim.api.nvim_create_user_command('TabRename', function(opts)
  if opts.args ~= '' then
    vim.api.nvim_tabpage_set_var(0, 'custom_tab_name', opts.args)
    vim.opt_local.statusline = string.format(' %s ', opts.args)
  else
    pcall(function() vim.api.nvim_tabpage_del_var(0, 'custom_tab_name') end)
    vim.opt_local.statusline = nil
  end
end, { nargs = '?', desc = 'Rename current tab' })

return M