require "nvchad.mappings"
local map = vim.keymap.set

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
vim.keymap.set("x", "<leader>rr", [[:s/<C-r><C-w>//g<Left><Left>]], { noremap = true, silent = false , desc="replace in visual selection"})
-- Visual mode: replace selection globally in file
vim.keymap.set("x", "<leader>R", [[:<C-u>%s/<C-r>0//g<Left><Left>]], { noremap = true, silent = false
})

