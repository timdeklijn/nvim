local root_markers = {
	"mix.exs",
	"mix.lock",
	".git",
}

return {
	cmd = { "elixir-ls" },
	filetypes = { "elixir", "eelixir", "exs", "heex" },
	root_markers = root_markers,
	settings = {
		elixirLS = {
			dialyzerEnabled = false,
			fetchDeps = false,
			suggestSpecs = true,
		},
	},
}
