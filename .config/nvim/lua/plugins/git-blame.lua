return {
	"f-person/git-blame.nvim",
	event = "VeryLazy",
	opts = {
		enabled = false,
	},
	init = function()
		vim.keymap.set("n", "<leader>gb", ":GitBlameToggle<CR>", { desc = "Toggle Git Blame" })
	end,
}
