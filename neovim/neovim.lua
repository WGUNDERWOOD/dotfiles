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
map("n", "<Space>hg", ":Inspect <CR>")
map("i", "kj", "<Esc>")
vim.opt.listchars = {eol = "$", tab = ">-", trail = "~",
  extends = ">", precedes = "<", space = "·"}

-- colors
vim.o.syntax = true
vim.o.termguicolors = true
vim.g.dracula_colorterm = 0
vim.g.dracula_italic = 0
vim.cmd("colorscheme dracula")
vim.cmd("hi normal guibg=#181a26")

vim.cmd("hi StatusLine guibg=#6272a4 guifg=#f8f8f2")
vim.cmd("hi Visual guibg=#f1fa8c guifg=#000000")
vim.cmd("hi MatchParen guifg=#8be9ff gui=bold")
vim.cmd("hi ErrorMsg guifg=#ff8833 guibg=#181a26 gui=bold")
vim.cmd("hi vimCommand gui=bold guifg=#ff79c6")
vim.cmd("hi ExtraWhitespace guibg=#6272a4")
vim.cmd("hi Search guibg=#50fa7b")
vim.cmd("hi Special gui=NONE")
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
require("luasnip.loaders.from_snipmate").lazy_load({paths = "~/github/dotfiles/neovim/snippets"})
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
vim.cmd([[
    augroup startify
    autocmd!
    au Filetype startify hi StartifyHeader gui=bold guifg=#bd93f9
    au Filetype startify hi StartifySection gui=bold guifg=#ff79c6
    au Filetype startify hi StartifyNumber gui=bold guifg=#50fa7b
    au Filetype startify hi ExtraWhitespace guibg=NONE
]])

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
vim.cmd("call matchadd('Note', 'NOTE\\|BOUGHT\\|ARRIVED\\|CHECK\\|BASKET\\|" ..
        "WRAPPED\\|MAYBE\\|DRAFT\\|EMAILED', -1)")
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

