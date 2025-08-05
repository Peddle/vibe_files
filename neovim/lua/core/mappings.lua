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
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-e>', '<C-\\><C-n>:WinResizerStartResize<CR>', { noremap = true, silent = true })

-- notes
vim.keymap.set('n', 'son', function()
  require('telescope.builtin').find_files({ cwd = vim.fn.expand('~/.my_env_settings/Notes') })
end, { noremap = true, desc = 'Open notes directory' })

vim.keymap.set('n', 'sorn', function()
  require('telescope.builtin').live_grep({ cwd = vim.fn.expand('~/.my_env_settings/Notes') })
end, { noremap = true, desc = 'Search in notes' })

vim.keymap.set('n', 'ssn', ':w ~/.my_env_settings/Notes/', { noremap = true, desc = 'Save to notes directory' })

-- task management
vim.keymap.set('n', 'scm', '$F+cl✔<Esc>', { noremap = true, desc = 'Mark task complete' })
vim.keymap.set('n', 'scc', '$F+clx<Esc>:s/ /-/g<CR>:noh<CR>$a--<Esc>0f-i -<Esc>^', { noremap = true, desc = 'Cancel task' })

-- link management
vim.keymap.set('n', 'sgl', '0f]hyi[', { noremap = true, desc = 'Grab link' })
vim.keymap.set('n', 'spl', 'a [[<Esc>p$a]]<Esc>', { noremap = true, desc = 'Paste link' })

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

-- tab naming
vim.keymap.set('n', '<leader>tn', ':TabRename ', { noremap = true, desc = 'Rename current tab' })

-- LSP definition navigation
vim.keymap.set('n', 'gvd', function()
  vim.cmd('vsplit')
  require('telescope.builtin').lsp_definitions()
end, { desc = '[V]ertical split [D]efinition' })

vim.keymap.set('n', 'gsd', function()
  vim.cmd('split')
  require('telescope.builtin').lsp_definitions()
end, { desc = '[S]plit [D]efinition' })

vim.keymap.set('n', 'gD', function()
  vim.cmd('tab split')
  require('telescope.builtin').lsp_definitions()
end, { desc = '[T]ab [D]efinition' })

vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, { desc = 'Go to type definition' })

vim.keymap.set('n', 'gY', function()
  vim.cmd('tab split')
  vim.lsp.buf.type_definition()
end, { desc = 'Go to type definition in new tab' })

vim.keymap.set('n', 'gR', function()
  require('telescope.builtin').lsp_references()
end, { desc = 'Go to references' })

-- buffer navigation
vim.keymap.set('n', ',n', ':b#<CR>', { noremap = true, silent = true })
vim.keymap.set('n', ',,', ':bn<CR>', { noremap = true, silent = true })
vim.keymap.set('n', ',<', ':bn<CR>', { noremap = true, silent = true })

-- project directory switcher
vim.keymap.set("n", "<leader>p", function()
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  
  require("telescope.builtin").find_files({
    prompt_title = "Select Project",
    cwd = vim.fn.expand("~/Code"),
    hidden = true,
    file_ignore_patterns = { "%.git/", "node_modules/", "%.cache/" },
    find_command = { "find", ".", "-type", "d", "-mindepth", "2", "-maxdepth", "2", "-not", "-name", "." },
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        if selection then
          local dir = vim.fn.expand("~/Code/" .. selection[1])
          vim.cmd("cd " .. vim.fn.fnameescape(dir))
          vim.notify("Changed directory to: " .. dir)
        end
      end)
      return true
    end,
  })
end, { desc = "Select project folder" })

-- remap x, xx, and X to use the black hole register
vim.keymap.set('n', 'x', '"_d', { noremap = true })
vim.keymap.set('n', 'xx', '"_dd', { noremap = true })
vim.keymap.set('n', 'X', '"_D', { noremap = true })
