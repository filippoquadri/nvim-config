return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.black,

				-- Import sorting
				null_ls.builtins.formatting.isort,

				-- Diagnostics + linting (very fast, modern)
				null_ls.builtins.formatting.ruff,

				-- Optional: type checking
				null_ls.builtins.diagnostics.mypy,

				-- =========================
				-- SYSTEMVERILOG / VERILOG
				-- =========================

				-- Verible formatter
				-- null_ls.builtins.formatting.verible_verilog_format,

				-- Verible linter
				-- null_ls.builtins.diagnostics.verible_verilog_lint,
			},
		})

		vim.keymap.set("n", "<C-I>", vim.lsp.buf.format, {})
	end,
}
