" vim-plug plugins
call plug#begin()
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'ggandor/leap.nvim'
Plug 'tpope/vim-repeat'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-orgmode/orgmode'
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'windwp/nvim-autopairs'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'lervag/vimtex'
Plug 'aymericbeaumet/vim-symlink'
Plug 'nvim-lualine/lualine.nvim'
Plug 'mhinz/vim-startify'
Plug 'neomake/neomake'
Plug 'L3MON4D3/LuaSnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'lukas-reineke/cmp-rg'
Plug 'airblade/vim-gitgutter'
Plug 'farmergreg/vim-lastplace'
Plug 'hrsh7th/cmp-omni'
call plug#end()

" ignore missing language providers
let loaded_python3_provider = 0
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0

" dracula theme
syntax on
set termguicolors
let g:dracula_italic=0
let g:dracula_colorterm = 0
color dracula
hi StatusLine guibg=#6272a4 guifg=#f8f8f2
hi Visual guibg=#f1fa8c guifg=#000000
hi MatchParen guifg=#8be9ff gui=bold
hi ErrorMsg guifg=#ff8833 guibg=#181a26 gui=bold
hi vimCommand gui=bold guifg=#ff79c6
hi ExtraWhitespace guibg=#6272a4
match ExtraWhitespace /\s\+$/

" Background       #282a36
" My background    #181a26
" Current Line     #44475a
" Selection        #44475a
" Foreground       #f8f8f2
" Comment          #6272a4
" Cyan             #8be9fd
" Green            #50fa7b
" Orange           #ffb86c
" Pink             #ff79c6
" Purple           #bd93f9
" Red              #ff5555
" Yellow           #f1fa8c
" Alert            #ff7722
" Bright Yellow    #ffff22
" Bright Green     #00dd00

" basics
set number
set ignorecase
set smartcase
set undofile
set clipboard=unnamedplus
set mouse=
nnoremap z; za
filetype plugin indent on
set completeopt=menu
nnoremap <Tab> ==
nnoremap <Space>pi :PlugInstall<CR>
nnoremap <Space>pu :PlugUpdate<CR>
nnoremap <Space>tl :set wrap!<CR>
nnoremap <Space>tL :set linebreak!<CR>
nnoremap <Space><Space> :
nnoremap <Space>tn :set invnumber<CR>
nnoremap <Space>fr :edit<CR>
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<,space:·
nnoremap <Space>tw :set list!<CR>
nnoremap <Space>or :!firefox_refresh <CR><CR>
let g:yankring_clipboard_monitor=0
nnoremap <Space>fs :update<CR>
nnoremap <Space>qq :quit<CR>
inoremap kj <Esc>
nnoremap <Space>sc :noh<CR>
nnoremap <Space><Tab> :e#<CR>
let g:netrw_browsex_viewer = 'firefox'
nnoremap <Space>tc :ColorizerToggle<CR>
nnoremap <silent> <Space>rr :source $MYVIMRC<CR>
set updatetime=300
set pumheight=8
nnoremap H :bprev<CR>
nnoremap L :bnext<CR>
nnoremap <Space>bd :bd<CR>

" indent
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent

" cursor
set cursorline
hi CursorOrange guibg=#ef982c
hi CursorWhite guibg=#f8f8f2
hi CursorGreen guibg=#50fa7b
hi CursorInsert guifg=black guibg=#50fa7b
hi CursorPending guifg=black guibg=#ef982c
hi CursorLine guibg=#292c3f
hi CursorLineNr guifg=#6272a4 gui=NONE
set guicursor=n-v:block-CursorOrange
set guicursor+=c:block-CursorWhite
set guicursor+=r:block-CursorGreen
set guicursor+=o:hor50-CursorPending
set guicursor+=i:ver100-CursorInsert
set guicursor+=a:blinkwait300-blinkon200-blinkoff150

" git conflicts
nnoremap gc /=======\\|<<<<<<<\\|>>>>>>><CR>
hi gitconfigSection guifg=#ff79c6 gui=bold

" tex with zathura
let g:vimtex_view_method = 'zathura'

" get highlight group at point
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
command SynStack call SynStack()
nnoremap <Space>hg :SynStack<CR>

