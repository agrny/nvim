
require("nvchad.configs.lspconfig").defaults()

-- Keep the NvChad functions for compatibility
local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- Define configurations using vim.lsp.config() instead of lspconfig.setup()
-- Basic servers
local servers = { "html", "cssls", "clangd", "bashls", "ts_ls" }
for _, lsp in ipairs(servers) do
  vim.lsp.config(lsp, {
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

-- Custom gopls setup
vim.lsp.config('gopls', {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    gopls = {
      gofumpt = true,
      analyses = {
        unusedparams = true,
        shadow = true,
      },
      staticcheck = true,
      completeUnimported = true,
      hoverKind = "FullDocumentation",
    },
  },
})

-- Enable all configured servers
for _, lsp in ipairs(servers) do
  vim.lsp.enable(lsp)
end
vim.lsp.enable('gopls')
