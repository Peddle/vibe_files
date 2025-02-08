-- Bootstrapping packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      "git",
      "clone",
      "--depth",
      "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path,
    })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

-- Packer startup and plugin list
require("packer").startup(function(use)
  use "wbthomason/packer.nvim"
  use "neovim/nvim-lspconfig"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "saadparwaiz1/cmp_luasnip"
  use "L3MON4D3/LuaSnip"
  use "rafamadriz/friendly-snippets"
  use { "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } }
  use "tpope/vim-fugitive"
  use "lewis6991/gitsigns.nvim"
  use "zbirenbaum/copilot.lua"
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use "folke/tokyonight.nvim"
  use "simeji/winresizer"

  if packer_bootstrap then
    require("packer").sync()
  end
end)

-- LSP setup for Python (pyright) and TypeScript/TSX (ts_ls)
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
lspconfig.pyright.setup { capabilities = capabilities }
lspconfig.ts_ls.setup { capabilities = capabilities }

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local function bufmap(mode, lhs, rhs, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, lhs, rhs, opts)
    end
    bufmap("n", "K", vim.lsp.buf.hover)
    bufmap("n", "gd", vim.lsp.buf.definition)
    bufmap("n", "gD", vim.lsp.buf.declaration)
    bufmap("n", "gi", vim.lsp.buf.implementation)
    bufmap("n", "gr", vim.lsp.buf.references)
    bufmap("n", "<F2>", vim.lsp.buf.rename)
    bufmap("n", "<F4>", vim.lsp.buf.code_action)
    bufmap("n", "gl", vim.diagnostic.open_float)
    bufmap("n", "[d", vim.diagnostic.goto_prev)
    bufmap("n", "]d", vim.diagnostic.goto_next)
  end,
})

-- nvim-cmp setup
vim.opt.completeopt = { "menu", "menuone", "noselect" }
local cmp = require("cmp")
local luasnip = require("luasnip")
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
})

-- Telescope setup with keybindings
require("telescope").setup({
  defaults = {},
  pickers = {
    find_files = {
      hidden = false,
      respect_gitignore = true
    }
  }
})
local telescope_builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, { desc = "Buffers list" })

-- Git integration: vim-fugitive and gitsigns
vim.keymap.set("n", "<leader>gs", ":Git<CR>", { desc = "Git status" })
require("gitsigns").setup({
  on_attach = function(bufnr)
    local gs = require("gitsigns")
    local function map(mode, lhs, rhs, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, lhs, rhs, opts)
    end
    map("n", "]c", function() gs.next_hunk() end, { desc = "Next hunk" })
    map("n", "[c", function() gs.prev_hunk() end, { desc = "Previous hunk" })
    map("n", "<leader>hs", gs.stage_hunk, { desc = "Stage hunk" })
    map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
    map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
    map("n", "<leader>hb", gs.blame_line, { desc = "Blame line" })
  end,
})

-- Copilot always enabled
require("copilot").setup({
  suggestion = {
    auto_trigger = true,
    keymap = {
      accept = "<C-a>",
    },
  },
})

-- Treesitter setup for Python, TypeScript, and TSX
require("nvim-treesitter.configs").setup({
  ensure_installed = { "python", "typescript", "tsx" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
})

-- Enable tokyonight theme
vim.cmd [[colorscheme tokyonight]]
