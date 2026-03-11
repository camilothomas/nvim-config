-- =============================================================================
-- lualine.lua - Status line
-- =============================================================================
-- lualine.nvim replaces Neovim's default statusline with a clean, configurable
-- one. The main reason it's here is to show the active Salesforce org and
-- code coverage percentage directly in the status bar via sf.nvim's API.

return {
  'nvim-lualine/lualine.nvim',

  config = function()

    -- sf_status pulls the current target org and code coverage from sf.nvim.
    -- It's called on every statusline redraw, so it must be defensive:
    --   - pcall wraps the require in case sf.nvim isn't loaded yet
    --   - empty-string guards prevent displaying a bare "()" when there's no org
    local function sf_status()
      local ok, sf = pcall(require, 'sf')
      if not ok then return '' end

      local org = sf.get_target_org()
      if not org or org == '' then return '' end

      local pct = sf.covered_percent()
      if pct and pct ~= '' then
        return org .. ' (' .. pct .. ')'
      end
      return org
    end

    require('lualine').setup({
      options = {
        icons_enabled = false,       -- no nerd font icons needed
        component_separators = '|',  -- simple pipe separators between sections
        section_separators = '',     -- no decorative end-caps
      },
      sections = {
        lualine_a = { 'mode' },                    -- NORMAL / INSERT / VISUAL etc.
        lualine_b = { 'branch', 'diff' },          -- git branch + changed lines
        lualine_c = { 'filename', sf_status },     -- file name + SF org/coverage
        lualine_x = { 'encoding', 'filetype' },
        lualine_y = { 'progress' },                -- percentage through file
        lualine_z = { 'location' },                -- line:column
      },
    })
  end,
}
