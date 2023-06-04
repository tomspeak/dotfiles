return require("packer").startup(function()
	use("wbthomason/packer.nvim")

	use("folke/neodev.nvim")
	require("neodev").setup()

	-- Language Servers
	use({
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"neovim/nvim-lspconfig",
		"onsails/lspkind-nvim",
		"jose-elias-alvarez/null-ls.nvim",
	})

	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("simrat39/rust-tools.nvim")

	-- Lookin' Good.
	-- use("nikolvs/vim-sunbather")
	-- use("sonjapeterson/1989.vim")
	-- use("folke/tokyonight.nvim")
	-- use("rebelot/kanagawa.nvim")
	-- use {
	-- 	"jesseleite/nvim-noirbuddy",
	-- 	requires = { "tjdevries/colorbuddy.nvim", branch = "dev" }
	-- }
	use({ "catppuccin/nvim", as = "catppuccin" })
	use({ 'projekt0n/github-nvim-theme' })

	-- Core Utility
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use("kyazdani42/nvim-tree.lua")
	use({ "nvim-lualine/lualine.nvim", requires = { "j-hui/fidget.nvim" } })
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")

	-- Helpers
	use("windwp/nvim-autopairs")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("numToStr/Comment.nvim")
	use("numToStr/Navigator.nvim")
	use("RRethy/vim-illuminate")

	-- T POPE
	use("tpope/vim-surround")
	use("tpope/vim-repeat")
	use("tpope/vim-sleuth")

	-- Languages
	use { "windwp/nvim-ts-autotag" }
end)
