return {
	"folke/snacks.nvim",
	version = false,
	opts = {
		picker = {
			layout = { preset = "ivy" },
		},
	},
	config = function(_, opts)
		local snacks = require("snacks")
		snacks.setup(opts)

		local picker = snacks.picker
		local map = function(lhs, rhs, desc)
			vim.keymap.set("n", lhs, rhs, { desc = desc })
		end

		map("<leader>f", function()
			picker.files()
		end, "Find files")

		map("<leader>b", function()
			picker.buffers()
		end, "List buffers")

		map("<leader>sg", function()
			picker.grep()
		end, "Search project text")

		map("<leader>sr", function()
			picker.recent()
		end, "Recent files")

		map("<leader>sh", function()
			picker.help()
		end, "Help tags")

		map("<leader>sd", function()
			picker.diagnostics()
		end, "Document diagnostics")

		map("<leader>ss", function()
			picker.lsp_symbols()
		end, "Document symbols")

		map("<leader>sS", function()
			picker.lsp_workspace_symbols()
		end, "Workspace symbols")
	end,
}
