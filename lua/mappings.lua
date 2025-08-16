require "nvchad.mappings"
local map = vim.keymap.set

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
vim.keymap.set("x", "<leader>rr", [[:s/<C-r><C-w>//g<Left><Left>]], { noremap = true, silent = false , desc="replace in visual selection"})
-- Visual mode: replace selection globally in file
vim.keymap.set("x", "<leader>R", [[:<C-u>%s/<C-r>0//g<Left><Left>]], { noremap = true, silent = false
})


vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true , desc=""})

-- -- Open a new Zellij pane and run opencode in the current working directory
vim.keymap.set("n", "<leader>o", function()
  -- local cwd = vim.fn.getcwd()
  vim.fn.jobstart(
    { "zellij", "action", "new-pane", "--cwd" ,"$(pwd)", "--" ,"opencode" },
    { detach = true }
  )
end, { noremap = true, silent = true })


-- TODO: Opens new tab but doesnt run command in it
-- vim.keymap.set("n", "<leader>O", function()
--   -- local cwd = vim.fn.getcwd()
--   vim.fn.jobstart(
--     { "zellij", "action", "new-tab" },
--     { detach = true }
--   )
--  vim.fn.jobstart({ "zellij", "action", "focus-next-tab" }, { detach = true })
--   vim.fn.jobstart(
--     { "zellij", "action", "run" , "--command", "opencode"} ,
--     { detach = true }
--   )
-- end, { noremap = true, silent = true })
