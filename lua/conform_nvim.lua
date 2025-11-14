return {
	"stevearc/conform.nvim",
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "ruff_fix", "ruff_format" },
			},
			format_on_save = function(bufnr)
				if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
					return
				end
				local filetype = vim.bo[bufnr].filetype
				local lsp_fallback = filetype ~= "python"
				return { timeout_ms = 3000, lsp_fallback = lsp_fallback }
			end,
		})

		vim.keymap.set({ "n", "v" }, "<leader>=", function()
			conform.format({
				lsp_fallback = true,
			})
		end, { desc = "Format buffer" })
	end,
}
