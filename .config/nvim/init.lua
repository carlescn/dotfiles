-- map leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- disable netrw (use nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- enable nerd font
vim.g.have_nerd_font = true

require("options")
require("keymaps")
require("autocommands")
require("lazy-setup")
