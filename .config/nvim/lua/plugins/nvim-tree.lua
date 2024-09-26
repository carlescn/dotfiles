return {
	"nvim-tree/nvim-tree.lua",
	event = "VimEnter",
	dependencies = {
		{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
	},
	config = function()
		require("nvim-tree").setup({
			disable_netrw = true,
			hijack_netrw = true,
			hijack_cursor = true,
		})
		local api = require("nvim-tree.api")
		vim.keymap.set("n", "<leader>b", api.tree.toggle, { desc = "Toggle NvimTree" })
	end,
}
