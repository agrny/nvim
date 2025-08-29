require("nvchad.configs.lspconfig").defaults()

local lspconfig = require("lspconfig")
local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- Basic servers
local servers = { "html", "cssls", "clangd", "bashls"}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

-- Custom gopls setup
lspconfig.gopls.setup({
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
