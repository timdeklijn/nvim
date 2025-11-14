return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"python",
				"yaml",
				"json",
				"dockerfile",
				"go",
				"lua",
				"markdown",
				"markdown_inline",
				"rst",
				"gitcommit",
			},
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
