return {
	"hat0uma/csvview.nvim",
	---@module "csvview"
	---@type CsvView.Options
	opts = {
		parser = { comments = { "#", "//" } },
		keymaps = {
			textobject_field_inner = { "if", mode = { "o", "x" } },
			textobject_field_outer = { "af", mode = { "o", "x" } },
			jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
			jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
			jump_next_row = { "<Enter>", mode = { "n", "v" } },
			jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
		},
	},
	-- 1. Keep the cmd loading, but ADD 'ft' so it loads on CSV files too!
	cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
	ft = "csv",

	config = function(_, opts)
		require("csvview").setup(opts)

		-- 2. Use 'BufWinEnter' or 'BufReadPost' instead of 'FileType'.
		-- Since Lazy loads the plugin *after* the FileType event has already fired
		-- for this specific file, a standard 'FileType' autocmd won't catch the current buffer.
		vim.api.nvim_create_autocmd({ "BufReadPost", "BufWinEnter" }, {
			pattern = "*.csv",
			callback = function()
				pcall(vim.cmd, "CsvViewToggle")
			end,
		})
	end,
}
