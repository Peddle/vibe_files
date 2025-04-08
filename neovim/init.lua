--------------------------------------------------------------------------------
-- init.lua – Consolidated remaps and settings
--------------------------------------------------------------------------------
-- Set the leader key to space.
vim.g.mapleader = " "

-- Add the current directory to the Lua package path
local config_path = vim.fn.stdpath('config')
package.path = config_path .. "/?.lua;" .. package.path

-- Display hello world message
vim.notify("ᐊᐃᓐᖓᐃ, ᓯᓚᕐᔪᐊᖅ!", vim.log.levels.INFO)

-- Set up colorscheme
vim.o.termguicolors = true

-- Force true color support
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

-- Load plugins first
require("plugins")

-- Load LSP configuration
require('lsp')

-- Then load configurations
pcall(require, "core")
pcall(require, "settings")

require("catppuccin").setup({
    flavour = "mocha",
    background = {
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false,
    show_end_of_buffer = false,
    term_colors = true,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    integrations = {
        treesitter = true,
        native_lsp = true,
        cmp = true,
        gitsigns = true,
        telescope = true,
    },
    color_overrides = {
        mocha = {
            comment = "#9399b2"  -- Lighter gray-blue color for comments
        }
    }
})

-- Set initial theme
vim.o.background = 'dark'
vim.cmd[[colorscheme catppuccin]]

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})

-- Tab naming configuration
vim.api.nvim_create_user_command('TabRename', function(opts)
    if opts.args ~= '' then
        vim.t.custom_tab_name = opts.args
        vim.opt_local.statusline = string.format(' %s ', opts.args)
    else
        vim.t.custom_tab_name = nil
        vim.opt_local.statusline = nil
    end
end, { nargs = '?', desc = 'Rename current tab' })

-- Keybinding for quick tab rename
vim.keymap.set('n', '<leader>tn', ':TabRename ', { noremap = true, desc = 'Rename current tab' })

-- Select entire file with <leader>a
vim.keymap.set('n', '<leader>all', 'ggVG', { desc = 'Select entire file' })

-- Buffer management
vim.keymap.set('n', '<C-q>', ':bd<CR>', { noremap = true, silent = true, desc = 'Delete buffer' })

-- Set up tab name display in tabline
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
        local success, custom_name = pcall(function() return vim.t[i].custom_tab_name end)
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

-- Temporary debug function
vim.api.nvim_create_user_command('CheckMap', function()
  local maps = vim.api.nvim_get_keymap('n')
  for _, map in ipairs(maps) do
    if map.lhs:match("^<C%-w><C%-w>") or map.lhs:match("^<C%-w>w") then
      print(string.format("Found mapping: %s -> %s", map.lhs, map.rhs or "(lua function)"))
    end
  end
end, {})
