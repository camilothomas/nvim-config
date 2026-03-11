-- =============================================================================
-- keymaps.lua - Key mappings
-- =============================================================================
-- All custom keymaps live here so they're easy to find and audit in one place.
-- Plugin-specific keymaps (sf.nvim, etc.) live in their respective plugin files.
--
-- vim.keymap.set(mode, lhs, rhs, opts)
--   mode: 'n' normal, 'i' insert, 'v' visual, 'x' visual-block, 'o' operator
--   lhs:  the key(s) you press
--   rhs:  what it does (string command or Lua function)
--   opts: table of options; 'desc' shows up in :map listings and which-key

-- NOTE: <leader> is set to Space in init.lua before this file loads.

-- Escape -------------------------------------------------------------------
-- jk in insert mode exits to normal mode. Faster than reaching for Esc,
-- and keeps your hands on the home row. 'j' alone still works normally;
-- the mapping only triggers if 'k' follows immediately.
vim.keymap.set('i', 'jk', '<ESC>', { desc = 'Exit insert mode' })

-- Arrow keys ---------------------------------------------------------------
-- Disabled in normal and insert mode to enforce hjkl movement.
-- This is the classic vim discipline setup. Once hjkl is muscle memory
-- you can remove these lines, but they're useful early on.
local noop = '<nop>'
vim.keymap.set('n', '<up>',    noop)
vim.keymap.set('n', '<down>',  noop)
vim.keymap.set('n', '<left>',  noop)
vim.keymap.set('n', '<right>', noop)
vim.keymap.set('i', '<up>',    noop)
vim.keymap.set('i', '<down>',  noop)
vim.keymap.set('i', '<left>',  noop)
vim.keymap.set('i', '<right>', noop)
