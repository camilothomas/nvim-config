-- =============================================================================
-- sf.lua - Salesforce development (sf.nvim)
-- =============================================================================
-- sf.nvim wraps the Salesforce CLI (sf) with Neovim hotkeys and UI.
-- Core workflow: push/retrieve metadata, run Apex tests, view org info,
-- browse metadata types to retrieve - all without leaving the editor.
--
-- Project page: https://github.com/xixiaofinland/sf.nvim

return {
  'xixiaofinland/sf.nvim',

  -- Dependencies are other plugins that sf.nvim requires to be installed and
  -- loaded *before* sf.nvim initializes. lazy.nvim handles this automatically:
  -- it installs them (git clone), loads them first (adds to runtimepath), then
  -- runs sf.nvim's config. Without these on the runtimepath, sf.nvim's
  -- require('nvim-treesitter.parsers') and require('fzf-lua') calls would fail.
  dependencies = {
    -- nvim-treesitter: parses Apex source into a syntax tree so sf.nvim can
    -- extract class/method names for targeted test runs.
    'nvim-treesitter/nvim-treesitter',

    -- fzf-lua: fuzzy-finder UI used by sf.nvim's metadata picker (<leader>ml).
    -- This is fzf-lua (ibhagwan), not the older fzf.vim (junegunn) - they are
    -- different plugins. sf.nvim specifically requires fzf-lua.
    'ibhagwan/fzf-lua',
  },

  config = function()
    require('sf').setup({

      -- Use sf.nvim's built-in default hotkeys.
      -- Key mappings are only active in the filetypes listed in hotkeys_in_filetypes.
      -- Set to false if you want to define all mappings yourself.
      enable_hotkeys = true,

      -- Filetypes where sf.nvim hotkeys (push, retrieve, run test, etc.) are active.
      -- 'apex' covers .cls files (detected in options.lua).
      -- javascript and html cover LWC component files.
      hotkeys_in_filetypes = {
        'apex', 'sosl', 'soql', 'javascript', 'html',
      },

      -- Fetch the list of authenticated SF orgs when Neovim starts, and
      -- automatically set target_org if one was previously selected.
      -- This means the lualine status bar shows your org immediately on open.
      -- Safe to keep true since this project is exclusively Salesforce work.
      fetch_org_list_at_nvim_start = true,

      -- Metadata types shown in the metadata list picker (<leader>ml).
      -- Salesforce has 100+ metadata types; this narrows the picker to the
      -- ones you actually work with.
      types_to_retrieve = {
        'ApexClass',
        'ApexTrigger',
        'StaticResource',
        'LightningComponentBundle',
      },

      -- Floating terminal that sf.nvim opens to run sf CLI commands.
      term_config = {
        blend = 10, -- background transparency: 0 = opaque, 100 = invisible
        dimensions = {
          height = 0.4, -- 40% of editor height
          width = 0.8,  -- 80% of editor width
          x = 0.5,      -- centered horizontally
          y = 0.9,      -- anchored near the bottom
        },
      },

      -- Where Salesforce project metadata lives relative to the project root.
      -- This is the standard sf CLI project structure - change only if you've
      -- customized your sfdx-project.json to point elsewhere.
      default_dir = '/force-app/main/default/',

      -- Folder sf.nvim uses to cache intermediate data (org info, coverage, etc.)
      -- Created automatically inside your SF project root. Safe to .gitignore.
      plugin_folder_name = '/sf_cache/',

      -- Automatically show code coverage sign icons after a test run completes.
      -- Green signs = covered lines, red signs = uncovered lines.
      -- Toggle manually with the coverage sign command if you set this to false.
      auto_display_code_sign = true,

      -- Colors for the coverage sign icons shown in the sign column.
      code_sign_highlight = {
        covered   = { fg = '#b7f071' }, -- green
        uncovered = { fg = '#f07178' }, -- red/orange
      },
    })

    -- Open this config file quickly for edits.
    vim.keymap.set('n', '<leader>e', '<CMD>e ~/.config/nvim/lua/plugins/sf.lua<CR>',
      { desc = 'Open sf.nvim config' })

    -- Format the current Apex file using afmt (https://github.com/xixiaofinland/afmt).
    -- Requires the afmt binary to be placed at ~/afmt.
    -- Saves the file, runs afmt in-place, reloads the buffer, restores cursor position.
    local function format_apex()
      local filepath = vim.api.nvim_buf_get_name(0)
      if filepath == '' then
        vim.notify('No file associated with the current buffer.', vim.log.levels.WARN)
        return
      end

      local view = vim.fn.winsaveview()
      vim.cmd('write')

      local result = vim.fn.system(string.format('~/afmt -w "%s"', filepath))

      if vim.v.shell_error == 0 then
        vim.cmd('silent! edit')   -- reload buffer to pick up formatted changes
        vim.fn.winrestview(view)  -- restore cursor position
      else
        vim.notify('afmt error:\n' .. result, vim.log.levels.ERROR)
      end
    end

    vim.keymap.set('n', '<leader>al', format_apex, { desc = 'Format Apex with afmt' })
  end,
}
