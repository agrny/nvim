-- custom/configs/lspconfig.lua

-- Standard NvChad imports
local lspconfig = require("lspconfig")
local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

-- List of LSP servers you want default setup for (Mason installs them)
local servers = { "html", "cssls", "clangd" }

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
			gofumpt = true, -- stricter formatting
			analyses = {
				unusedparams = true,
				shadow = true,
			},
			staticcheck = true,
            -- usePlaceholders = true, -- for better completions
            completeUnimported = true, -- complete unimported packages
            hoverKind = "FullDocumentation", -- show full documentation on hoverKind
		},
	},
})
