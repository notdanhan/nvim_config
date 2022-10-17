set nocompatible		  " Disable compat with old vim stuff
set number				  " Show Line numbers
set mouse=a				  " Enable Mouse support
syntax on				  " Syntax Highlighting
set showmatch			  " Show matches froms earch
set hlsearch
set incsearch			  " Incremental Search
set tabstop=4			  " Tab-Indent 4 spaces
set softtabstop=4		  " Backspace on tab goes back 4 spaces
set shiftwidth=4		  " Tab-Indent is 4 spaces
set autoindent			  " Auto-Indent code blocks
set ttyfast				  " Fast Scrolling
set clipboard=unnamedplus " Use system clipboard
filetype plugin indent on

call plug#begin("~/.vim/plugged")
	" File Explorer
	Plug 'scrooloose/nerdtree'    " File explorer
	Plug 'ryanoasis/vim-devicons' " Add Icons to the file explorer (This also requires you to install a nerdfont

	" Code completion/syntax Highlighting
	Plug 'neoclide/coc.nvim', {'branch':'release'}
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

	Plug 'ray-x/go.nvim'

	" Git support
	Plug 'lewis6991/gitsigns.nvim'

	" Pretty themes/ Display stuff
	Plug 'overcache/NeoSolarized' " Pretty theme
	Plug 'morhetz/gruvbox'

	" Visual fluff
	Plug 'ryanoasis/vim-devicons'       " Add icons to nerdtree
	Plug 'kyazdani42/nvim-web-devicons' " Add Icons to feline
	Plug 'fgheng/winbar.nvim'           " Add winbar 
	Plug 'feline-nvim/feline.nvim'      " better status bar
	Plug 'SmiteshP/nvim-navic'          " Icons for winbar
	Plug 'neovim/nvim-lspconfig'        
call plug#end()

" Set theme
if (has("termguicolors"))
	set termguicolors
endif

colorscheme gruvbox

" Set font and encoding
set encoding=UTF-8

lua << EOF

require'nvim-treesitter.configs'.setup {
	ensure_installed = {"c","lua","cpp","go","python"},

	sync_install = false,

	auto_install = true,

	highlight = {
		enable = true,
		additional_vim_highlighting = false,
	},
}

require('go').setup()

require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1,
    follow_files = true
  },

  attach_to_untracked = true,
  current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}

require('winbar').setup({
    enabled = true,

    show_file_path = true,
    show_symbols = true,

    colors = {
        path = '#802320',
        file_name = '#cc241d',
        symbols = '#787272',
    },

    icons = {
        file_icon_default = '',
        seperator = '>',
        editor_state = '●',
        lock_icon = '',
    },

    exclude_filetype = {
        'help',
        'startify',
        'dashboard',
        'packer',
        'neogitstatus',
        'NvimTree',
        'Trouble',
        'alpha',
        'lir',
        'Outline',
        'spectre_panel',
        'toggleterm',
        'qf',
		'bash',
    }
})
require('feline').setup()

EOF

autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
