local root_markers = {
	"pyproject.toml",
	"setup.py",
	"setup.cfg",
	"requirements.txt",
	"Pipfile",
	"ruff.toml",
	".git",
}

return {
	cmd = { "ruff-lsp" },
	filetypes = { "python" },
	root_markers = root_markers,
	single_file_support = true,
	init_options = {
		settings = {
			logLevel = "error",
		},
	},
	settings = {
		args = {},
	},
}
