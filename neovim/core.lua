--===============================================
-- General Settings
--===============================================

-- Use the system clipboard for all yank/paste operations.
vim.opt.clipboard = "unnamedplus"

-- New command to replace fzf ':Files' with Telescope
vim.api.nvim_create_user_command("Files", function(opts)
  local cwd = (opts.args ~= "" and opts.args or vim.loop.cwd())
  require("telescope.builtin").find_files()
end, { nargs = "?" })

-- Map Ctrl-p in normal mode to Telescope's find_files
vim.keymap.set("n", "<C-p>", function()
  require("telescope.builtin").find_files()
end, { desc = "Telescope find files" })

-- Set the leader key to space.
vim.g.mapleader = " "

--===============================================
-- Copy Remaps
--===============================================
--------------------------------------------------------------------------------
-- Remaps from copy.vim
--------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>cp', function()
  return vim.fn.CreateDefaultMakeCopyCommand(vim.fn.expand("%:t"))
end, { expr = true, noremap = true, silent = true })

--===============================================
-- Rename Remaps
--===============================================
--------------------------------------------------------------------------------
-- Remaps from rename.vim
--------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>rn', function()
  return vim.fn.CreateDefaultRenameCommand(vim.fn.expand("%:t"))
end, { expr = true, noremap = true, silent = true })

--===============================================
-- Coc Mappings
--===============================================
--------------------------------------------------------------------------------
-- Remaps from coc-settings.vim (wrapped in vim.cmd since they use complex Vimscript)
--------------------------------------------------------------------------------
vim.cmd([[
" Coc.nvim related mappings
inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : COC_check_back_space() ? "\<TAB>" : coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
nmap <silent> <leader>C <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>c <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Removed mapping for K (which previously used <SID>show_documentation())
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
nnoremap <silent><nowait> <space>cla  :<C-u>CocList diagnostics<cr>
nnoremap <silent><nowait> <space>cle  :<C-u>CocList extensions<cr>
nnoremap <silent><nowait> <space>clc  :<C-u>CocList commands<cr>
nnoremap <silent><nowait> <space>clo  :<C-u>CocList outline<cr>
nnoremap <silent><nowait> <space>cls  :<C-u>CocList -I symbols<cr>
nnoremap <silent><nowait> <space>clj  :<C-u>CocNext<CR>
nnoremap <silent><nowait> <space>clk  :<C-u>CocPrev<CR>
nnoremap <silent><nowait> <space>clp  :<C-u>CocListResume<CR>
]])

--===============================================
-- Core Navigation Remaps
--===============================================
--------------------------------------------------------------------------------
-- Remaps from core.vim
--------------------------------------------------------------------------------
vim.keymap.set('n', '<C-\\>', ':tab split<CR>:exec("tag " . expand("<cword>"))<CR>', { silent = true })
vim.keymap.set('n', '<leader><C-\\>', ':vsp<CR>:exec("tag " . expand("<cword>"))<CR>', { silent = true })

--===============================================
-- Generators Remaps
--===============================================
--------------------------------------------------------------------------------
-- Remaps from generators.vim
--------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>gf', '<Esc>:e<CR>:call StartCodeGenerators()<CR>', { noremap = true, silent = true })

--===============================================
-- Terminal Mode Mappings
--===============================================
--------------------------------------------------------------------------------
-- Remaps from neovim_settings.vim (Terminal mode)
--------------------------------------------------------------------------------
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-J>', '<C-\\><C-n><C-W>j', { noremap = true, silent = true })
vim.keymap.set('t', '<C-K>', '<C-\\><C-n><C-W>k', { noremap = true, silent = true })
vim.keymap.set('t', '<C-H>', '<C-\\><C-n><C-W>h', { noremap = true, silent = true })
vim.keymap.set('t', '<C-L>', '<C-\\><C-n><C-W>l', { noremap = true, silent = true })
vim.keymap.set('t', '<C-O>test', ':call jobsend(b:terminal_job_id, "a123")<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-O>cc', 'cd ~/Code/<Tab>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-O>cs', 'cd ~/.my_env_settings/<Tab>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-O>cd', 'cd ~/Downloads/<Tab>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-O>q', '<C-\\><C-n>:q!<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-E>', '<C-\\><C-n>:WinResizerStartResize<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-i>z', '<C-\\><C-n><C-W>_<C-W>|', { noremap = true, silent = true })
vim.keymap.set('t', '<C-i>Z', '<C-\\><C-n><C-W>=', { noremap = true, silent = true })
vim.keymap.set('t', '<C-i>k', '<C-\\><C-n>:set nosplitbelow<CR>:new<CR><Esc>:set splitbelow<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-i>j', '<C-\\><C-n>:set splitbelow<CR>:new<CR><Esc>:set nosplitbelow<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-i>h', '<C-\\><C-n>:vnew<CR><Esc>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-i>l', '<C-\\><C-n>:set splitright<CR>:vnew<CR><Esc>:set nosplitright<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-w>', '<C-\\><C-n>:q<CR>', { noremap = true, silent = true })
vim.keymap.set('t', '<C-a>', '<Esc>', { noremap = true, silent = true })
vim.api.nvim_create_autocmd({"BufWinEnter", "WinEnter"}, {
  pattern = "term://*",
  callback = function() vim.cmd("startinsert") end,
})

