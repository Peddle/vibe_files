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
  -- avante.nvim and its dependencies
  use {
    "yetone/avante.nvim",
    branch = "main",
    run = "make",
    requires = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "MeanderingProgrammer/render-markdown.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-tree/nvim-web-devicons",
      "HakonHarnes/img-clip.nvim",
      "zbirenbaum/copilot.lua",
      "echasnovski/mini.pick",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require('avante_lib').load()
      require('avante').setup({
        provider = "claude",
        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-3-5-sonnet-20241022",
          temperature = 0,
          max_tokens = 4096,
        },
        behaviour = {
          auto_suggestions = false,
          auto_set_highlight_group = true,
          auto_set_keymaps = true,
          auto_apply_diff_after_generation = false,
          support_paste_from_clipboard = true,
          minimize_diff = true,
          enable_token_counting = true,
        },
        windows = {
          position = "right",
          wrap = true,
          width = 30,
        },
      })
    end
  }
  use "neovim/nvim-lspconfig"
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "saadparwaiz1/cmp_luasnip"
  use "L3MON4D3/LuaSnip"
  use "rafamadriz/friendly-snippets"
  -- Add conform.nvim for formatting
  use {
    'stevearc/conform.nvim',
    requires = { "nvim-lua/plenary.nvim" },
    opts = function()
      local project_utils = require('utils.project')
      local Path = require('plenary.path') -- Still need Path for config file check

      return {
        notify_on_error = false,
        format_on_save = function(bufnr)
          -- Disable format-on-save for files larger than 1MB to prevent performance issues
          local file_size = vim.loop.fs_stat(vim.api.nvim_buf_get_name(bufnr))
          if file_size and file_size.size > 1024 * 1024 then
              return
          end
          -- Enable format-on-save for specific filetypes only
          local format_on_save_filetypes = {python = true, rust = true} -- Add other filetypes if needed
          return {
            timeout_ms = 500,
            lsp_fallback = true,
            quiet = true, -- Suppress messages on successful formatting
          }, format_on_save_filetypes[vim.bo[bufnr].filetype]
        end,
        formatters_by_ft = {
          lua = { 'stylua' },
          -- python = { 'ruff_format' }, -- Use custom definition below
          python = { 'ruff_uv' },
          rust = { 'rustfmt' },
          -- Add other filetypes and formatters here
          -- javascript = { 'prettier' },
          -- typescript = { 'prettier' },
          -- html = { 'prettier' },
          -- css = { 'prettier' },
          -- json = { 'prettier' },
          -- yaml = { 'prettier' },
          -- markdown = { 'prettier' },
        },
        -- Define custom formatter to use uv run
        formatters = {
          ruff_uv = {
            command = "uv",
            -- Dynamically generate args to include --config if pyproject.toml is found
            args = function(opts) -- opts contains { filename, range, ... }
              local cwd = project_utils.find_project_root(vim.api.nvim_get_current_buf())
              local base_args = {"run", "ruff", "format"}
              local config_file = Path:new(cwd):joinpath('pyproject.toml')

              if config_file:exists() then
                vim.list_extend(base_args, {"--config", config_file:absolute()})
              end

              vim.list_extend(base_args, { "-" }) -- Add stdin marker at the end
              return base_args
            end,
            cwd = project_utils.find_project_root, -- Use the helper function
            stdin = true,
          }
        }
      }
    end
  }

  -- Add nvim-lint for linting
  use {
    'mfussenegger/nvim-lint',
    requires = { "nvim-lua/plenary.nvim" },
    config = function() -- Use config function scope
      local project_utils = require('utils.project')
      local Path = require('plenary.path') -- Still need Path for config file check

      local lint = require('lint')
      lint.linters_by_ft = {
        python = {'ruff_uv'},
        -- javascript = {'eslint_d'}, -- Example for other linters
      }

      lint.linters.ruff_uv = {
        cmd = "uv",
        cwd = project_utils.find_project_root, -- Set CWD using the helper
        stdin = true,
        ignore_exitcode = true, -- Ignore non-zero exit code from ruff on lint errors
        parser = function() return require("lint.parser").from_json("body") end, -- Defer require call
        -- Dynamically generate args to include --config if pyproject.toml is found
        args = function(opts)
          local cwd = project_utils.find_project_root(vim.api.nvim_get_current_buf())
          local base_args = {"run", "ruff", "check", "--output-format", "json"}
          local config_file = Path:new(cwd):joinpath('pyproject.toml')

          if config_file:exists() then
            vim.list_extend(base_args, {"--config", config_file:absolute()})
          end

          vim.list_extend(base_args, { "-" }) -- Add stdin marker at the end
          return base_args
        end,
      }

      -- Autocommand to trigger linting
      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("lint", { clear = true }),
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  }

  use { "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } }
  use "tpope/vim-fugitive"
  use "tpope/vim-surround"
  use "lewis6991/gitsigns.nvim"
  use "zbirenbaum/copilot.lua"
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use { "catppuccin/nvim", name = "catppuccin" }
  use "simeji/winresizer"
  use { "MunifTanjim/nui.nvim" }  -- For UI components
  use { "nvim-lua/plenary.nvim" }  -- Required for async operations
  use "nvim-tree/nvim-web-devicons"  -- Keep icons for UI elements
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup({
        -- Add your custom configuration here if needed
        mappings = {
          basic = true,  -- Enable basic mappings like `gc`
          extra = true   -- Enable extra mappings like `gco`, `gcO`, `gcA`
        }
      })
    end
  }

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

-- Load vscode-like snippets
require("luasnip.loaders.from_vscode").lazy_load()

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
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp", priority = 1000 },  -- Give LSP suggestions highest priority
    { name = "luasnip", priority = 750 },
    { name = "buffer", priority = 500 },
    { name = "path", priority = 250 },
  }),
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.kind,
    }
  },
  -- Add window customization for better appearance
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    format = function(entry, vim_item)
      -- Show source name
      vim_item.menu = ({
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        buffer = "[Buffer]",
        path = "[Path]"
      })[entry.source.name]
      return vim_item
    end
  },
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
vim.keymap.set("n", "<C-f>", telescope_builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, { desc = "Buffers list" })
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

-- Git integration: vim-fugitive and gitsigns
vim.keymap.set("n", "<leader>gs", ":Git<CR>", { desc = "Git status" })
require("gitsigns").setup({
  numhl = true,
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

-- Treesitter setup for Python, TypeScript, TSX, and Rust
require("nvim-treesitter.configs").setup({
  ensure_installed = { "python", "typescript", "tsx", "rust" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
})

-- Enable catppuccin theme
require("catppuccin").setup({
  integrations = {
    treesitter = true,
    native_lsp = true,
    cmp = true,
    gitsigns = true,
    telescope = true
  }
})
vim.cmd [[colorscheme catppuccin]]
