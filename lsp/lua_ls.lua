return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = {
		".luarc.json",
		".luarc.jsonc",
		".stylua.toml",
		"stylua.toml",
		".git",
	},
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = {
				globals = { "vim" },
				disable = { "missing-fields" },
			},
			workspace = {
				checkThirdParty = false,
				library = vim.api.nvim_get_runtime_file("", true),
			},
			completion = { callSnippet = "Replace" },
			hint = { enable = true },
			telemetry = { enable = false },
			format = { enable = false },
		},
	},
}
