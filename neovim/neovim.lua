-- helper function
function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command, { noremap = true, silent = true })
end

-- basics
vim.o.number = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.clipboard = "unnamedplus"
vim.o.mouse = false
vim.o.undofile = true
vim.o.completeopt = "menu"
vim.api.nvim_command("filetype plugin indent on")
vim.o.updatetime = 300
vim.o.pumheight = 8
vim.g.netrw_browsex_viewer = "firefox"
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.autochdir = true

-- mappings
map("n", "<Tab>", "==")
map("n", "<Space>tl", ":set wrap!<CR>")
map("n", "<Space>tL", ":set linebreak!<CR>")
map("n", "<Space><Space>", ":")
map("n", "<Space>tn", ":set invnumber<CR>")
map("n", "<Space>fr", ":edit<CR>")
map("n", "<Space>tw", ":set list!<CR>")
map("n", "<Space>fs", ":update<CR>")
map("n", "<Space>qq", ":quit<CR>")
map("n", "<Space>sc", ":noh<CR>")
map("n", "<Space><Tab>", ":e#<CR>")
map("n", "<Space>tc", ":ColorizerToggle<CR>")
map("n", "H", ":bprev<CR>")
map("n", "L", ":bnext<CR>")
map("n", "<Space>bd", ":bd<CR>")
map("n", "<Space>ip", "i£<Esc>")
map("n", "<Space>id", "i$<Esc>")
map("n", "<Space>wj", "<C-W>j")
map("n", "<Space>wk", "<C-W>k")
map("n", "<Space>wh", "<C-W>h")
map("n", "<Space>wl", "<C-W>l")
map("n", "<Space>w/", "<C-W>v")
map("n", "<Space>wm", "<C-W>o")
map("n", "<Space>ww", "<C-W>=")
map("n", "<Space>wd", ":clo<CR>")
map("n", "<Space>wi", ":vertical resize +5<CR>")
map("n", "<Space>wu", ":vertical resize -5<CR>")
map("i", "kj", "<Esc>")
vim.opt.listchars = {eol = "$", tab = ">-", trail = "~",
  extends = ">", precedes = "<", space = "·"}

-- colors
vim.o.syntax = true
vim.o.termguicolors = true
vim.g.dracula_colorterm = 0
vim.cmd("color dracula")
vim.cmd("hi normal guibg=#181a26")

vim.cmd("hi StatusLine guibg=#6272a4 guifg=#f8f8f2")
vim.cmd("hi Visual guibg=#f1fa8c guifg=#000000")
vim.cmd("hi MatchParen guifg=#8be9ff gui=bold")
vim.cmd("hi ErrorMsg guifg=#ff8833 guibg=#181a26 gui=bold")
vim.cmd("hi vimCommand gui=bold guifg=#ff79c6")
vim.cmd("hi ExtraWhitespace guibg=#6272a4")
vim.cmd("match ExtraWhitespace /\\s\\+$/")

-- cursor
vim.o.cursorline = true
vim.cmd("hi CursorOrange guibg=#ef982c")
vim.cmd("hi CursorWhite guibg=#f8f8f2")
vim.cmd("hi CursorGreen guibg=#50fa7b")
vim.cmd("hi CursorInsert guifg=black guibg=#50fa7b")
vim.cmd("hi CursorPending guifg=black guibg=#ef982c")
vim.cmd("hi CursorLine guibg=#292c3f")
vim.cmd("hi CursorLineNr guifg=#6272a4 gui=NONE")
vim.cmd("set guicursor=n-v:block-CursorOrange")
vim.cmd("set guicursor+=c:block-CursorWhite")
vim.cmd("set guicursor+=r:block-CursorGreen")
vim.cmd("set guicursor+=o:hor50-CursorPending")
vim.cmd("set guicursor+=i:ver100-CursorInsert")
vim.cmd("set guicursor+=a:blinkwait300-blinkon200-blinkoff150")

-- git conflicts
map("n", "gc", "/=======\\|<<<<<<<\\|>>>>>>><CR>")
vim.cmd("hi gitconfigSection guifg=#ff79c6 gui=bold")

-- trim whitespace
map("n", "<Space>tt", ":let _s=@/<Bar>:%s/\\s\\+$//e<Bar>:let @/=_s<Bar><CR>")

-- snippets
vim.cmd("imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ?" ..
    "'<Plug>luasnip-expand-or-jump' : '<Tab>'")
vim.cmd("inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>")

-- startify
vim.g.startify_padding_left = 6
vim.g.startify_enable_special = 0
vim.g.startify_lists = {{type = "commands", header = {}}}
vim.g.startify_custom_header = {
    "                                                        ",
    "     ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
    "     ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
    "     ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
    "     ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
    "     ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
    "     ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
    " "
}

