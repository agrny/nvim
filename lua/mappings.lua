require("nvchad.mappings")
local map = vim.keymap.set

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("t", "<leader>tt", [[<C-\><C-n>]], { noremap = true, silent = true, desc = "Exit terminal mode" })
-- Copilot Suggestion Acceptance Key
map("i", "<C-l>", function()
	vim.fn.feedkeys(vim.fn["copilot#Accept"](), "")
end, { desc = "Copilot Accept", noremap = true, silent = true })

vim.keymap.set(
	"x",
	"<leader>rr",
	[[:s/<C-r><C-w>//g<Left><Left>]],
	{ noremap = true, silent = false, desc = "replace in visual selection" }
)
-- Visual mode: replace selection globally in file
vim.keymap.set("x", "<leader>R", [[:<C-u>%s/<C-r>0//g<Left><Left>]], { noremap = true, silent = false })

vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "" })

-- Open a new Zellij pane and run opencode in the current working directory
vim.keymap.set("n", "<leader>u", function()
	-- local cwd = vim.fn.getcwd()
	vim.fn.jobstart({ "zellij", "action", "new-pane", "--cwd", "$(pwd)", "--", "opencode" }, { detach = true })
end, { noremap = true, silent = true })

vim.keymap.set("n", "<leader>op", require("telescope").extensions.orgmode.search_headings)

vim.keymap.set("n", "<leader>gd", ":Copilot disable<CR>", {noremap = true, silent=true, desc="Disable Copilot"})
vim.keymap.set("n", "<leader>ge", ":Copilot enable<CR>", {noremap = true, silent=true, desc="Enable Copilot"})
