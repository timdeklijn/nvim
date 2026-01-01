local M = {}

local uv = vim.uv or vim.loop

local function file_exists(path)
	return uv.fs_stat(path) ~= nil
end

function M.in_container()
	if vim.env.NVIM_IN_CONTAINER == "1" then
		return true
	end

	return file_exists("/.dockerenv") or file_exists("/run/.containerenv")
end

return M
