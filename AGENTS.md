# Repository Guidelines
This is my neovim configuration. I want a config that is mine. It should be minimal, and work for the following languages, when no LSP is provided, assume the default one:

- python (pyright, ruff)
- yaml
- json
- Docker
- Go
- Lua
- Markdown
- ReST

I want to use the lazy package manager to install packages. Installing language servers will be done in my system and should not be configured inside my neovim config.

## Project Structure

- Each plugin should have an own file inside `lua/`.
- Each LSP is configure in an own file inside `lsp/`.
- When appropriate, add `before/ftplugin`

## Build & Validation

- Run `nvim --clean -u init.lua` before pushing to ensure startup succeeds without user-local state.
- Use `nvim --headless -u init.lua "+checkhealth" +qa` to surface missing dependencies or Lua errors.
- Format Lua sources with `stylua init.lua lua lsp` so the style stays consistent across files.

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
