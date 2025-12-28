local root_markers = {
	"pyproject.toml",
	"ty.toml",
	"setup.py",
	"setup.cfg",
	"requirements.txt",
	"Pipfile",
	"uv.lock",
	".git",
}

return {
	cmd = { "ty", "server" },
	filetypes = { "python" },
	root_markers = root_markers,
	single_file_support = false,
	settings = {
		ty = {},
	},
}
