return {
	{
		"stevearc/conform.nvim",
		-- event = 'BufWritePre', -- uncomment for format on save
		opts = require("configs.conform"),
	},

	-- These are some examples, uncomment them if you want to see them work!
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.lspconfig")
		end,
	},

	{
		"github/copilot.vim",
		lazy = false,
		config = function()
			vim.g.copilot_no_tab_map = true
			vim.g.copilot_assume_mapped = true
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
	},
	{
		"nvim-orgmode/orgmode",
		event = "VeryLazy",
		ft = { "org" },
		config = function()
			-- Setup orgmode
			require("orgmode").setup({
				org_agenda_files = "~/orgfiles/**/*",
				org_default_notes_file = "~/orgfiles/refile.org",
				org_capture_templates = {
					t = {
						description = "Project TODO", -- shows up when picking template
						template = "* TODO %?\n  %u\n  :PROJ: %^{Project}:",
						target = "~/org/refile.org", -- file to save the captured TODO
					},
					n = {
						description = "Note",
						template = "* %?\n  %u", -- generic note template
						target = "~/org/notes.org",
					},
				},
			})

			-- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
			-- add ~org~ to ignore_install
			-- require('nvim-treesitter.configs').setup({
			--   ensure_installed = 'all',
			--   ignore_install = { 'org' },
			-- })
		end,
	},
	{
		"nvim-orgmode/telescope-orgmode.nvim",
		event = "VeryLazy",
		dependencies = {
			"nvim-orgmode/orgmode",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("telescope").load_extension("orgmode")
		end,
	},
	{
		"pablos123/shellcheck.nvim",
		config = function()
			require("shellcheck-nvim").setup({
				shellcheck_options = { "-x", "--enable=all" },
			})
		end,
	},
	-- {
	-- 	"neovim/nvim-lspconfig",
	-- 	opts = {
	-- 		servers = {
	-- 			bashls = {}, -- Enables bash-language-server
	-- 		},
	-- 	},
	-- },
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.diagnostics.shellcheck,
				},
			})
		end,
		{
			"stevearc/oil.nvim",
			---@module 'oil'
			---@type oil.SetupOpts
			opts = {},
			-- Optional dependencies
			dependencies = { { "echasnovski/mini.icons", opts = {} } },
			-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
			-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
			lazy = false,
		},
		{
			"refractalize/oil-git-status.nvim",

			dependencies = {
				"stevearc/oil.nvim",
			},

			config = true,
		},
		{
			"kylechui/nvim-surround",
			version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
			event = "VeryLazy",
			config = function()
				require("nvim-surround").setup({
					-- Configuration here, or leave empty to use defaults
				})
			end,
		},
		{
			"nvim-tree/nvim-tree.lua",
			enabled = false, -- This line disables nvim-tree
		},
	},
	-- test new blink
	-- { import = "nvchad.blink.lazyspec" },

	-- {
	-- 	"nvim-treesitter/nvim-treesitter",
	-- 	opts = {
	-- 		ensure_installed = {
	-- 			"vim", "lua", "vimdoc",
	--      "html", "css"
	-- 		},
	-- 	},
	-- },
}
