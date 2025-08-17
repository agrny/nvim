require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls" , "gopls", "clangd", "bashls"}
vim.lsp.enable(servers)
