vim.g.mapleader = ' ' -- easy to reach leader key
vim.keymap.set('n', '-', vim.cmd.Ex) -- need nvim 0.8+

-- window management
vim.keymap.set('n', '<TAB>z', '<C-W>_<C-W>|', { noremap = true, silent = true })
vim.keymap.set('n', '<TAB>Z', '<C-W>=', { noremap = true, silent = true })
vim.keymap.set('n', '<TAB>k', ':set nosplitbelow<CR>:new<CR><Esc>:set splitbelow<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<TAB>j', ':set splitbelow<CR>:new<CR><Esc>:set nosplitbelow<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<TAB>h', ':set nosplitright<CR>:vnew<CR><Esc>:set splitright<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<TAB>l', ':set splitright<CR>:vnew<CR><Esc>:set nosplitright<CR>', { noremap = true, silent = true })

-- Normal mode window navigation
vim.keymap.set('n', '<C-J>', '<C-W>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-K>', '<C-W>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-H>', '<C-W>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-L>', '<C-W>l', { noremap = true, silent = true })
vim.keymap.set('n', '<C-w>', ':q<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-q>', ':bd<CR>', { noremap = true, silent = true })

-- terminal
vim.keymap.set('n', 'sot', ':terminal<CR>', { noremap = true })

-- Terminal mode window navigation
vim.keymap.set('t', '<C-J>', '<C-\\><C-n><C-W>j', { noremap = true, silent = true })
vim.keymap.set('t', '<C-K>', '<C-\\><C-n><C-W>k', { noremap = true, silent = true })
vim.keymap.set('t', '<C-H>', '<C-\\><C-n><C-W>h', { noremap = true, silent = true })
vim.keymap.set('t', '<C-L>', '<C-\\><C-n><C-W>l', { noremap = true, silent = true })
vim.keymap.set('t', '<C-w>', '<C-\\><C-n>:q<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-q>', '<C-\\><C-n>:bd<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-a>', '<Esc>', { noremap = true, silent = true })

-- notes
vim.keymap.set('n', 'son', ':Files ~/.my_env_settings/Notes<CR>', { noremap = true })
vim.keymap.set('n', 'ssn', ':w ~/.my_env_settings/Notes/', { noremap = true })
vim.keymap.set('n', 'scm', '$F+cl✔<Esc>', { noremap = true })

-- tab management
vim.keymap.set('n', '<C-t>', ':tabnew<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>1', '1gt', { noremap = true })
vim.keymap.set('n', '<leader>2', '2gt', { noremap = true })
vim.keymap.set('n', '<leader>3', '3gt', { noremap = true })
vim.keymap.set('n', '<leader>4', '4gt', { noremap = true })
vim.keymap.set('n', '<leader>5', '5gt', { noremap = true })
vim.keymap.set('n', '<leader>6', '6gt', { noremap = true })
vim.keymap.set('n', '<leader>7', '7gt', { noremap = true })
vim.keymap.set('n', '<leader>8', '8gt', { noremap = true })
vim.keymap.set('n', '<leader>9', ':tablast<CR>', { noremap = true, silent = true })

-- LSP definition navigation
vim.keymap.set('n', 'gvd', function()
  vim.cmd('vsplit')
  require('telescope.builtin').lsp_definitions()
end, { desc = '[V]ertical split [D]efinition' })

vim.keymap.set('n', 'gsd', function()
  vim.cmd('split')
  require('telescope.builtin').lsp_definitions()
end, { desc = '[S]plit [D]efinition' })

vim.keymap.set('n', 'gtd', function()
  vim.cmd('tab split')
  require('telescope.builtin').lsp_definitions()
end, { desc = '[T]ab [D]efinition' })