--===============================================
-- Grab Path Mappings
--===============================================
--------------------------------------------------------------------------------
-- Remaps from grab-path.vim
--------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>gp', ':call GrabPath()<CR>', { noremap = true, silent = true })

--===============================================
-- Custom Command Remaps
--===============================================
--------------------------------------------------------------------------------
-- Remaps from remaps.vim
--------------------------------------------------------------------------------
-- Custom commands
vim.api.nvim_create_user_command("Sesh", function()
  local session_file = "~/.vim/sessions" .. vim.fn.getcwd() .. "/Session.vim"
  vim.cmd("Obsess " .. session_file)
end, {})

vim.api.nvim_create_user_command("Tfix", "set nornu | set nonu", {})

-- Clear search highlighting on Esc
vim.keymap.set('n', '<esc>', ':noh<CR><esc>', { noremap = true, silent = true })

-- Insert mode window navigation with saving
vim.keymap.set('i', '<C-J>', '<Esc>:w<CR><C-W>j', { noremap = true, silent = true })
vim.keymap.set('i', '<C-K>', '<Esc>:w<CR><C-W>k', { noremap = true, silent = true })
vim.keymap.set('i', '<C-H>', '<Esc>:w<CR><C-W>h', { noremap = true, silent = true })
vim.keymap.set('i', '<C-L>', '<Esc>:w<CR><C-W>l', { noremap = true, silent = true })

-- Normal mode window navigation
vim.keymap.set('n', '<C-J>', '<C-W>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-K>', '<C-W>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-H>', '<C-W>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-L>', '<C-W>l', { noremap = true, silent = true })

-- Tab resizing and splitting
vim.keymap.set('n', '<TAB>z', '<C-W>_<C-W>|', { noremap = true, silent = true })
vim.keymap.set('n', '<TAB>Z', '<C-W>=', { noremap = true, silent = true })
vim.keymap.set('n', '<TAB>k', ':set nosplitbelow<CR>:new<CR><Esc>:set splitbelow<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<TAB>j', ':set splitbelow<CR>:new<CR><Esc>:set nosplitbelow<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<TAB>h', ':set nosplitright<CR>:vnew<CR><Esc>:set splitright<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<TAB>l', ':set splitright<CR>:vnew<CR><Esc>:set nosplitright<CR>', { noremap = true, silent = true })

-- Function to move the current tab page
function _G.TabMove(direction)
  local ntp = vim.fn.tabpagenr('$')
  if ntp > 1 then
    local ctpn = vim.fn.tabpagenr()
    local index
    if direction < 0 then
      index = ((ctpn - 1 + ntp) % (ntp + 1))
    else
      index = ((ctpn + 1) % (ntp + 1))
    end
    vim.cmd("tabmove " .. index)
  end
