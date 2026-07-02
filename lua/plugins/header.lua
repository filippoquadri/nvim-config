local function insert_copyright_header()
	local bufnr = vim.api.nvim_get_current_buf()

	-- Get the correct comment string for the current filetype
	local comment_string = vim.bo[bufnr].commentstring
	if comment_string == "" then
		comment_string = "# %s"
	end

	local function c_line(text)
		return string.format(comment_string, text)
	end

	-- Configurable details
	local author = "Filippo Quadri <filippo.quadri@epfl.ch>"
	local project = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
	-- Format: YYYY-MM-DD HH:MM:SS
	local datetime = os.date("%Y-%m-%d %H:%M:%S")

	-- Description
	-- local description = vim.fn.input("Enter a quick description: ")
	local description = "xxx"

	-- Build the header array
	local header = {
		c_line("================================================================"),
		c_line(string.format(" Project:     %s", project)),
		c_line(string.format(" Author:      %s", author)),
		c_line(string.format(" Created:     %s", datetime)),
		c_line(string.format(" Updated:     %s", datetime)),
		c_line(string.format(" Description: %s", description)),
		c_line("================================================================"),
		"",
	}

	-- Insert at the very top of the file
	vim.api.nvim_buf_set_lines(bufnr, 0, 0, false, header)
end

-- Autosave
local function update_copyright_timestamp()
	local bufnr = vim.api.nvim_get_current_buf()

	-- Only scan the first 15 lines of the file to save performance
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 15, false)
	local datetime = os.date("%Y-%m-%d %H:%M:%S")

	for i, line in ipairs(lines) do
		-- Search for the word "Updated:" followed by the old timestamp
		if line:match("Updated:%s+%d%d%d%d%-%d%d%-%d%d %d%d:%d%d:%d%d") then
			-- Reconstruct the line, replacing the old timestamp with the new one
			local updated_line = line:gsub("%d%d%d%d%-%d%d%-%d%d %d%d:%d%d:%d%d", datetime)

			-- Apply the change back to the buffer (i - 1 because Lua is 1-indexed, Nvim is 0-indexed)
			vim.api.nvim_buf_set_lines(bufnr, i - 1, i, false, { updated_line })
			break -- Stop searching once we've updated it
		end
	end
end

-- Create an autocommand group so it doesn't duplicate if reloaded
local copyright_group = vim.api.nvim_create_augroup("CopyrightAutoUpdate", { clear = true })

return {
	-- Keymap to trigger header insertion
	vim.keymap.set("n", "<C-M-h>", insert_copyright_header, { desc = "Insert Copyright Header" }),
	-- Trigger 'update_copyright_timestamp' right BEFORE the file is written to disk
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = copyright_group,
		pattern = "*", -- Applies to all file types
		callback = update_copyright_timestamp,
	}),
}
