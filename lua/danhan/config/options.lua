local options = {
	shiftwidth = 4, -- Tab indent is 4 spaces
	tabstop = 4, -- Tab indent is 4 spaces
	termguicolors = true, -- needs to be set for themes
	mouse = "a", -- Full mouse support
	number = true, -- line numbers
	relativenumber = true, -- have relative numbers above and below
	smartindent = true, -- indent at right times
	hlsearch = true,
	incsearch = true,
	expandtab = false,
	ttyfast = true,
	signcolumn = "yes", -- signs?
	softtabstop = 4, -- Backspace on tab goes back 4 spaces
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

vim.opt.formatoptions:remove("o")

vim.cmd([[set termguicolors]])
vim.cmd([[filetype plugin indent on]])

vim.g.bullets_enabled_file_types = {
	"gitcommit",
	"markdown",
	"scratch",
	"text",
	"wiki",
}
