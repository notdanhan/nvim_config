-- Set leader key before anything else
vim.g.mapleader = [[]]
vim.g.maplocalleader = [[ ]]

-- Bootstrap using lazy.nvim package manager
require("danhan.core.bootstrap")

-- Personalize Lazy.nvim and Lazy.vim
require("danhan.config.lazy")

-- Apply customizations
vim.cmd.colorscheme(require("danhan.core.constants").colorscheme)
