-- Uncomment to enable the transparency
-- return {}

return {
	"xiyaowong/transparent.nvim",
	lazy = false, -- Do not lazy-load this so it strips backgrounds immediately on startup
	config = function()
		require("transparent").setup({
			-- This structure handles the primary UI elements
			extra_groups = {
				"NormalFloat", -- Floating windows
				"NvimTreeNormal", -- If you use NvimTree file explorer
				"NeoTreeNormal", -- If you use NeoTree
			},
		})
	end,
}
