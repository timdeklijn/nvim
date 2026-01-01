local M = {}

local uv = vim.uv or vim.loop

local function file_exists(path)
	return uv.fs_stat(path) ~= nil
end

function M.in_container()
	return file_exists("/.dockerenv")
end

return M
