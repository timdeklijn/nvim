local M = {}

local terminal_bufnr = nil

local function find_terminal_win()
	if terminal_bufnr == nil or vim.fn.bufexists(terminal_bufnr) ~= 1 then
		return nil
	end

	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_get_buf(win) == terminal_bufnr then
			return win
		end
	end

	return nil
end

local function open_terminal()
	local existing_win = find_terminal_win()
	if existing_win ~= nil then
		vim.api.nvim_set_current_win(existing_win)
		vim.cmd("startinsert")
		return
	end

	vim.cmd("split")
	vim.cmd("wincmd J")
	vim.cmd("resize 15")

	if terminal_bufnr == nil or vim.fn.bufexists(terminal_bufnr) ~= 1 then
		vim.cmd("terminal")
		terminal_bufnr = vim.api.nvim_get_current_buf()
	else
		vim.cmd(("buffer %d"):format(terminal_bufnr))
	end

	vim.cmd("startinsert")
end

local function hide_terminal()
	local win = find_terminal_win()
	if win ~= nil then
		vim.api.nvim_win_close(win, false)
	end
end

function M.toggle()
	if find_terminal_win() ~= nil then
		hide_terminal()
	else
		open_terminal()
	end
end

function M.setup()
	local group = vim.api.nvim_create_augroup("custom_terminal", { clear = true })
	vim.api.nvim_create_autocmd("TermOpen", {
		group = group,
		desc = "Terminal window UI tweaks",
		callback = function(args)
			local win = vim.fn.bufwinid(args.buf)
			if win == -1 then
				return
			end
			vim.api.nvim_set_option_value("number", false, { win = win })
			vim.api.nvim_set_option_value("relativenumber", false, { win = win })
			vim.api.nvim_set_option_value("signcolumn", "no", { win = win })
		end,
	})

	vim.keymap.set({ "n", "t" }, "<leader>T", M.toggle, { desc = "Toggle terminal" })
end

return M
