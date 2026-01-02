local root_markers = {
	"mix.exs",
	"mix.lock",
	".git",
}

return {
	cmd = { "expert", "--stdio" },
	filetypes = { "elixir", "eelixir", "exs", "heex" },
	root_markers = root_markers,
}
