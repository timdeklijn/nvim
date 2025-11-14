vim.g.mapleader = " "
vim.g.maplocalleader = " "

local root_dir = vim.fn.fnamemodify(vim.env.MYVIMRC, ":p:h")
if not vim.tbl_contains(vim.opt.runtimepath:get(), root_dir) then
	vim.opt.runtimepath:prepend(root_dir)
end
package.path = root_dir .. "/?.lua;" .. root_dir .. "/?/init.lua;" .. package.path
local lsp_setup = require("lsp_setup")

vim.o.relativenumber = true
vim.o.mouse = "a"
vim.o.showmode = false
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.scrolloff = 5
vim.o.confirm = true
vim.o.autoread = true

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	desc = "Check if files changed outside of Neovim",
	command = "checktime",
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
	desc = "Notify when a file is reloaded from disk",
	callback = function()
		vim.notify("File reloaded from disk", vim.log.levels.INFO)
	end,
})

lsp_setup.setup()
require("lazy_setup").setup()
