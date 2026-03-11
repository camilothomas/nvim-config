-- =============================================================================
-- options.lua - Editor settings
-- =============================================================================
-- In Lua, vim options are set via vim.opt instead of :set.
-- vim.opt.name = value  is equivalent to  :set name=value
-- Using a local alias keeps lines short.
local opt = vim.opt

-- Encoding -----------------------------------------------------------------
opt.encoding = 'utf-8'

-- Indentation --------------------------------------------------------------
-- 4-space indentation, tabs expanded to spaces (standard for Apex/JS).
opt.tabstop = 4      -- a Tab character displays as 4 spaces wide
opt.shiftwidth = 4   -- >> and << indent by 4 spaces
opt.softtabstop = 4  -- Tab in insert mode inserts 4 spaces
opt.expandtab = true -- pressing Tab inserts spaces, not a tab character

-- Scrolling ----------------------------------------------------------------
-- Keep at least 3 lines visible above and below the cursor while scrolling.
-- Prevents the cursor from sitting at the very edge of the screen.
opt.scrolloff = 3

-- Editing ------------------------------------------------------------------
opt.autoindent = true  -- new lines inherit indentation from the line above
opt.hidden = true      -- allow switching buffers without saving first

-- UI feedback --------------------------------------------------------------
opt.showmode = true    -- show '-- INSERT --' etc. in the statusline area
opt.showcmd = true     -- show partial command keystrokes in the bottom right
opt.ruler = true       -- show cursor line/column in the statusline
opt.number = true      -- show absolute line numbers in the gutter
opt.visualbell = true  -- flash screen instead of beeping on errors

-- Wild menu (command-line completion) --------------------------------------
-- When you press Tab in command mode, show a list of matches.
opt.wildmenu = true
opt.wildmode = 'list:longest'

-- Color column -------------------------------------------------------------
-- Draw a subtle vertical line at column 80 as a soft line-length reminder.
opt.colorcolumn = '80'

-- Line wrapping ------------------------------------------------------------
opt.wrap = true       -- visually wrap long lines (doesn't change the file)
opt.linebreak = true  -- wrap at word boundaries, not mid-word
opt.list = false      -- don't show invisible characters (tabs, trailing spaces)

-- Formatting ---------------------------------------------------------------
-- q: allow formatting comments with gq
-- r: auto-insert comment leader on Enter
-- n: recognize numbered lists
-- 1: don't break a line after a one-letter word
opt.formatoptions = 'qrn1'

-- Search -------------------------------------------------------------------
opt.incsearch = true   -- highlight matches as you type the search pattern
opt.showmatch = true   -- briefly jump to the matching bracket when one is inserted
opt.hlsearch = true    -- highlight all matches after a search

-- File safety --------------------------------------------------------------
-- Disable backup files. Some tools get confused by them, and they're mostly
-- unnecessary with version control. writebackup disables the temp file that
-- Neovim creates while saving.
opt.backup = false
opt.writebackup = false

-- Performance --------------------------------------------------------------
-- Default updatetime is 4000ms (4s). Lowering it makes the sign column
-- (where sf.nvim shows coverage indicators) more responsive.
opt.updatetime = 300

-- Sign column --------------------------------------------------------------
-- Always show the sign column (the narrow gutter left of line numbers).
-- Without this, the editor shifts left/right when signs appear/disappear,
-- which is distracting. sf.nvim uses signs for code coverage display.
opt.signcolumn = 'yes'

-- Colorscheme --------------------------------------------------------------
-- 'ron' is a built-in dark colorscheme. No plugin required.
vim.cmd('colorscheme ron')

-- Filetype detection -------------------------------------------------------
-- Neovim doesn't know about .cls files by default. We tell it they're Apex
-- so that treesitter highlighting, sf.nvim hotkeys, and other filetype-aware
-- features activate correctly.
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.cls',
  callback = function()
    vim.bo.filetype = 'apex'
  end,
  desc = 'Detect Salesforce Apex .cls files as apex filetype',
})
