local uv = vim.uv or vim.loop

local root_markers = {
	"pyproject.toml",
	"setup.py",
	"setup.cfg",
	"requirements.txt",
	"Pipfile",
	"pyrightconfig.json",
	".git",
}

local function python_from_venv(root_dir)
	if not root_dir then
		return nil
	end
	local python = vim.fs.joinpath(root_dir, ".venv", "bin", "python")
	local stat = uv.fs_stat(python)
	if stat and stat.type == "file" then
		return python
	end
	return nil
end

return {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = root_markers,
	single_file_support = false,
	before_init = function(_, config)
		local root_dir = config.root_dir or (uv and uv.cwd()) or vim.fn.getcwd()
		config.settings = config.settings or {}
		config.settings.python = config.settings.python or {}
		config.settings.python.venvPath = root_dir
		config.settings.python.venv = ".venv"
		local python = python_from_venv(root_dir)
		if python then
			config.settings.python.pythonPath = python
		end
	end,
	settings = {
		python = {
			analysis = {
				typeCheckingMode = "basic",
				autoImportCompletions = true,
				diagnosticMode = "workspace",
			},
		},
	},
}
