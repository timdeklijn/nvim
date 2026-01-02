return {
	"Mofiqul/vscode.nvim",
	name = "vscode",
	lazy = false,
	priority = 1000,
	config = function()
		require("vscode").setup({
			transparent = false,
			italic_comments = true,
		})

		local function match_gutter_bg()
			local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
			local bg = normal.bg or "NONE"

			local gutter_groups = {
				"SignColumn",
				"FoldColumn",
				"LineNr",
				"LineNrAbove",
				"LineNrBelow",
				"CursorLineNr",
				"CursorLineFold",
				"CursorLineSign",
			}

			for _, hl_group in ipairs(gutter_groups) do
				vim.api.nvim_set_hl(0, hl_group, { bg = bg })
			end

			local sign_groups = {
				"DiagnosticSignError",
				"DiagnosticSignWarn",
				"DiagnosticSignInfo",
				"DiagnosticSignHint",
				"GitSignsAdd",
				"GitSignsChange",
				"GitSignsDelete",
			}

			for _, hl_group in ipairs(sign_groups) do
				vim.api.nvim_set_hl(0, hl_group, { bg = bg })
			end
		end

		local group = vim.api.nvim_create_augroup("gutter-bg-match", { clear = true })
		vim.api.nvim_create_autocmd("ColorScheme", {
			group = group,
			callback = match_gutter_bg,
		})

		vim.cmd.colorscheme("vscode")
		match_gutter_bg()
	end,
}
