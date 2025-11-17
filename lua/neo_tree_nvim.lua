return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{
			"<leader>fe",
			function()
				require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd() })
			end,
			desc = "File Explorer (neo-tree)",
		},
	},
	opts = {
		close_if_last_window = true,
		window = { position = "right" },
		filesystem = {
			hijack_netrw_behavior = "open_default",
		},
	},
}
