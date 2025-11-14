local M = {}

local root_dir = vim.fn.fnamemodify(vim.env.MYVIMRC, ":p:h")
local lazypath = root_dir .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local function plugins()
	return {
		require("mini_statusline"),
		require("conform_nvim"),
	}
end

function M.setup()
	require("lazy").setup(plugins(), {
		defaults = { lazy = false },
		install = { colorscheme = { "habamax" } },
		checker = { enabled = false },
	})
end

return M