end
vim.keymap.set('n', 'gst', ':lua TabMove(1)<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'gsT', ':lua TabMove(-1)<CR>', { noremap = true, silent = true })

-- Buffer navigation
vim.keymap.set('n', ',n', ':b#<CR>', { noremap = true, silent = true })
vim.keymap.set('n', ',,', ':bn<CR>', { noremap = true, silent = true })
vim.keymap.set('n', ',<', ':bn<CR>', { noremap = true, silent = true })

-- Quick reload of init.lua ("ss" mapping)
vim.keymap.set('n', 'ss', function()
  vim.cmd("source " .. vim.fn.stdpath("config") .. "/init.lua")
end, { noremap = true, silent = true })

-- Swift open mappings
vim.keymap.set('n', 'sos', ':Files ~/.my_env_settings<CR>', { noremap = true })
vim.keymap.set('n', 'sot', ':terminal<CR>', { noremap = true })
vim.keymap.set('n', 'som', ':terminal<CR>imosh thelio-remote<CR>', { noremap = true })
vim.keymap.set('n', 'soa', ':terminal<CR>:call jobsend(b:terminal_job_id, "cd ~/Code && aider\n")<CR>', { noremap = true })
vim.keymap.set('n', 'sop', ':e ~/Code/<CR>', { noremap = true })
vim.keymap.set('n', 'son', ':Files ~/.my_env_settings/Notes<CR>', { noremap = true })
vim.keymap.set('n', 'soap', ':Files ~/.my_env_settings/prompts<CR>', { noremap = true })
vim.keymap.set('n', 'c-p', ':Files<CR>', { noremap = true })

-- Swift save note mappings
vim.keymap.set('n', 'ssn', ':w ~/.my_env_settings/Notes/<CR>', { noremap = true })
vim.keymap.set('n', 'ssap', ':w ~/.my_env_settings/prompts/<CR>', { noremap = true })

-- Swift cd mappings
vim.keymap.set('n', 'scdp', 'icd ~/Code/<CR>', { noremap = true })
vim.keymap.set('n', 'scds', 'icd ~/.my_env_settings/<CR>', { noremap = true })

-- Swift grab link mappings
vim.keymap.set('n', 'sgl', '0f]hyi[', { noremap = true })
vim.keymap.set('n', 'scl', '0f]hyi[', { noremap = true })

-- Swift paste link
vim.keymap.set('n', 'spl', 'a [[<Esc>p$a]]<Esc>', { noremap = true })

-- Swift checkmark mappings
vim.keymap.set('n', 'scm', '$F+cl✔<Esc>', { noremap = true })
vim.keymap.set('n', 'sr1', '$F+a <P1><Esc>', { noremap = true })
vim.keymap.set('n', 'sr2', '$F+a <P2><Esc>', { noremap = true })
vim.keymap.set('n', 'sr3', '$F+a <P3><Esc>', { noremap = true })
vim.keymap.set('n', 'sr4', '$F+a <P4><Esc>', { noremap = true })
vim.keymap.set('n', 'sr5', '$F+a <P5><Esc>', { noremap = true })

-- Swift cancel mapping
vim.keymap.set('n', 'scc', '$F+clx<Esc>:s/ /-/g<CR>:noh<CR>$a--<Esc>0f-i -<Esc>^', { noremap = true })

-- Tab navigation like Firefox
vim.keymap.set('n', '<C-t>', ':tabnew<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-w>', ':bd<CR>', { noremap = true, silent = true })

-- Remap x, xx, and X to use the black hole register
vim.keymap.set('n', 'x', '"_d', { noremap = true })
vim.keymap.set('n', 'xx', '"_dd', { noremap = true })
vim.keymap.set('n', 'X', '"_D', { noremap = true })

-- Custom functions for "sdj/sdk/syj/syk" mappings using v:count
function _G.sdj()
  local count = vim.v.count == 0 and "" or vim.v.count
  vim.cmd("normal " .. count .. "jdd" .. count .. "k")
end
function _G.sdk()
  local count = vim.v.count == 0 and "" or vim.v.count
  vim.cmd("normal " .. count .. "kdd" .. count .. "j")
end
function _G.syj()
  local count = vim.v.count == 0 and "" or vim.v.count
  vim.cmd("normal " .. count .. "jyy" .. count .. "k")
end
function _G.syk()
  local count = vim.v.count == 0 and "" or vim.v.count
  vim.cmd("normal " .. count .. "kyy" .. count .. "j")
end
vim.keymap.set('n', 'sdj', ':lua sdj()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'sdk', ':lua sdk()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'syj', ':lua syj()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', 'syk', ':lua syk()<CR>', { noremap = true, silent = true })

-- <leader>p mapping for changing directory
vim.keymap.set('n', '<leader>p', '<Esc>:cd ~/Code/<C-z>', { noremap = true, silent = true })

-- <leader>j and <leader>k for moving to next/previous block
vim.keymap.set('n', '<leader>j', '}', { noremap = true })
vim.keymap.set('n', '<leader>k', '{', { noremap = true })

-- Git blame shortcut
vim.keymap.set('n', '<Leader>bl', ':Git blame<CR>', { noremap = true, silent = true })

-- Fixmyjs shortcut
vim.keymap.set('n', '<Leader><Leader>f', '<Esc>:Fixmyjs<CR>', { noremap = true, silent = true })

-- Open CircleCI config
vim.keymap.set('n', '<Leader>cci', '<Esc>:e ./.circleci/config.yml<CR>', { noremap = true, silent = true })

-- Suda write mapping
vim.keymap.set('n', '<Leader><Leader>w', '<Esc>:w suda://%<CR>', { noremap = true, silent = true })

-- Numeric leader mappings for tab navigation
vim.keymap.set('n', '<leader>1', '1gt', { noremap = true })
vim.keymap.set('n', '<leader>2', '2gt', { noremap = true })
vim.keymap.set('n', '<leader>3', '3gt', { noremap = true })
vim.keymap.set('n', '<leader>4', '4gt', { noremap = true })
vim.keymap.set('n', '<leader>5', '5gt', { noremap = true })
vim.keymap.set('n', '<leader>6', '6gt', { noremap = true })
vim.keymap.set('n', '<leader>7', '7gt', { noremap = true })
vim.keymap.set('n', '<leader>8', '8gt', { noremap = true })
vim.keymap.set('n', '<leader>9', ':tablast<CR>', { noremap = true, silent = true })

-- Fuzzy find lines
vim.keymap.set('n', '<leader>fl', ':Lines<CR>', { noremap = true, silent = true })

-- Open buffers with fzf
vim.keymap.set('n', '<leader>ob', ':Buffers<CR>', { noremap = true, silent = true })

-- Create a new model file
vim.keymap.set('n', '<leader>cm', ':e server/server/models/.py<Left><Left><Left>', { noremap = true, silent = true })

-- Create a new test file from template
vim.keymap.set('n', '<leader>ct', ':e server/tests/.py<Left><Left><Left>', { noremap = true, silent = true })

-- FZF for models (using a grandparent gitignore)
vim.keymap.set('n', '<leader>om', ':Files<CR>server/server/models/', { noremap = true, silent = true })

-- FZF for tests
vim.keymap.set('n', '<leader>ot', ':Files<CR>server/tests/', { noremap = true, silent = true })

-- Run tests in a new split terminal
vim.keymap.set('n', '<leader>rt', ':split<CR>:e term://server/run_tests.sh<CR>', { noremap = true, silent = true })

-- Open copilot helpers file (split, then jump to the end and enter insert mode)
vim.keymap.set('n', '<leader>ch', ':split<CR>:e ~/.my_env_settings/Notes/copilothelpers.txt<CR>GO<CR><CR><CR>', { noremap = true, silent = true })

-- Save and close
vim.keymap.set('n', '<leader>wq', ':wq<CR>', { noremap = true, silent = true })

-- Dark mode toggle function
_G.ToggleDarkMode = function()
    if vim.o.background == 'dark' then
        vim.o.background = 'light'
        vim.cmd[[colorscheme tokyonight-day]]
    else
        vim.o.background = 'dark'
        vim.cmd[[colorscheme tokyonight-storm]]
    end
end

-- Mapping for <leader>tdm
vim.keymap.set('n', '<leader>tdm', ':lua ToggleDarkMode()<CR>', { noremap = true, silent = true })

--===============================================
-- Window Resizing
--===============================================
-- Alt + arrow keys to resize windows
vim.keymap.set('n', '<M-Up>', ':resize +2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<M-Down>', ':resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<M-Left>', ':vertical resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<M-Right>', ':vertical resize +2<CR>', { noremap = true, silent = true })

--===============================================
-- Window Management
--===============================================
-- WinResizer keybinding (Ctrl+E to start resize mode)
vim.keymap.set('n', '<C-e>', ':WinResizerStartResize<CR>', { noremap = true, silent = true })

--===============================================
-- Vim File Settings
--===============================================
--------------------------------------------------------------------------------
-- Remaps from vim-files.vim (Vim file settings)
--------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
  pattern = "vim",
  callback = function()
    vim.cmd("iabbrev <buffer> funk function!()<CR>endfunction<up><left><left>")
  end,
})


-- Function to find the Git repository root directory.
local function find_git_root()
  local git_root = vim.fn.system("git rev-parse --show-toplevel 2> /dev/null")
  -- Remove any trailing newline characters.
  return git_root:gsub("\n", "")
end

-- Create a user command "ProjectFiles" that opens files in the Git root.
vim.api.nvim_create_user_command("ProjectFiles", function()
  local root = find_git_root()
  if root == "" then
    print("Not in a Git repository!")
  else
    -- Assumes that a command "Files" exists (for example, from FZF)
    vim.cmd("Files " .. root)
  end
end, {})

-- Map Ctrl+P to run the ProjectFiles command.
vim.keymap.set("n", "<C-p>", ":ProjectFiles<CR>", { noremap = true, silent = true })
