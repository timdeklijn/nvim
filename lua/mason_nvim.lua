local env = require("env")

local function ensure_installed(packages)
	local ok, registry = pcall(require, "mason-registry")
	if not ok then
		return
	end

	local notified = false

	for _, package_name in ipairs(packages) do
		local ok_pkg, pkg = pcall(registry.get_package, package_name)
		if ok_pkg and pkg and not pkg:is_installed() then
			if not notified then
				notified = true
				vim.notify("Installing LSP tools via Mason (first run in container)", vim.log.levels.INFO)
			end
			pkg:install()
		end
	end
end

return {
	"williamboman/mason.nvim",
	-- Only use mason if this config is loaded inside a container.
	enabled = env.in_container(),
	config = function()
		require("mason").setup({
			PATH = "prepend",
		})

		ensure_installed({
			"docker-language-server",
			"expert",
			"gopls",
			"jq",
			"json-lsp",
			"ruff-lsp",
			"rust-analyzer",
			"ty",
			"yaml-language-server",
		})
	end,
}