" fzf
set autochdir
nnoremap <Space>ff :lua require'fzf-lua'.files({prompt="Files> "}) <CR>
nnoremap <Space>fa :lua require'fzf-lua'.files({prompt="All files> ",
  \ cmd = "fd -H . ~/Documents ~/Downloads ~/odrive ~/tmp
  \ -t f
  \ -E '*.jld' -E '*.pdf' -E '*.gz' -E '*.cloud' -E '*.cloudf' -E '*.PDF'
  \ -E '*.png' -E '*.sqlite' -E '*.zip' -E '*.jpg' -E '*.jpeg' -E '*.mp3'
  \ -E '*.po' -E '*.fdb_latexmk' -E '*.mat' -E '*.jsonlz4' -E '*.mp4'
  \ -E '*.pptx' -E '*.bin' -E '*.gif' -E '*.HEIC' -E '*.MOV' -E '*.PNG'
  \ -E '*.JPG' -E '*.mov' -E '/vendor/*' -E '/target/*' -E '*.m4a'
  \ -E '*.docx' -E '*.xlsx' -E '*.ppt' -E '*.log' -E '*.eps' -E '*.aux'
  \ -E '*.p' -E '*.fig'"
  \ }) <CR>
nnoremap <Space>pf :lua require'fzf-lua'.git_files({prompt="Project files> ",
  \ cwd = "`git rev-parse --show-toplevel`",
  \ show_cwd_header=false}) <CR>
nnoremap <Space>bb :lua require'fzf-lua'.oldfiles({prompt="Recent files> ",
  \ file_ignore_patterns = { "%COMMIT_EDITMSG$" },
  \ include_current_session=true}) <CR>
nnoremap <Space>gc :lua require'fzf-lua'.git_commits({prompt="Commits> ",
  \ show_cwd_header=false}) <CR>
nnoremap <Space>fc :e ~/Documents/github/dotfiles/neovim/init.vim <CR>
nnoremap <Space>/ :lua require'fzf-lua'.grep_project({prompt="Project> ",
  \ cwd = "`git rev-parse --show-toplevel`",
  \ no_header_i=true, no_header=true}) <CR>

" startify
let g:startify_padding_left = 6
let g:startify_lists = [{'type': 'commands', 'header': []}]
let g:startify_enable_special = 0
let g:startify_commands = [
  \ {'n': ['New buffer', ':enew']},
  \ {'c': ['Config file', ':e ~/Documents/github/dotfiles/neovim/init.vim']},
  \ {'q': ['Quit', ':q']},
\ ]
let g:startify_custom_header = [
  \ '                                                        ',
  \ '     ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ',
  \ '     ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ',
  \ '     ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ',
  \ '     ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ',
  \ '     ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ',
  \ '     ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ',
\ ]

" gitgutter
let g:gitgutter_enabled = 0
let g:gitgutter_map_keys = 0
nnoremap <Space>gg :GitGutterToggle <CR>

" trim trailing whitespace
function! <SID>StripTrailingWhitespaces()
  if !&binary && &filetype != 'diff'
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
  endif
endfun

" do not trim mail, gitcommit
autocmd FileType tex,julia,python,text,org,sh,vim,yaml,snippet,rust,bib
  \ autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" check spelling under cursor
function! CheckSpellingUnderCursor ( )
    let word = expand("<cword>")
    let check = system("spell_check_word '" . word . "'")
    echom check
endfunction
command CheckSpellingUnderCursor call CheckSpellingUnderCursor()
nnoremap <Space>cs :CheckSpellingUnderCursor<CR>

" go to longest line
function! GoToLongestLine ( )
  let maxlength   = 0
  let linenumber  = 1
  let longestlinenumber  = 1
  while linenumber <= line("$")
    exe ":".linenumber
    let linelength  = virtcol("$")
    if maxlength < linelength
      let maxlength = linelength
      let longestlinenumber = linenumber
    endif
    let linenumber = linenumber+1
  endwhile
  exe ":".longestlinenumber
  normal $
endfunction
command GoToLongestLine call GoToLongestLine()
nnoremap gl :GoToLongestLine<CR>

" make
nnoremap <Space>mm :NeomakeSh make <CR>
nnoremap <Space>mc :NeomakeSh make clean <CR>
nnoremap <Space>mf :update <CR> :silent! make format <CR> :edit<CR>

" leap
highlight LeapBackdrop guifg=#6272a4 guibg=NONE gui=NONE
highlight LeapLabelPrimary guifg=#50fa7b guibg=NONE gui=bold

" lastplace
let g:lastplace_ignore = "gitcommit,gitrebase,svn,hgcommit,mail"

" insert special symbols
nnoremap <Space>ip i£<Esc>
nnoremap <Space>id i$<Esc>

