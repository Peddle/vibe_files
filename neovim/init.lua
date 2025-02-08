--------------------------------------------------------------------------------
-- init.lua – Consolidated remaps and settings
--------------------------------------------------------------------------------

require("core")
require("settings")
require("plugins")

-- Set up colorscheme
vim.o.termguicolors = true
require("tokyonight").setup({
    style = "storm",
    light_style = "day",
    transparent = false,
    styles = {
        comments = { italic = true },
        keywords = { italic = true },
        sidebars = "dark",
        floats = "dark",
    },
    on_colors = function(colors)
        colors.border = "#3b4261"  -- Make borders more visible
    end
})

-- Set initial theme
vim.o.background = 'dark'
vim.cmd[[colorscheme tokyonight]]

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})
