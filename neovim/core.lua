--===============================================
-- General Settings
--===============================================

-- Use the system clipboard for all yank/paste operations.
vim.opt.clipboard = "unnamedplus"

-- Show line numbers and git signs in gutter
vim.opt.number = true  -- Show line numbers
vim.opt.signcolumn = "yes:1"

-- New command to replace fzf ':Files' with Telescope
vim.api.nvim_create_user_command("Files", function(opts)
  local cwd = (opts.args ~= "" and opts.args or vim.loop.cwd())
  require("telescope.builtin").find_files({ cwd = cwd })
end, { nargs = "?" })

-- Map Ctrl-p in normal mode to Telescope's find_files
vim.keymap.set("n", "<C-p>", function()
  require("telescope.builtin").find_files()
end, { desc = "Telescope find files" })


--===============================================
-- Copy Remaps
--===============================================
--------------------------------------------------------------------------------
-- Remaps from copy.vim
--------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>cp', function()
  local current_file = vim.fn.expand("%:p")
  local new_name = vim.fn.input("Copy to: ", current_file, "file")
  if new_name ~= "" then
    vim.cmd("saveas " .. vim.fn.fnameescape(new_name))
    vim.notify("File copied to: " .. new_name, vim.log.levels.INFO)
  end
end, { noremap = true, silent = true })

--===============================================
-- Rename Remaps
--===============================================
--------------------------------------------------------------------------------
-- Remaps from rename.vim
--------------------------------------------------------------------------------
vim.keymap.set('n', '<leader>rn', function()
  vim.lsp.buf.rename()
end, { noremap = true, silent = true })

--===============================================
-- Completion Mappings
--===============================================
local cmp = require('cmp')
cmp.setup({
  mapping = {
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
  }
})

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
vim.keymap.set('n', '<leader>gp', function()
    -- Get git root
    local git_root = vim.fn.system('git -C ' .. vim.fn.expand('%:p:h') .. ' rev-parse --show-toplevel'):gsub('\n', '')
    -- Get absolute path of current file
    local abs_path = vim.fn.expand('%:p')
    -- Make path relative to git root
    local rel_path = abs_path:sub(#git_root + 2) -- +2 to account for the trailing slash
    vim.fn.setreg('+', rel_path)
    vim.notify("Git relative path '" .. rel_path .. "' copied to clipboard", vim.log.levels.INFO)
end, { noremap = true, desc = "Copy git-relative file path to clipboard" })

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

-- Quick reload of all config files ("ss" mapping)
vim.keymap.set('n', 'ss', function()
  ReloadConfig()
end, { noremap = true, silent = true, desc = "Reload all Neovim config files" })

-- Swift open mappings
vim.keymap.set('n', 'sos', ':Files ~/.my_env_settings<CR>', { noremap = true })
vim.keymap.set('n', 'sot', ':terminal<CR>', { noremap = true })
vim.keymap.set('n', 'soa', ':e term://aider --model sonnet<CR>', { noremap = true })
vim.keymap.set('n', 'sov', ':e term://aider --model sonnet<CR>/voice<CR>', { noremap = true })
vim.keymap.set('n', 'sop', ':e ~/Code/<CR>', { noremap = true })
vim.keymap.set('n', 'son', ':Files ~/.my_env_settings/Notes<CR>', { noremap = true })
vim.keymap.set('n', 'sorn', function()
  require("telescope.builtin").live_grep({ cwd = vim.fn.expand("~/.my_env_settings/Notes") })
end, { noremap = true })
vim.keymap.set('n', 'soap', ':Files ~/.my_env_settings/prompts<CR>', { noremap = true })

-- Swift save note mappings
vim.keymap.set('n', 'ssn', ':w ~/.my_env_settings/Notes/', { noremap = true })
vim.keymap.set('n', 'ssap', ':w ~/.my_env_settings/prompts/', { noremap = true })

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

-- Function to reload Neovim configuration
_G.ReloadConfig = function()
    for name,_ in pairs(package.loaded) do
        if name:match('^core') or name:match('^settings') or name:match('^plugins') then
            package.loaded[name] = nil
        end
    end
    dofile(vim.env.MYVIMRC)
    vim.notify("Neovim configuration reloaded!", vim.log.levels.INFO)
end

-- Dark mode toggle function
_G.ToggleDarkMode = function()
    if vim.o.background == 'dark' then
        vim.o.background = 'light'
        vim.cmd[[colorscheme catppuccin-latte]]
    else
        vim.o.background = 'dark'
        vim.cmd[[colorscheme catppuccin-mocha]]
    end
end

-- Mapping for <leader>tdm
vim.keymap.set('n', '<leader>tdm', ':lua ToggleDarkMode()<CR>', { noremap = true, silent = true })

-- Mapping to reload configuration
vim.keymap.set('n', '<leader>rc', ':lua ReloadConfig()<CR>', { noremap = true, silent = true, desc = "Reload Neovim config" })

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


-- Function to get current buffer's file path
local function get_current_buffer_path()
  return vim.fn.expand('%:p')
end

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

-- AI code rewrite mapping
vim.keymap.set("v", "<leader>ai", function()
    require("ai_rewrite").prompt_ai_rewrite()
end, { noremap = true, silent = false, desc = "AI Rewrite Selected Code" })
vim.keymap.set("n", "<leader>ai", function()
    require("ai_rewrite").prompt_ai_insert()
end, { noremap = true, silent = false, desc = "AI Rewrite Selected Code" })

-- Windsurf integration
vim.keymap.set('n', '<leader>ws', function()
    local cwd = vim.fn.getcwd()
    vim.fn.system('windsurf ' .. vim.fn.shellescape(cwd))
end, { noremap = true, desc = "Open Windsurf in current directory" })