-- fzf
map("n", "<Space>ff", ":lua require'fzf-lua'.files({prompt='Files> '}) <CR>")
map("n", "<Space>fa", ":lua require'fzf-lua'.files({prompt='All files> '," ..
    "cmd = \"fd -H . ~/github ~/overleaf ~/downloads ~/rclone ~/tmp" ..
    "-t f" ..
    "-E '*.jld' -E '*.pdf' -E '*.gz' -E '*.cloud' -E '*.cloudf' -E '*.PDF'" ..
    "-E '*.png' -E '*.sqlite' -E '*.zip' -E '*.jpg' -E '*.jpeg' -E '*.mp3'" ..
    "-E '*.po' -E '*.fdb_latexmk' -E '*.mat' -E '*.jsonlz4' -E '*.mp4'" ..
    "-E '*.pptx' -E '*.bin' -E '*.gif' -E '*.HEIC' -E '*.MOV' -E '*.PNG'" ..
    "-E '*.JPG' -E '*.mov' -E '/vendor/*' -E '/target/*' -E '*.m4a'" ..
    "-E '*.docx' -E '*.xlsx' -E '*.ppt' -E '*.log' -E '*.eps' -E '*.aux'" ..
    "-E '*.p' -E '*.fig'\"" ..
    "}) <CR>")
map("n", "<Space>pf", ":lua require'fzf-lua'.git_files({prompt='Project files> '," ..
    "cwd = '`git rev-parse --show-toplevel`'," ..
    "show_cwd_header=false}) <CR>")
map("n", "<Space>bb", ":lua require'fzf-lua'.oldfiles({prompt='Recent files> '," ..
    "file_ignore_patterns = { '%COMMIT_EDITMSG$' }," ..
    "include_current_session=true}) <CR>")
map("n", "<Space>gc", ":lua require'fzf-lua'.git_commits({prompt='Commits> '," ..
    "show_cwd_header=false}) <CR>")
map("n", "<Space>/", ":lua require'fzf-lua'.grep_project({prompt='Project> '," ..
    "cwd = '`git rev-parse --show-toplevel`'," ..
    "no_header_i=true, no_header=true}) <CR>")

-- latex
vim.g.vimtex_view_method = "zathura"

-- gitgutter
vim.g.gitgutter_enabled = false
vim.g.gitgutter_map_keys = false
map("n", "<Space>gg", ":GitGutterToggle <CR>")

-- make
map("n", "<Space>mm", ":NeomakeSh make <CR>")
map("n", "<Space>mc", ":NeomakeSh make clean <CR>")
map("n", "<Space>mf", ":update <CR> :silent! make format <CR> :edit<CR>")

-- leap
vim.cmd("hi LeapBackdrop guifg=#6272a4 guibg=NONE gui=NONE")
vim.cmd("hi LeapLabelPrimary guifg=#50fa7b guibg=NONE gui=bold")
require('leap').opts.safe_labels = {}
vim.keymap.set('n', 'F', function ()
    local current_window = vim.fn.win_getid()
    require('leap').leap { target_windows = { current_window } }
end)

-- todo highlighting
vim.cmd("hi Todo guifg=#FF7722 guibg=NONE gui=bold")
vim.cmd("hi Now guifg=#8be9fd guibg=NONE gui=bold")
vim.cmd("hi Note guifg=#ffff22 guibg=NONE gui=bold")
vim.cmd("hi Done guifg=#00dd00 guibg=NONE gui=bold")
vim.cmd("hi Later guifg=#6272a4 guibg=NONE gui=bold")
vim.cmd("hi No guifg=#ff3333 guibg=NONE gui=bold")
vim.cmd("call matchadd('Todo', 'TODO\\|BUG\\|\\\\TODO', -1)")
vim.cmd("call matchadd('Done', 'DONE\\|YES', -1)")
vim.cmd("call matchadd('Now', 'NOW', -1)")
vim.cmd("call matchadd('Note', 'NOTE\\|BOUGHT\\|ARRIVED\\|CHECK\\|BASKET\\|WRAPPED\\|MAYBE\\|DRAFT\\|EMAILED', -1)")
vim.cmd("call matchadd('Later', 'LATER', -1)")
vim.cmd("call matchadd('No', 'NO\\s', -1)")

-- lastplace
vim.g.lastplace_ignore = "gitcommit,gitrebase,svn,hgcommit,mail"

-- org mode
require('orgmode').setup_ts_grammar()
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

-- autopair
require("nvim-autopairs").setup {}

-- colorizer
require 'colorizer'.setup()

-- lualine
local custom_dracula = require('lualine.themes.dracula')
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
    options = {theme  = custom_dracula, icons_enabled = false},
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff'},
        lualine_c = {'filename'},
        lualine_x = {'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'},
    },
}

-- luasnip with snipmate
require("luasnip").setup({update_events = {"TextChanged", "TextChangedI"}, history = true})
require("luasnip.loaders.from_snipmate").lazy_load({paths = "./snippets"})

-- autocompletion with nvim_cmp
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

--[[
" get highlight group at point
function! SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
command SynStack call SynStack()
nnoremap <Space>hg :SynStack<CR>

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
]]