" windows
nnoremap <Space>wj <C-W>j
nnoremap <Space>wk <C-W>k
nnoremap <Space>wh <C-W>h
nnoremap <Space>wl <C-W>l
nnoremap <Space>w/ <C-W>v
nnoremap <Space>wm <C-W>o
nnoremap <Space>ww <C-W>=
nnoremap <Space>wd :clo<CR>
nnoremap <Space>wi :vertical resize +5<CR>
nnoremap <Space>wu :vertical resize -5<CR>

" todo highlighting
highlight Todo guifg=#FF7722 guibg=NONE gui=bold
highlight Now guifg=#8be9fd guibg=NONE gui=bold
highlight Note guifg=#ffff22 guibg=NONE gui=bold
highlight Done guifg=#00dd00 guibg=NONE gui=bold
highlight Later guifg=#6272a4 guibg=NONE gui=bold
highlight No guifg=#ff3333 guibg=NONE gui=bold
call matchadd('Todo', 'TODO\|BUG\|\\TODO', -1)
call matchadd('Done', 'DONE\|YES', -1)
call matchadd('Now', 'NOW', -1)
call matchadd('Note', 'NOTE\|BOUGHT\|ARRIVED\|CHECK\|BASKET\|WRAPPED\|MAYBE\|DRAFT\|EMAILED', -1)
call matchadd('Later', 'LATER', -1)
call matchadd('No', 'NO\s', -1)

" snippets
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ?
  \ '<Plug>luasnip-expand-or-jump' : '<Tab>'
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>

" org init
"
lua << EOF
require('orgmode').setup_ts_grammar()
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {'org'},
  },
  ensure_installed = {'org'},
}
require('orgmode').setup({
  org_log_done=false,
  org_indent_mode='noindent',
  org_todo_keywords={'TODO(t)', 'NOTE(n)', 'NOW(w)', 'BUG(b)', 'LATER(l)',
    'CHECK(c)', 'YES(Y)', 'NO(N)', 'MAYBE(M)', '|', 'DONE(d)'},
  org_blank_before_new_entry = {
    heading = false,
    plain_list_item = false,
  },
  mappings = {
    org = {
      org_todo = 't',
      org_insert_heading_respect_content = '<C-J>'
    }
  },
})
EOF

" autopair brackets
"
lua << EOF
  require("nvim-autopairs").setup {}
EOF

" colorizer
"
lua << EOF
  require 'colorizer'.setup ({
    '*';
  }, {
    RGB = false,
    names = false,
    RRGGBBAA = true,
  })
EOF

" lualine
"
lua << EOF
local custom_dracula = require'lualine.themes.dracula'
custom_dracula.normal.a.bg = '#ffb86c'
custom_dracula.normal.b.bg = '#44475a'
custom_dracula.normal.c.bg = '#282a36'
custom_dracula.insert.b.bg = '#44475a'
custom_dracula.insert.c.bg = '#282a36'
custom_dracula.visual.b.bg = '#44475a'
custom_dracula.visual.c.bg = '#282a36'
custom_dracula.command.a.bg = '#ff79c6'
custom_dracula.command.b.bg = '#44475a'
custom_dracula.command.c.bg = '#282a36'
require('lualine').setup {
  options = {
    theme  = custom_dracula,
    icons_enabled = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'},
  },
}
EOF

" snippets using LuaSnip with Snipmate
"
lua << EOF
  require("luasnip").setup({
    update_events = {"TextChanged", "TextChangedI"},
    history = true,
  })
  require("luasnip.loaders.from_snipmate").lazy_load({paths = "./snippets"})
EOF

" autocompletion with nvim_cmp
"
lua << EOF
  local luasnip = require("luasnip")
  local cmp = require("cmp")
  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end
  cmp.setup({
   mapping = {
    ["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        local keys = vim.api.nvim_replace_termcodes('<C-X><C-O>', false, false, true)
        vim.api.nvim_feedkeys(keys, "n", {})
      end
    end, { "i", "s" }),
    ["<C-j>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<C-k>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
  },
    sources = cmp.config.sources({
      { name = 'luasnip', keyword_length = 1 },
      { name = 'rg', keyword_length = 3 },
      { name = 'omni', keyword_length = 1 },
    }),
    formatting = {
      format = function(entry, vim_item)
      vim_item.kind = ""
      vim_item.menu = ({
        luasnip = "[snippet]",
        rg = "[ripgrep]",
        omni = "[omnifunc]",
      })[entry.source.name]
      return vim_item
      end
    },
  })
EOF

" leap
"
lua << EOF
require('leap').opts.safe_labels = {}
vim.keymap.set('n', 'F', function ()
  local current_window = vim.fn.win_getid()
  require('leap').leap { target_windows = { current_window } }
end)
EOF
