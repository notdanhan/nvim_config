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

	" Code completion/syntax Highlighting
	Plug 'neoclide/coc.nvim', {'branch':'release'}
	Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
	
	" Go stuff
	Plug 'ray-x/go.nvim'

	" My plugin
	" Plug '~/github/danielh2942/todo.nvim'

	" Git support
	Plug 'lewis6991/gitsigns.nvim'

	" Pretty themes/ Display stuff
	Plug 'sts10/vim-pink-moon'
	Plug 'overcache/NeoSolarized' " Pretty theme
	Plug 'morhetz/gruvbox'
	Plug 'gelguy/wilder.nvim'

	" Visual fluff
	Plug 'ryanoasis/vim-devicons'       "Add icons to nerdtree
	Plug 'kyazdani42/nvim-web-devicons' "Add Icons to feline
	Plug 'fgheng/winbar.nvim'           "Add winbar 
	Plug 'freddiehaddad/feline.nvim'    "better status bar
	Plug 'SmiteshP/nvim-navic'          "Icons for winbar
	Plug 'neovim/nvim-lspconfig'
	Plug 'folke/todo-comments.nvim'		"Some highlight for todos and stuff

	" wakatime
	Plug 'wakatime/vim-wakatime'

	" Telescope
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.2' }
	Plug 'ludovicchabant/vim-gutentags' "Jump to definitions in other files, needs ctags!

	Plug 'sakhnik/nvim-gdb'				"GDB plugin
call plug#end()

" Set theme
if (has("termguicolors"))
	set termguicolors
endif

" colorscheme gruvbox

colorscheme pink-moon

" Set font and encoding
set encoding=UTF-8

lua << EOF

require'nvim-treesitter.configs'.setup {
	ensure_installed = {"c","lua","cpp","go","python","javascript"},

	sync_install = false,

	auto_install = true,

	highlight = {
		enable = true,
		additional_vim_highlighting = false,
	},
}

local wilder = require('wilder')
wilder.setup({modes = {':', '/', '?'}})

wilder.set_option('pipeline', {
  wilder.branch(
    wilder.cmdline_pipeline({
      fuzzy = 1,
      set_pcre2_pattern = 1,
    }),
    wilder.python_search_pipeline({
      pattern = 'fuzzy',
    })
  ),
})

local highlighters = {
  wilder.pcre2_highlighter(),
  wilder.basic_highlighter(),
}
wilder.set_option('renderer', wilder.renderer_mux({
  [':'] = wilder.popupmenu_renderer({
    highlighter = highlighters,
  }),
  ['/'] = wilder.wildmenu_renderer({
    highlighter = highlighters,
  }),
}))

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
    delay = 1,
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
		'',
    }
})
require('feline').setup()

require('todo-comments').setup()

-- Telescope mappings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- ESC out of terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

EOF

" \tt makes a terminal below the window in focus with height 15
nnoremap <leader>tt :rightbelow term<CR>:resize 15<CR>

inoremap <expr> <tab> coc#pum#visible() ? coc#pum#confirm() : "\<TAB>"

autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
