--------------------------------------------------------------------------------
-- settings.lua – Basic Neovim/Vim Options
--------------------------------------------------------------------------------

-- Line numbers: Enable absolute and relative line numbers.
vim.opt.number = true
vim.opt.relativenumber = true

-- Search settings:
-- Ignore case when searching unless uppercase letters are used (smartcase).
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- Auto-write: Automatically save changes when switching buffers.
vim.opt.autowrite = true

-- Display settings:
-- No extra line spacing and keep a vertical scroll offset.
vim.opt.linespace = 0
vim.opt.scrolloff = 7

-- Tab and indentation settings:
-- Use spaces instead of tabs, with each tab equating to 2 spaces.
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Wrapping and text width:
-- Wrap lines at word boundaries and set a high text width (for long lines).
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.textwidth = 500

-- Clipboard:
-- Use the system clipboard for all yank/paste operations.
vim.opt.clipboard = "unnamedplus"

-- File search and tags:
-- Recursively search in the current directory.
vim.opt.path:append("**")
vim.opt.tags = "tags;"

-- Timeout settings for key sequences.
vim.opt.timeoutlen = 1000
vim.opt.ttimeoutlen = 0

-- Backup and swap file settings:
-- Store backup and swap files in a temporary directory.
local tmpdir = os.getenv("HOME") .. "/.tmp/" .. vim.fn.getpid()
vim.fn.mkdir(tmpdir, "p")
vim.opt.backupdir = tmpdir
vim.opt.directory = tmpdir

-- Signcolumn:
-- Combine the sign column with the line numbers (if supported).
vim.opt.signcolumn = "number"

--------------------------------------------------------------------------------
-- End of settings.lua
--------------------------------------------------------------------------------
