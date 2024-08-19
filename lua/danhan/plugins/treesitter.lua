return {
	"nvim-treesitter/nvim-treesitter",
	enabled = true,
	cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = { "c", "lua", "cpp", "go" },

			sync_install = false,
			auto_install = true,

			highlight = {
				enable = true,
				additional_vim_highlighting = false,
			},

			indent = { enable = true },
		})
	end,
}
