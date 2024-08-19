-- My personal Lazy setup

require("lazy").setup({
	spec = {
		{ "LazyVim/LazyVim", import = "lazyvim.plugins", opts = require("danhan.config.lazyvim").opts },

		{ import = "danhan.plugins", opts = require("danhan.config.lazyvim").opts },
	},

	build = { warn_on_override = true },

	checker = { enabled = false },

	change_detection = {
		enable = false,
		notify = false,
	},

	defaults = {
		lazy = true,
		version = false,
		autocmds = true,
		keymaps = false,
	},

	install = {
		missing = true,
		colorscheme = { "pink-moon", "default" },
	},

	performance = {
		cache = { enabled = true },
		reset_packpath = true,
		rtp = {
			disabled_plugins = {},
		},
	},

	ui = {
		size = { width = 0.75, height = 0.75 },
		border = "rounded",
		title = "lazy.nvim",
	},
})
