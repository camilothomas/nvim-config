-- =============================================================================
-- copilot.lua - GitHub Copilot AI suggestions
-- =============================================================================
-- copilot.vim is GitHub's official Neovim plugin. It connects to GitHub's
-- Copilot service and shows inline code suggestions as you type (ghost text).
--
-- It's disabled on startup here because:
--   - For Salesforce work, sf.nvim CLI hotkeys and quick edits are the priority
--   - Copilot suggestions can be distracting during focused navigation
--   - You can enable it per-session with :Copilot enable when you want it

return {
  'github/copilot.vim',

  config = function()
    -- Disable Copilot suggestions on startup.
    -- Toggle back on with :Copilot enable
    -- Toggle back off with :Copilot disable
    vim.g.copilot_enabled = false
  end,
}
