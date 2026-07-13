return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons", -- optional, but recommended
	},
	lazy = false, -- neo-tree will lazily load itself
	config = function()
		require("neo-tree").setup({
			filesystem = {
				filtered_items = {
					-- visible = true, -- Show filtered items instead of hiding them
					-- hide_dotfiles = false, -- Show dotfiles
					-- hide_gitignored = false, -- Optional: show gitignored files
					hide_by_name = {
						"__pycache__",
					},
				},
			},
		})
		vim.keymap.set("n", "<C-b>", ":Neotree filesystem reveal left<CR>", { desc = "Open Neotree filesystem" })
	end,
}
