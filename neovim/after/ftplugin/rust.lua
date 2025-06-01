-- Rust specific settings
vim.opt_local.expandtab = true
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.tabstop = 4

-- Set comment string for Rust
vim.opt_local.commentstring = '// %s'

-- Enable format on save for Rust files
vim.opt_local.formatoptions:append('c')
vim.opt_local.formatoptions:append('r')
vim.opt_local.formatoptions:append('o')