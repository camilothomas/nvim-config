# nvim-config

Minimal Neovim setup built around Salesforce development. The centerpiece is
[sf.nvim](https://github.com/xixiaofinland/sf.nvim) - a lightning-fast plugin
that wraps the Salesforce CLI with Neovim hotkeys. Push/retrieve metadata, run
Apex tests, and browse org info without ever leaving the editor.

The philosophy here is agentic: use AI for heavy lifting and complex edits, use
Neovim + sf.nvim for fast CLI operations, targeted test runs, and quick edits
where spinning up a full IDE would be overkill.

## Plugins

| Plugin | Purpose |
|--------|---------|
| [sf.nvim](https://github.com/xixiaofinland/sf.nvim) | Salesforce CLI hotkeys, test runner, metadata picker, coverage signs |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting and code parsing for Apex, SOQL, SOSL |
| [fzf-lua](https://github.com/ibhagwan/fzf-lua) | Fuzzy finder UI (used by sf.nvim's metadata picker) |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Status line showing active SF org and code coverage % |
| [copilot.vim](https://github.com/github/copilot.vim) | AI suggestions (disabled on startup, enable with `:Copilot enable`) |

## Prerequisites

- [Neovim](https://neovim.io/) 0.9+
- [Salesforce CLI](https://developer.salesforce.com/tools/salesforcecli) (`sf`)
- `git`, `curl`, `tar` (for lazy.nvim and treesitter parser downloads)
- `npm` → `npm install -g tree-sitter-cli` (for compiling treesitter parsers)
- A C compiler (`clang` on macOS, `gcc` on Linux/WSL)

## Install

```bash
git clone git@github.com:camilothomas/nvim-config.git ~/.config/nvim
nvim
```

On first launch, [lazy.nvim](https://github.com/folke/lazy.nvim) bootstraps
itself, installs all plugins, and compiles treesitter parsers. Just wait for it
to finish, then restart Neovim.

Run `:checkhealth sf` to verify the Salesforce setup is working correctly.

## Usage

Open Neovim from inside a Salesforce project directory so sf.nvim can detect
the project root and connect to your org.

```bash
cd path/to/your/sf-project
nvim
```

sf.nvim hotkeys are active when editing `apex`, `javascript`, or `html` files.
See the [sf.nvim docs](https://github.com/xixiaofinland/sf.nvim) for the full
hotkey reference.
