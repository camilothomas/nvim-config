-- =============================================================================
-- init.lua - Neovim entry point
-- =============================================================================
-- Neovim reads this file first on startup. Its job is minimal:
--   1. Set the leader key (must happen before any plugin loads)
--   2. Bootstrap lazy.nvim (the plugin manager)
--   3. Load our options and keymaps
--   4. Hand off plugin loading to lazy.nvim

-- Leader key must be set before lazy.nvim loads.
-- Plugins may define <leader> mappings during setup, so if this comes later,
-- those mappings would bind to the wrong key.
-- Space is set here as leader, and backslash stays as the default localleader.
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- =============================================================================
-- Bootstrap lazy.nvim
-- =============================================================================
-- lazy.nvim is the plugin manager. It lives in the Neovim *data* directory
-- (~/.local/share/nvim/lazy/), not the config directory. This keeps plugin
-- files separate from your own config files.
--
-- On first launch, if lazy.nvim isn't present, this block clones it from
-- GitHub (shallow clone, just like vim-plug did for plugins). Every subsequent
-- launch skips this block entirely.
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone',
    '--filter=blob:none', -- partial clone: skips file blob history, fetches on demand
    '--branch=stable',    -- track the stable release tag
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end

-- Add lazy.nvim to runtimepath so require('lazy') works.
vim.opt.rtp:prepend(lazypath)

-- =============================================================================
-- Load our config modules
-- =============================================================================
-- These run before plugins so that editor options are in place when plugin
-- configs execute (e.g., so colorscheme is set, signcolumn is ready, etc.)
require('options')
require('keymaps')

-- =============================================================================
-- Initialize lazy.nvim
-- =============================================================================
-- Passing the string 'plugins' tells lazy to auto-discover every .lua file
-- inside lua/plugins/ and treat each returned table as a plugin spec.
-- Each file in lua/plugins/ is responsible for one plugin (or small group).
require('lazy').setup('plugins', {
  -- Don't silently check for updates on every startup. Run :Lazy update manually.
  checker = { enabled = false },
  -- Don't notify about changes to the lockfile on startup.
  change_detection = { notify = false },
})
