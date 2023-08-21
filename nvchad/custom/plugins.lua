local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			-- format & linting
			{
				"jose-elias-alvarez/null-ls.nvim",
				config = function()
					require("custom.configs.null-ls")
				end,
			},
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end, -- Override to setup mason-lspconfig
	},

	{
		"hrsh7th/nvim-cmp",
		opts = overrides.cmp,
	},

	-- override plugin configs
	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},

	{
		"nvim-tree/nvim-tree.lua",
		opts = overrides.nvimtree,
	},

	{
		"nvim-telescope/telescope.nvim",
		opts = overrides.telescope,
	},

	-- Install a plugin
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},

	-- the god, tpope
	{
		"tpope/vim-surround",
		lazy = false,
	},
	{
		"tpope/vim-repeat",
		lazy = false,
	},
	{
		"tpope/vim-sleuth",
		lazy = false,
	},
	{
		"tpope/vim-fugitive",
		event = "VeryLazy",
	},

	{
		"tpope/vim-rhubarb",
		event = "VeryLazy",
		dependencies = {
			"tpope/vim-fugitive",
		},
	},

	-- autoclose tags in html, jsx only
	{
		"windwp/nvim-ts-autotag",
		event = "InsertEnter",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},

	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		config = function()
			require("custom.configs.zenmode")
		end,
	},

	{
		"f-person/auto-dark-mode.nvim",
		event = "VeryLazy",

		config = function()
			local auto_dark_mode = require("auto-dark-mode")

			auto_dark_mode.setup({
				update_interval = 10000,
				set_dark_mode = function()
					vim.g.nvchad_theme = "monochrome"
					require("base46").load_all_highlights()
				end,
				set_light_mode = function()
					vim.g.nvchad_theme = "penumbra_light"
					require("base46").load_all_highlights()
				end,
			})

			auto_dark_mode.init()
		end,
	},

	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		config = function()
			require("lspsaga").setup({
				symbol_in_winbar = {
					enable = false,
				},

				ui = {
					theme = "round",
					title = true,
					border = "rounded",
				},

				lightbulb = {
					enable = true,
					enable_in_insert = true,
					sign = false,
					sign_priority = 40,
					virtual_text = true,
				},
			})
		end,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			--Please make sure you install markdown and markdown_inline parser
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},

	{
		"folke/trouble.nvim",
		cmd = "Trouble",
		config = function()
			require("trouble").setup()
		end,
	},

	{
		"rust-lang/rust.vim",
		ft = "rust",
		init = function()
			vim.g.rustfmt_autosave = 1
		end,
	},

	{
		"simrat39/rust-tools.nvim",
		ft = "rust",
		dependencies = "neovim/nvim-lspconfig",
		opt = function()
			return require("configs.rust-tools")
		end,
		config = function(_, opts)
			require("rust-tools").setup(opts)
		end,
	},

	{
		"saecki/crates.nvim",
		ft = { "rust", "toml" },
		config = function(_, opts)
			local crates = require("crates")
			crates.setup(opts)
		end,
	},

	{
		"shellRaining/hlchunk.nvim",
		event = "BufReadPost",
		config = function()
			require("custom.configs.hlchunk")
		end,
	},

	{
		"christoomey/vim-tmux-navigator",
		event = "VeryLazy",
	},

	{
		"nvim-neotest/neotest",
		ft = { "go", "ts" },
		dependencies = {
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-go",
			"haydenmeade/neotest-jest",
		},
		config = function()
			require("custom.configs.neotest")
		end,
	},

	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		event = "LspAttach",
		opts = {
			text = {
				spinner = "pipe",
				done = "+",
				commenced = "Started",
				completed = "Completed",
			},
		},
	},

	{
		"mfussenegger/nvim-dap",
		dependencies = {
			{ "theHamsta/nvim-dap-virtual-text", config = true },
			{ "rcarriga/nvim-dap-ui", config = true },
			{ "leoluz/nvim-dap-go", config = true, ft = "go" },
			"folke/neodev.nvim",
		},
		config = function()
			local dapui = require("dapui")
			local virtual_text = require("nvim-dap-virtual-text")
			local dap_go = require("dap-go")

			dapui.setup()
			virtual_text.setup()
			dap_go.setup()
		end,
	},
}

return plugins