-- go to longest line
vim.cmd [[
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

-- check spelling under cursor
vim.cmd [[
    function! CheckSpellingUnderCursor ( )
        let word = expand("<cword>")
        let check = system("spell_check_word '" . word . "'")
        echom check
    endfunction
    command CheckSpellingUnderCursor call CheckSpellingUnderCursor()
    nnoremap <Space>cs :CheckSpellingUnderCursor<CR>
]]

-- bib files
vim.cmd([[
    augroup bib
    autocmd!
    au Filetype bib call matchadd('bibTypeAt', '^@[a-z]', -1)
    au Filetype bib hi bibTypeAt gui=bold guifg=#50fa7b
    au Filetype bib hi bibType gui=bold guifg=#50fa7b
    au Filetype bib hi bibKey gui=bold guifg=#bd93f9
    au Filetype bib hi bibEntryKw gui=bold guifg=#ff79c6
    augroup END
]])

-- shell files
vim.cmd([[
    augroup sh
    autocmd!
    au Filetype sh hi shFunction gui=bold guifg=#50fa7b
    au Filetype sh hi shQuote gui=NONE guifg=#f1fa8c
    au Filetype sh hi shStatement gui=bold guifg=#ff79c6
    au Filetype sh hi shVarAssign gui=bold guifg=#ff79c6
    au Filetype sh hi shFunctionkey gui=bold guifg=#ff79c6
]])

-- rust files
vim.cmd([[
    augroup rust
    autocmd!
    au Filetype rust hi rustFuncName gui=bold guifg=#50fa7b
    au Filetype rust hi rustKeyword gui=bold guifg=#ff79c6
    au Filetype rust hi rustModPath guifg=#8be9fd
    au Filetype rust hi rustRepeat gui=bold guifg=#ff79c6
    au Filetype rust hi rustTypeDef gui=bold guifg=#ff79c6
    au Filetype rust hi rustConditional gui=bold guifg=#ff79c6
    au Filetype rust hi rustStorage gui=bold guifg=#ff79c6
    au Filetype rust hi rustDecNumber guifg=#8be9fd
    au Filetype rust hi rustType guifg=#bd93f9
    au Filetype rust hi rustOperator guifg=#f8f8f2
    au Filetype rust hi rustMacro guifg=#ffb86c
    au Filetype rust hi rustAssert guifg=#ffb86c
    au Filetype rust hi rustAttribute gui=bold guifg=#ffb86c
    au Filetype rust hi rustDerive gui=bold guifg=#ffb86c
    au Filetype rust hi rustStructure gui=bold guifg=#ff79c6
]])

-- julia files
vim.cmd([[
    augroup julia
    autocmd!
    au Filetype julia hi juliaFunctionName gui=bold guifg=#50fa7b
    au Filetype julia hi juliaKeyword gui=bold guifg=#ff79c6
    au Filetype julia hi juliaBlKeyword gui=bold guifg=#ff79c6
    au Filetype julia hi juliaRepeat gui=bold guifg=#ff79c6
    au Filetype julia hi juliaConditional gui=bold guifg=#ff79c6
    au Filetype julia hi juliaComprehensionFor gui=bold guifg=#ff79c6
    au Filetype julia hi juliaComprehensionIf gui=bold guifg=#ff79c6
    au Filetype julia hi juliaInfixKeyword gui=bold guifg=#ff79c6
    au Filetype julia hi juliaWhereKeyword gui=bold guifg=#ff79c6
    au Filetype julia hi juliaType guifg=#bd93f9
    au Filetype julia hi juliaBaseTypeNum guifg=#bd93f9
    au Filetype julia hi juliaBaseTypeString guifg=#bd93f9
    au Filetype julia hi juliaBaseTypeRange guifg=#bd93f9
    au Filetype julia hi juliaBaseTypeArray guifg=#bd93f9
    au Filetype julia hi juliaBaseTypeBasic guifg=#bd93f9
    au Filetype julia hi juliaBaseTypeRound guifg=#bd93f9
    au Filetype julia hi juliaParamType guifg=#bd93f9
    au Filetype julia hi juliaChar guifg=#f1fa8c
    au Filetype julia hi juliaNumber guifg=#8be9fd
    au Filetype julia hi juliaConstNum guifg=#8be9fd
    au Filetype julia hi juliaFloat guifg=#8be9fd
    au Filetype julia hi juliaConstGeneric guifg=#8be9fd
    au Filetype julia hi juliaRangeKeyword guifg=#8be9fd
    au Filetype julia hi juliaSymbol guifg=#8be9fd
    au Filetype julia hi juliaOperator guifg=#f8f8f2
    au Filetype julia hi juliaMacro gui=bold guifg=#ffb86c
]])

-- python files
vim.cmd([[
    augroup python
    autocmd!
    au Filetype python hi pythonInclude gui=bold guifg=#ff79c6
    au Filetype python hi pythonStatement gui=bold guifg=#ff79c6
    au Filetype python hi pythonFunction gui=bold guifg=#50fa7b
    au Filetype python hi pythonBuiltin gui=NONE guifg=#ffb86c
    au Filetype python hi pythonRepeat gui=bold guifg=#ff79c6
    au Filetype python hi pythonOperator gui=bold guifg=#ff79c6
    au Filetype python hi pythonConditional gui=bold guifg=#ff79c6
    au Filetype python hi pythonException gui=bold guifg=#ff79c6
    au Filetype python hi pythonNumber gui=NONE guifg=#8be9fd
]])

-- snippet files
vim.cmd([[
    augroup snippet
    autocmd!
    au Filetype snippet hi snippet gui=bold guifg=#ff79c6
    au Filetype snippet hi tabStop gui=NONE guifg=#8be9fd
]])

-- git commit files
vim.cmd([[
    augroup gitcommit
    autocmd!
    au Filetype gitcommit hi gitcommitHeader gui=bold guifg=#bd93f9
    au Filetype gitcommit hi gitcommitBranch gui=bold guifg=#ff79c6
    au Filetype gitcommit hi gitcommitSelectedType gui=NONE guifg=#ffb86c
    au Filetype gitcommit hi gitcommitSelectedFile gui=NONE guifg=#8be9fd
    au Filetype gitcommit hi gitcommitUntrackedFile gui=NONE guifg=#8be9fd
    au Filetype gitcommit hi ExtraWhitespace guibg=NONE"
]])

-- mail files
vim.cmd([[
    augroup mail
    autocmd!

    call matchadd('mailAttachment', '
        \[Aa]ttaching\|
        \[Aa]ttached\|
        \[Aa]ttach\|
        \cv\|
        \CV\|
        \[Ee]nclosing\|
        \[Ee]nclosed\|
        \[Ee]nclose\|
        \[Ff]iles\|
        \[Ff]ile\|
        \[Ii]ncluding\|
        \[Ii]ncluded\|
        \[Ii]nclude\|
        \[Pp]rinting\|
        \[Pp]rinter\|
        \[Pp]rint\|
        \[Rr]esume\|
        \[Ss]creenshots\|
        \[Ss]creenshot',
        \ -1)

    call matchadd('mailHeaderKeyName', '
        \^From:\|
        \^To:\|
        \^Cc:\|
        \^Bcc:\|
        \^Subject:\|
        \^Reply-To:\|
        \^In-Reply-To:',
        \ -1)

    au Filetype mail hi mailAttachment guifg=#ff7722
    au Filetype mail hi ExtraWhitespace guibg=NONE
    au Filetype mail hi mailHeaderKeyName guifg=#ff79c6 gui=bold
    au Filetype mail hi mailSubject guifg=#8be9fd
    au Filetype mail hi mailEmail guifg=#f1fa8c
    au Filetype mail hi mailHeaderEmail guifg=#f1fa8c
    au Filetype mail hi mailSignature guifg=#8be9fd
    au Filetype mail hi mailQuoted1 guifg=#bd93f9
    au Filetype mail hi mailQuoted2 guifg=#ffb86c
    au Filetype mail hi mailQuoted3 guifg=#50fa7b
    au Filetype mail hi mailQuoted4 guifg=#8be9fd
    au Filetype mail set linebreak
    au Filetype mail /\n\n--
]])

-- make files
vim.cmd([[
    augroup make
    autocmd!
    au Filetype make setlocal noexpandtab
    au Filetype make hi makeSpecTarget guifg=#ff79c6 gui=bold
    au Filetype make hi makeTarget guifg=#50fa7b gui=bold
    au Filetype make hi makeIdent gui=bold
]])

-- org files
vim.cmd([[
    augroup org
    autocmd!
    au Filetype org inoremap <C-l> <Esc>ma0f<Space>i*<Esc>A
    au Filetype org inoremap <C-h> <Esc>ma0f<Space>hx<Esc>A
    au Filetype org setlocal nofoldenable
    au Filetype org hi OrgHeadlineLevel1 guifg=#ff79c6 gui=bold
    au Filetype org hi OrgHeadlineLevel2 guifg=#bd93f9 gui=bold
    au Filetype org hi OrgHeadlineLevel3 guifg=#50fa7b
    au Filetype org hi OrgHeadlineLevel4 guifg=#f1fa8c
    au Filetype org hi OrgHeadlineLevel5 guifg=#8be9fd
    au Filetype org hi OrgHeadlineLevel6 guifg=#ff79c6
    au Filetype org hi OrgHeadlineLevel7 guifg=#bd93f9
    au Filetype org hi OrgHeadlineLevel8 guifg=#50fa7b
    au Filetype org hi Title gui=bold guifg=#ffb86c
    au Filetype org call matchadd('OrgDoneHeading', '*\+ DONE \(.*\)$', -1)
    au Filetype org hi OrgDoneHeading guifg=#6272a4 guibg=NONE
    au Filetype org call matchadd('OrgDone', '*\+ \(DONE\)', -1)
    au Filetype org hi OrgDone guifg=#00dd00 guibg=NONE gui=bold
    au Filetype org call matchadd('OrgLeadingStars', '*\+\(* \)\@=', -1)
    au Filetype org hi OrgLeadingStars guifg=#181a26 guibg=NONE
    au Filetype org call matchadd('OrgLeadingStar', '* ', -1)
    au Filetype org hi OrgLeadingStar gui=bold
    au Filetype org nnoremap T :let _s=@/<Bar>:s/ TODO \\| NOTE \\| DONE \\| NOW / /<Bar>:let @/=_s<CR>
]])

-- tex files
vim.cmd([[
    augroup tex
    autocmd!
    au Filetype tex syntax enable
    au Filetype tex setlocal shiftwidth=2
    au Filetype tex :ColorizerDetachFromBuffer
    au Filetype tex let g:vimtex_view_method = 'zathura'
    au Filetype tex let g:vimtex_matchparen_enabled = 0
    au Filetype tex let g:vimtex_compiler_silent = 1
    au Filetype tex let g:vimtex_quickfix_mode = 0
    au Filetype tex let g:vimtex_quickfix_method = 'pplatex'
    au Filetype tex let g:vimtex_quickfix_autoclose_after_keystrokes = 1
    au Filetype tex let g:tex_fast = 'M'
    au Filetype tex let g:vimtex_indent_delims = {'open': ['{', '(', '['], 'close' : ['}', ')', ']']}
    au Filetype tex hi QuickFixLine guifg=NONE gui=bold
    au Filetype tex hi texTitleArg gui=bold guifg=#ffff22
    au Filetype tex hi texPartArgTitle gui=bold guifg=#ffff22
    au Filetype tex hi texCmdInput gui=bold guifg=#ff79c6
    au Filetype tex hi texCmdStyle gui=bold guifg=#bd93f9
    au Filetype tex hi texFileArg guifg=#8be9fd
    au Filetype tex hi texCmdEnv gui=bold guifg=#ff79c6
    au Filetype tex hi texEnvArgName gui=bold guifg=#50fa7b
    au Filetype tex hi texCmdTitle gui=bold guifg=#ff79c6
    au Filetype tex hi texCmdAuthor gui=bold guifg=#ff79c6
    au Filetype tex hi texAuthorArg guifg=#bd93f9
    au Filetype tex hi texCmd gui=bold guifg=#ff79c6
    au Filetype tex hi texRefArg guifg=#8be9fd
    au Filetype tex hi texDelim guifg=#8be9fd
    au Filetype tex hi texTabularChar gui=bold guifg=#ff0000
    au Filetype tex hi texMathZoneTI guifg=#bd93f9
    au Filetype tex hi texMathArg guifg=#bd93f9
    au Filetype tex hi texMathGroup guifg=#bd93f9
    au Filetype tex hi texMathZoneEnv guifg=#bd93f9
    au Filetype tex hi texMathSuperSub gui=bold guifg=#6272a4
    au Filetype tex hi texMathSub guifg=#bd93f9
    au Filetype tex hi texMathSuper guifg=#bd93f9
    au Filetype tex hi texMathCmd guifg=#bd93f9
    au Filetype tex hi texSpecialChar guifg=#bd93f9
    au Filetype tex hi texMathDelimZoneLD guifg=#ff0000
    au Filetype tex hi texMathEnvArgName gui=bold guifg=#50fa7b
    au Filetype tex hi texMathDelimZoneTI gui=bold guifg=#ff0000
    au Filetype tex hi texTheoremEnvOpt gui=bold guifg=#ffff22
    au Filetype tex hi texProofEnvOpt gui=bold guifg=#ffff22
    au Filetype tex hi Special gui=NONE guifg=#f8f8f2
    au Filetype tex call matchadd('texPartArgTitle', '\proofparagraph{\zs[^}]*', -1)
    au Filetype tex call matchadd('texPageCmd', '\\pagebreak\|\\newpage\|\\clearpage\|\\appendix', -1)
    au Filetype tex hi texPageCmd gui=bold guifg=#ff0000
    au Filetype tex nnoremap ,b :update<CR>:VimtexCompileSS<CR>
    au Filetype tex nnoremap ,v :VimtexView<CR>
    au Filetype tex nnoremap ,k :VimtexStopAll<CR>
    au Filetype tex nnoremap ,w :VimtexErrors<CR>
    au Filetype tex inoremap <C-L> <C-X><C-O>
    au Filetype tex inoremap <C-J> <C-N>
    au Filetype tex inoremap <C-K> <C-P>
]])

-- TODO add yankstack to nix packages
