local M = {}

function M.setup_lua_ls()
	local ok, config = pcall(require, "lsp.lua_ls")
	if not ok then
		vim.notify("Lua LS config missing: " .. config, vim.log.levels.ERROR)
		return
	end
	if vim.lsp.config and vim.lsp.enable then
		vim.lsp.config("lua_ls", config)
		vim.lsp.enable("lua_ls")
	else
		vim.notify("vim.lsp.config() not available; please upgrade Neovim to v0.11 or newer", vim.log.levels.WARN)
	end
end

return M
