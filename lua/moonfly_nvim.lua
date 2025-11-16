return {
	"bluz71/vim-moonfly-colors",
	name = "moonfly",
	lazy = false,
	priority = 1000,
	config = function(_, opts)
		-- require("moonfly").setup(opts)
		vim.cmd.colorscheme("moonfly")
	end,
}
