-- =============================================================================
-- treesitter.lua - Syntax parsing and highlighting
-- =============================================================================
-- nvim-treesitter is a library that parses source code into syntax trees.
-- It's a dependency of sf.nvim, which uses it to:
--   - Identify Apex class/method names (for running specific tests by name)
--   - Provide accurate syntax highlighting for Apex files
--
-- NOTE: This is nvim-treesitter v1 (a full rewrite, incompatible with the old
-- API). Key differences from the old version:
--   - No more require('nvim-treesitter.configs').setup() - that module is gone
--   - No more ensure_installed/highlight/sync_install config table
--   - Highlighting is ON by default once a parser is installed - no config needed
--   - Parsers are installed via require('nvim-treesitter').install({...})
--   - lazy = false is required - this plugin does not support lazy-loading

return {
  'nvim-treesitter/nvim-treesitter',

  -- Must not be lazy-loaded. The plugin README explicitly states it does not
  -- support lazy-loading - it needs to be in runtimepath from startup.
  lazy = false,

  -- After install or update, run :TSUpdate to ensure all installed parsers
  -- are compiled against the current plugin version.
  build = ':TSUpdate',

  config = function()
    -- Install the parsers we need. This call is a no-op for any parser that's
    -- already installed, so it's safe to run on every startup.
    -- Parsers are compiled C binaries stored in ~/.local/share/nvim/site/parser/
    -- 'apex'    - Salesforce Apex (the main reason treesitter is here)
    -- 'soql'    - Salesforce Object Query Language
    -- 'sosl'    - Salesforce Object Search Language
    -- 'lua'     - for editing Neovim config files
    -- 'vim'     - for vim help files
    -- 'vimdoc'  - for :help buffers
    -- 'markdown' / 'markdown_inline' - for README files, etc.
    require('nvim-treesitter').install({
      'apex',
      -- 'soql',
      -- 'sosl',
      -- 'lua',
      -- 'vim',
      -- 'vimdoc',
      -- 'markdown',
      -- 'markdown_inline',
    })
  end,
}
