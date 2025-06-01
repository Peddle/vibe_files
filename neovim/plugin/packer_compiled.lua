-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/aaronpeddle/.cache/nvim/packer_hererocks/2.1.1736781742/share/lua/5.1/?.lua;/Users/aaronpeddle/.cache/nvim/packer_hererocks/2.1.1736781742/share/lua/5.1/?/init.lua;/Users/aaronpeddle/.cache/nvim/packer_hererocks/2.1.1736781742/lib/luarocks/rocks-5.1/?.lua;/Users/aaronpeddle/.cache/nvim/packer_hererocks/2.1.1736781742/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/aaronpeddle/.cache/nvim/packer_hererocks/2.1.1736781742/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\nh\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\rmappings\1\0\1\rmappings\0\1\0\2\nextra\2\nbasic\2\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["avante.nvim"] = {
    config = { "\27LJ\2\næ\3\0\0\4\0\f\0\0186\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\4\0005\2\5\0005\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\2B\0\2\1K\0\1\0\fwindows\1\0\3\rposition\nright\twrap\2\nwidth\3\30\14behaviour\1\0\a\18minimize_diff\2!support_paste_from_clipboard\2%auto_apply_diff_after_generation\1\21auto_set_keymaps\2\29auto_set_highlight_group\2\21auto_suggestions\1\26enable_token_counting\2\vclaude\1\0\4\16temperature\3\0\rendpoint\30https://api.anthropic.com\nmodel\31claude-3-5-sonnet-20241022\15max_tokens\3€ \1\0\4\rprovider\vclaude\fwindows\0\14behaviour\0\vclaude\0\nsetup\vavante\tload\15avante_lib\frequire\0" },
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/avante.nvim",
    url = "https://github.com/yetone/avante.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["conform.nvim"] = {
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/conform.nvim",
    url = "https://github.com/stevearc/conform.nvim"
  },
  ["copilot.lua"] = {
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/copilot.lua",
    url = "https://github.com/zbirenbaum/copilot.lua"
  },
  ["dressing.nvim"] = {
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["gitsigns.nvim"] = {
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["img-clip.nvim"] = {
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/img-clip.nvim",
    url = "https://github.com/HakonHarnes/img-clip.nvim"
  },
  ["mini.pick"] = {
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/mini.pick",
    url = "https://github.com/echasnovski/mini.pick"
  },
  ["nui.nvim"] = {
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/nui.nvim",
    url = "https://github.com/MunifTanjim/nui.nvim"
  },
  nvim = {
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/nvim",
    url = "https://github.com/catppuccin/nvim"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lint"] = {
    config = { "\27LJ\2\nB\0\0\3\0\4\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0D\0\2\0\tbody\14from_json\16lint.parser\frequireÇ\2\0\1\v\2\r\1%-\1\0\0009\1\0\0016\3\1\0009\3\2\0039\3\3\3B\3\1\0A\1\0\0025\2\4\0-\3\1\0\18\5\3\0009\3\5\3\18\6\1\0B\3\3\2\18\5\3\0009\3\6\3'\6\a\0B\3\3\2\18\6\3\0009\4\b\3B\4\2\2\15\0\4\0X\5\t€6\4\1\0009\4\t\4\18\6\2\0005\a\n\0\18\n\3\0009\b\v\3B\b\2\0?\b\0\0B\4\3\0016\4\1\0009\4\t\4\18\6\2\0005\a\f\0B\4\3\1L\2\2\0\0À\1À\1\2\0\0\6-\rabsolute\1\2\0\0\r--config\16list_extend\vexists\19pyproject.toml\rjoinpath\bnew\1\6\0\0\brun\truff\ncheck\20--output-format\tjson\25nvim_get_current_buf\bapi\bvim\22find_project_root\5€€À™\0045\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\rtry_lint\tlint\frequireä\3\1\0\v\0\27\0'6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0025\3\6\0005\4\5\0=\4\a\3=\3\4\0029\3\b\0025\4\n\0009\5\v\0=\5\f\0043\5\r\0=\5\14\0043\5\15\0=\5\16\4=\4\t\0036\3\17\0009\3\18\0039\3\19\0035\5\20\0005\6\23\0006\a\17\0009\a\18\a9\a\21\a'\t\3\0005\n\22\0B\a\3\2=\a\24\0063\a\25\0=\a\26\6B\3\3\0012\0\0€K\0\1\0\rcallback\0\ngroup\1\0\2\ngroup\0\rcallback\0\1\0\1\nclear\2\24nvim_create_augroup\1\4\0\0\rBufEnter\17BufWritePost\16InsertLeave\24nvim_create_autocmd\bapi\bvim\targs\0\vparser\0\bcwd\22find_project_root\1\0\6\bcmd\auv\bcwd\0\nstdin\2\vparser\0\20ignore_exitcode\2\targs\0\fruff_uv\flinters\vpython\1\0\1\vpython\0\1\2\0\0\fruff_uv\18linters_by_ft\tlint\17plenary.path\18utils.project\frequire\0" },
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/nvim-lint",
    url = "https://github.com/mfussenegger/nvim-lint"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/nvim-tree/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["render-markdown.nvim"] = {
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/render-markdown.nvim",
    url = "https://github.com/MeanderingProgrammer/render-markdown.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  winresizer = {
    loaded = true,
    path = "/Users/aaronpeddle/.local/share/nvim/site/pack/packer/start/winresizer",
    url = "https://github.com/simeji/winresizer"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-lint
time([[Config for nvim-lint]], true)
try_loadstring("\27LJ\2\nB\0\0\3\0\4\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0D\0\2\0\tbody\14from_json\16lint.parser\frequireÇ\2\0\1\v\2\r\1%-\1\0\0009\1\0\0016\3\1\0009\3\2\0039\3\3\3B\3\1\0A\1\0\0025\2\4\0-\3\1\0\18\5\3\0009\3\5\3\18\6\1\0B\3\3\2\18\5\3\0009\3\6\3'\6\a\0B\3\3\2\18\6\3\0009\4\b\3B\4\2\2\15\0\4\0X\5\t€6\4\1\0009\4\t\4\18\6\2\0005\a\n\0\18\n\3\0009\b\v\3B\b\2\0?\b\0\0B\4\3\0016\4\1\0009\4\t\4\18\6\2\0005\a\f\0B\4\3\1L\2\2\0\0À\1À\1\2\0\0\6-\rabsolute\1\2\0\0\r--config\16list_extend\vexists\19pyproject.toml\rjoinpath\bnew\1\6\0\0\brun\truff\ncheck\20--output-format\tjson\25nvim_get_current_buf\bapi\bvim\22find_project_root\5€€À™\0045\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\rtry_lint\tlint\frequireä\3\1\0\v\0\27\0'6\0\0\0'\2\1\0B\0\2\0026\1\0\0'\3\2\0B\1\2\0026\2\0\0'\4\3\0B\2\2\0025\3\6\0005\4\5\0=\4\a\3=\3\4\0029\3\b\0025\4\n\0009\5\v\0=\5\f\0043\5\r\0=\5\14\0043\5\15\0=\5\16\4=\4\t\0036\3\17\0009\3\18\0039\3\19\0035\5\20\0005\6\23\0006\a\17\0009\a\18\a9\a\21\a'\t\3\0005\n\22\0B\a\3\2=\a\24\0063\a\25\0=\a\26\6B\3\3\0012\0\0€K\0\1\0\rcallback\0\ngroup\1\0\2\ngroup\0\rcallback\0\1\0\1\nclear\2\24nvim_create_augroup\1\4\0\0\rBufEnter\17BufWritePost\16InsertLeave\24nvim_create_autocmd\bapi\bvim\targs\0\vparser\0\bcwd\22find_project_root\1\0\6\bcmd\auv\bcwd\0\nstdin\2\vparser\0\20ignore_exitcode\2\targs\0\fruff_uv\flinters\vpython\1\0\1\vpython\0\1\2\0\0\fruff_uv\18linters_by_ft\tlint\17plenary.path\18utils.project\frequire\0", "config", "nvim-lint")
time([[Config for nvim-lint]], false)
-- Config for: avante.nvim
time([[Config for avante.nvim]], true)
try_loadstring("\27LJ\2\næ\3\0\0\4\0\f\0\0186\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\0016\0\0\0'\2\3\0B\0\2\0029\0\4\0005\2\5\0005\3\6\0=\3\a\0025\3\b\0=\3\t\0025\3\n\0=\3\v\2B\0\2\1K\0\1\0\fwindows\1\0\3\rposition\nright\twrap\2\nwidth\3\30\14behaviour\1\0\a\18minimize_diff\2!support_paste_from_clipboard\2%auto_apply_diff_after_generation\1\21auto_set_keymaps\2\29auto_set_highlight_group\2\21auto_suggestions\1\26enable_token_counting\2\vclaude\1\0\4\16temperature\3\0\rendpoint\30https://api.anthropic.com\nmodel\31claude-3-5-sonnet-20241022\15max_tokens\3€ \1\0\4\rprovider\vclaude\fwindows\0\14behaviour\0\vclaude\0\nsetup\vavante\tload\15avante_lib\frequire\0", "config", "avante.nvim")
time([[Config for avante.nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\nh\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\rmappings\1\0\1\rmappings\0\1\0\2\nextra\2\nbasic\2\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
