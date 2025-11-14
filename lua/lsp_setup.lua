local M = {}

local function setup_lsp_keymaps()
	local group = vim.api.nvim_create_augroup("custom_lsp_keymaps", { clear = true })
	vim.api.nvim_create_autocmd("LspAttach", {
		group = group,
		desc = "LSP keymaps",
		callback = function(event)
			local bufnr = event.buf
			if vim.b[bufnr].lsp_keymaps_set then
				return
			end
			local map = function(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
			end
			map("n", "gd", vim.lsp.buf.definition, "Go to definition")
			map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
			map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
			map("n", "gr", vim.lsp.buf.references, "List references")
			map("n", "K", vim.lsp.buf.hover, "Hover documentation")
			map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
			map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
			vim.b[bufnr].lsp_keymaps_set = true
		end,
	})
end

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

function M.setup()
	setup_lsp_keymaps()
	M.setup_lua_ls()
end

return M
