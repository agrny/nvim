require "nvchad.options"

vim.o.tabstop = 4 -- Number of spaces a tab counts for
vim.o.shiftwidth = 4 -- Number of spaces for auto-indent
vim.o.expandtab = true -- Use spaces instead of tab characters

local backupdir = vim.fn.stdpath("data") .. "/backup//"
vim.opt.backupdir = backupdir
vim.fn.mkdir(backupdir, "p")

local swapdir = vim.fn.stdpath("data") .. "/swap//"
vim.opt.directory = swapdir
vim.fn.mkdir(swapdir, "p")

local undodir = vim.fn.stdpath("data") .. "/undo//"
vim.opt.undodir = undodir
vim.fn.mkdir(undodir, "p")

