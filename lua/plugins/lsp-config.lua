return {
	{
		"mason-org/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason-lspconfig").setup({
				-- ensure_installed = { "lua_ls", "pyright", "vhdl_ls", "svls" },
				ensure_installed = { "lua_ls", "pylsp", "vhdl_ls", "svls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			vim.diagnostic.config({
				virtual_text = true,
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- vim.lsp.config("lua_ls", {
			-- 	capabilities = capabilities,
			-- 	settings = {
			-- 		Lua = {
			-- 			diagnostics = { globals = { "vim" } },
			-- 		},
			-- 	},
			-- })

			vim.lsp.config("lua_ls", {
				capabilities = capabilities, -- Placed at ROOT level, not inside settings
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
					},
				},
			})

			vim.lsp.config("pylsp", {
				capabilities = capabilities,
				settings = {
					pylsp = {
						plugins = {
							pyflakes = { enabled = false },
							pycodestyle = { enabled = false },
							autopep8 = { enabled = false },
							yapf = { enabled = false },
							mccabe = { enabled = false },
							-- pylint = { enabled = true },
							pylsp_mypy = { enabled = false },
							pylsp_black = { enabled = false },
							pylsp_isort = { enabled = false },
						},
					},
				},
			})

			--vim.lsp.config("pyright", {
			--	capabilities = capabilities,
			--})
			-- vim.lsp.config("vhdl_ls", {})

			-- vim.lsp.config("svls", {
			-- 	cmd = { "svls" },
			-- 	filetypes = { "verilog", "systemverilog" },

			-- 	root_markers = { "svls.toml", ".svls.toml", ".git" },

			-- 	settings = {
			-- 		systemverilog = {
			-- 			includeIndexing = true,
			-- 		},
			-- 	},
			-- })

			vim.lsp.enable("svls")

			vim.lsp.enable("lua_ls")
			vim.lsp.enable("pylsp")
			-- vim.lsp.enable("pyright")
			-- vim.lsp.enable("vhdl_ls")

			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
		end,
	},
}
