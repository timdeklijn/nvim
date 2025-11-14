return {
	"folke/tokyonight.nvim",
	priority = 1000,
	opts = {
		style = "night",
		styles = {
			sidebars = "dark",
			floats = "dark",
		},
	},
	config = function(_, opts)
		require("tokyonight").setup(opts)
		vim.cmd.colorscheme("tokyonight")
	end,
}
