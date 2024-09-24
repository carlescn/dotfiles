return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
		flavour = "mocha",
		color_overrides = {
			mocha = {
				base = "#1b1b1b",
			},
		},
		-- NOTE: enabling this will force transparency also for all backgrounds, including error highlight text
		-- transparent_background = true,
	},
	init = function()
		vim.cmd.colorscheme("catppuccin")
		-- Set transparency only for normal text
		vim.cmd.highlight({ "Normal", "guibg=None" })
		vim.cmd.highlight({ "NormalNC", "guibg=None" })
	end,
}
