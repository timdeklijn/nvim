return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
			},
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				return { timeout_ms = 3000, lsp_fallback = true }
			end,
		})

		vim.keymap.set({ "n", "v" }, "<leader>=", function()
			conform.format({
				lsp_fallback = true,
			})
		end, { desc = "Format buffer" })
	end,
}
