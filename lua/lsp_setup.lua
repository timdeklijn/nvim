local M = {}

local server_modules = {
	{ name = "lua_ls", module = "lsp.lua_ls" },
	{ name = "pyright", module = "lsp.pyright" },
	{ name = "ruff_lsp", module = "lsp.ruff_lsp" },
	{ name = "gopls", module = "lsp.gopls" },
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if has_cmp then
	capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

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

local function enable_server(server)
	local ok, config = pcall(require, server.module)
	if not ok then
		vim.notify("LSP config missing for " .. server.name .. ": " .. config, vim.log.levels.ERROR)
		return
	end
	if vim.lsp.config and vim.lsp.enable then
		config.capabilities = vim.tbl_deep_extend("force", {}, capabilities, config.capabilities or {})
		vim.lsp.config(server.name, config)
		vim.lsp.enable(server.name)
	else
		vim.notify("vim.lsp.config() not available; please upgrade Neovim to v0.11 or newer", vim.log.levels.WARN)
	end
end

function M.setup()
	setup_lsp_keymaps()
	for _, server in ipairs(server_modules) do
		enable_server(server)
	end
end

return M
