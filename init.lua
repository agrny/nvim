vim.g.mapleader = " "
vim.g.maplocalleader = " "

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

require("options")
require("keymaps")
require("autocmds")
require("plugins")
require("lsp")
require("treesitter")

vim.cmd([[colorscheme catppuccin]])
vim.cmd([[
  highlight DiffAdd    guibg=#283b4d guifg=NONE
  highlight DiffChange guibg=#3b314d guifg=NONE
  highlight DiffDelete guibg=#4d2831 guifg=NONE
  highlight DiffText   guibg=#314d3b guifg=NONE
]])
