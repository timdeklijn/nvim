local M = {}

function M.organize_imports(bufnr, timeout_ms)
	bufnr = bufnr or vim.api.nvim_get_current_buf()
	-- Ask the LSP for organizeImports code actions on the current buffer.
	local params = vim.tbl_deep_extend("force", {}, vim.lsp.util.make_range_params(nil, bufnr), {
		context = { only = { "source.organizeImports" } },
	})
	local result = vim.lsp.buf_request_sync(bufnr, "textDocument/codeAction", params, timeout_ms or 1000)
	if not result then
		return false
	end
	local applied = false
	for client_id, res in pairs(result) do
		local actions = res.result or {}
		for _, action in ipairs(actions) do
			-- Apply any workspace edits first so imports stay consistent.
			if action.edit then
				local client = vim.lsp.get_client_by_id(client_id)
				local encoding = client and client.offset_encoding or "utf-16"
				vim.lsp.util.apply_workspace_edit(action.edit, encoding)
				applied = true
			end
			local command = action.command or action
			-- Execute follow-up commands (gopls does this for import organization).
			if type(command) == "table" and command.command then
				vim.lsp.buf_request(bufnr, "workspace/executeCommand", command)
				applied = true
			end
		end
	end
	return applied
end

return M
