# Repository Guidelines
This is my neovim configuration. I want a config that is mine. It should be minimal, and work for the following languages, when no LSP is provided, assume the default one:

- python (ty, ruff)
- yaml
- json
- Docker
- Go
- Lua
- Markdown
- ReST

I want to use the lazy.nvim package manager to install packages. Installing language servers will be done in my system and should not be configured inside my neovim config. Keep in mind that this config should work inside a NixOS installation, so make sure to keep everyting inside of userland.

## Project Structure
- Each plugin should have an own file inside `lua/`.
- Each LSP is configure in an own file inside `lsp/`.
- When appropriate, add `before/ftplugin`
- Centralize one-time LSP enablement logic in Lua modules (for example `lua/lsp_setup.lua`) and avoid per-buffer setup in ftplugin files.
- Keep shared LSP autocmds (like `LspAttach` keymaps) inside the same setup module so `init.lua` only needs to call a single `lsp_setup.setup()` entrypoint.

## Build & Validation
- Run `XDG_CACHE_HOME="$PWD/.tmp/xdg-cache" XDG_STATE_HOME="$PWD/.tmp/xdg-state" XDG_DATA_HOME="$PWD/.tmp/xdg-data" nvim --clean -u init.lua +qa` before pushing to ensure startup succeeds without user-local state.
- Use `XDG_CACHE_HOME="$PWD/.tmp/xdg-cache" XDG_STATE_HOME="$PWD/.tmp/xdg-state" XDG_DATA_HOME="$PWD/.tmp/xdg-data" nvim --headless -u init.lua "+checkhealth" +qa` to surface missing dependencies or Lua errors.
- Format Lua sources with `stylua init.lua lua lsp` so the style stays consistent across files.
- When network is restricted, request access before running the two Neovim validation commands so lazy.nvim can download plugins.

Run these validations after every change.

## Coding Style & Naming Conventions
- Follow standard Lua style: two-space indentation, no tabs, keep lines under ~100 chars, and prefer local helpers over globals.
- Group related settings (options, mappings, autocmds) and leave a blank line between sections for readability.
- Name plugin configs `lua/<plugin_name>.lua` and LSP configs `lua/lsp/<lsp_name>.lua`. Use snake_case for filenames and module identifiers.
- Favor the modern Neovim API (`vim.keymap.set`, `vim.api.nvim_create_autocmd`, `vim.opt`) and avoid legacy commands unless unavoidable.

## Comment style
Keep comments short and to the point. If a comment does not make the code more readable, do not add a comment.

## Testing Guidelines
- Manually exercise key mappings or features touched by a change to confirm they behave as expected.
- For language support updates, open a buffer for each listed language (Python, YAML, JSON, Dockerfile, Go, Markdown, ReST) and verify diagnostics populate via the configured LSP.
- Document any manual verification steps or known limitations in the pull request so reviewers can reproduce your tests.

## Commit & Pull Request Guidelines
There is no formal history yet, so adopt short, imperative commit subjects (`Add window navigation mappings`) and keep bodies under 72 columns when needed. Every pull request should summarize the motivation, list user-facing changes, and mention the validation commands you ran. Link related issues if they exist, and include screenshots or asciinema captures only when UI-facing behavior is affected.
