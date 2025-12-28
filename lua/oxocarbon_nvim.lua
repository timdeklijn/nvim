---@diagnostic disable: undefined-global
return {
	"nyoom-engineering/oxocarbon.nvim",
	name = "oxocarbon",
	lazy = false,
	priority = 1000,
	config = function()
		vim.cmd.colorscheme("oxocarbon")
	end,
}
