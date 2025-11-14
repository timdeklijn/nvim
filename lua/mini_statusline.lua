return {
	"echasnovski/mini.statusline",
	version = false,
	config = function()
		require("mini.statusline").setup({
			use_icons = true,
			set_vim_settings = false,
		})
	end,
}
