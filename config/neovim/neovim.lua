-- helper function
function map(mode, shortcut, command)
  vim.api.nvim_set_keymap(mode, shortcut, command,
      { noremap = true, silent = true })
end

-- basics
vim.o.number = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.clipboard = "unnamedplus"
vim.o.mouse = ""
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
vim.g.yankring_clipboard_monitor = 0
vim.o.foldenable = false

-- mappings
map("n", "<Tab>", "==")
map("n", "<Space>tl", ":set wrap!<CR>")
map("n", "<Space>tL", ":set linebreak!<CR>")
map("n", "<Space><Space>", ":")
map("n", "<Space>tn", ":set invnumber<CR>")
map("n", "<Space>fr", ":edit<CR>")
map("n", "<Space>fn", ":edit notes.org<CR>")
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
map("n", "<Space>yy", "m'^v$hy")
map("i", "kj", "<Esc>")
vim.opt.listchars = {eol = "$", tab = ">-", trail = "~",
  extends = ">", precedes = "<", space = "·"}

-- colors
vim.o.syntax = "ON"
vim.o.termguicolors = true
vim.cmd("colorscheme catppuccin-mocha")

vim.cmd("hi MatchParen guifg=#8be9ff guibg=#1e1e2e gui=bold")
vim.cmd("hi Search guibg=#a6e3a1 guifg=#181825")
vim.cmd("hi CurSearch guibg=#a6e3a1 guifg=#181825")
vim.cmd("hi IncSearch guibg=#a6e3a1 guifg=#181825")
vim.cmd("hi Special gui=NONE")
vim.cmd("hi ExtraWhitespace guibg=#45475a")
vim.cmd("match ExtraWhitespace /\\s\\+$/")

-- cursor
vim.o.cursorline = true
vim.cmd("hi CursorLine guibg=#242438")
vim.cmd("hi CursorLineNr guifg=#6c7086 gui=bold")
vim.cmd("set guicursor+=a:blinkwait300-blinkon200-blinkoff150")

-- ignore missing language providers
vim.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-- no comments on new line
vim.cmd("au BufEnter * set fo-=c fo-=r fo-=o")

-- oldfiles list length
vim.cmd("set shada=!,'500,<50,s10,h")

-- toggle colorcolumn
vim.cmd [[
    function! ToggleColorColumn ( )
        if &colorcolumn == ""
            set colorcolumn=80
        else
            set colorcolumn=
        endif
    endfunction
    command ToggleColorColumn call ToggleColorColumn()
    nnoremap <Space>cc :ToggleColorColumn<CR>
]]

-- git conflicts
map("n", "gc", "/=======\\|<<<<<<<\\|>>>>>>><CR>")

-- trim whitespace
map("n", "<Space>tt", ":let _s=@/<Bar>:%s/\\s\\+$//e<Bar>:let @/=_s<Bar><CR>")

-- snippets
require("luasnip.loaders.from_snipmate").lazy_load({paths =
    "~/.config/nvim/snippets/"})
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
    au Filetype startify hi StartifyHeader gui=bold guifg=#cba6f7
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
    "-E '*.docx' -E '*.xlsx' -E '*.ppt' -E '*.eps' -E '*.aux'" ..
    "-E '*.p' -E '*.fig'\"" ..
    "}) <CR>")
map("n", "<Space>pf",
    ":lua require'fzf-lua'.git_files({prompt='Project files> '," ..
    "cwd = '`git rev-parse --show-toplevel`'," ..
    "show_cwd_header=false}) <CR>")
map("n", "<Space>bb",
    ":lua require'fzf-lua'.oldfiles({prompt='Recent files> '," ..
    "file_ignore_patterns = { '%COMMIT_EDITMSG$' }," ..
    "include_current_session=true}) <CR>")
map("n", "<Space>gc",
    ":lua require'fzf-lua'.git_commits({prompt='Commits> '," ..
    "show_cwd_header=false}) <CR>")
map("n", "<Space>/",
    ":lua require'fzf-lua'.grep_project({prompt='Project> '," ..
    "cwd = '`git rev-parse --show-toplevel`'," ..
    "no_header_i=true, no_header=true}) <CR>")

-- gitgutter
vim.g.gitgutter_enabled = false
vim.g.gitgutter_map_keys = false
map("n", "<Space>gg", ":GitGutterToggle <CR>")
vim.cmd("hi GitGutterAdd guifg=#00dd00 gui=bold")
vim.cmd("hi GitGutterChange guifg=#ffff22 gui=bold")
vim.cmd("hi GitGutterDelete guifg=#ff2222 gui=bold")

-- leap
vim.cmd("hi LeapBackdrop guifg=#a6adc8 guibg=NONE gui=NONE")
require('leap').opts.safe_labels = {}
vim.keymap.set('n', 'F', function ()
    local current_window = vim.fn.win_getid()
    require('leap').leap { target_windows = { current_window } }
end)

-- just
map("n", "<Space>jj",
    ":echo 'just' | silent exec '!(just &) > /dev/null' <CR>")
map("n", "<Space>jc",
    ":echo 'just clean' | silent exec '!(just clean &) > /dev/null' <CR>")
map("n", "<Space>jb",
    ":echo 'just build' | silent exec '!(just build &) > /dev/null' <CR>")
map("n", "<Space>jf",
    ":echo 'just format' | silent exec '!(just format &) > /dev/null' <CR>")

-- todo highlighting
vim.cmd("hi Todo guifg=#FF7722 guibg=#1e1e2e gui=bold")
vim.cmd("hi Now guifg=#8be9fd guibg=NONE gui=bold")
vim.cmd("hi Note guifg=#ffff22 guibg=NONE gui=bold")
vim.cmd("hi Done guifg=#00dd00 guibg=NONE gui=bold")
vim.cmd("hi Later guifg=#6272a4 guibg=NONE gui=bold")
vim.cmd("hi No guifg=#ff2222 guibg=NONE gui=bold")
vim.cmd("call matchadd('Todo', '\\<TODO\\>\\|\\<BUG\\>\\|\\\\TODO', -1)")
vim.cmd("call matchadd('Done', '\\<DONE\\>\\|\\<YES\\>', -1)")
vim.cmd("call matchadd('Now', '\\<NOW\\>', -1)")
vim.cmd("call matchadd('Note', '\\<NOTE\\>\\|\\<BOUGHT\\>\\|\\<ARRIVED\\>\\|" ..
        "\\<CHECK\\>\\|\\<BASKET\\>\\|\\<WRAPPED\\>\\|\\<MAYBE\\>\\|" ..
        "\\<DRAFT\\>\\|\\<EMAILED\\>\\|\\<PACKED\\>', -1)")
vim.cmd("call matchadd('Later', '\\<LATER\\>', -1)")
vim.cmd("call matchadd('No', '\\<NO\\>', -1)")

-- lastplace
vim.g.lastplace_ignore = "gitcommit,gitrebase,svn,hgcommit,mail"

-- org mode
require('orgmode').setup({
    org_log_done=false,
    org_startup_indented=false,
    org_todo_keywords={'TODO(t)', 'NOTE(n)', 'NOW(w)', 'BUG(b)', 'LATER(l)',
    'CHECK(c)', 'YES(Y)', 'NO(O)', 'MAYBE(M)', '|', 'DONE(d)'},
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
require("colorizer").setup {
    filetypes = { "*" },
    user_default_options = {
        RGB = false, -- #RGB hex codes
        names = false, -- "Name" codes like Blue or blue
        RRGGBBAA = true, -- #RRGGBBAA hex codes
    }
}

-- lualine
require('lualine').setup {
    options = {icons_enabled = false},
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'searchcount'},
        lualine_c = {'filename'},
        lualine_x = {'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'},
    },
}

-- luasnip with snipmate
require("luasnip").setup({update_events = {"TextChanged", "TextChangedI"},
                          history = true})
require("luasnip.loaders.from_snipmate").lazy_load({paths = "./snippets"})

-- autocompletion with nvim_cmp
local luasnip = require("luasnip")
local cmp = require("cmp")
local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    local lines = vim.api.nvim_buf_get_lines(0, line - 1, line, true)
    return col ~= 0 and lines[1]:sub(col, col):match("%s") == nil
end
cmp.setup({
    mapping = {
        ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                local keys = vim.api.nvim_replace_termcodes(
                    '<C-X><C-O>', false, false, true)
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
                luasnip = "[sn]",
                rg = "[rg]",
                omni = "[om]",
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

-- check spelling under cursor (British)
vim.cmd [[
    function! CheckSpellingUnderCursorGB ( )
        let word = expand("<cword>")
        let check = system("spell-check-word -b '" . word . "'")
        echom check
    endfunction
    command CheckSpellingUnderCursorGB call CheckSpellingUnderCursorGB()
    nnoremap <Space>cs :CheckSpellingUnderCursorGB<CR>
]]

-- check spelling under cursor (American)
vim.cmd [[
    function! CheckSpellingUnderCursorUS ( )
        let word = expand("<cword>")
        let check = system("spell-check-word -a '" . word . "'")
        echom check
    endfunction
    command CheckSpellingUnderCursorUS call CheckSpellingUnderCursorUS()
    nnoremap <Space>cS :CheckSpellingUnderCursorUS<CR>
]]

-- fix spelling under cursor (British)
vim.cmd [[
    function! FixSpellingUnderCursorGB ( )
        let word = expand("<cword>")
        let fix = system("spell-check-fix -b '" . word . "'")
        execute "normal! ciw" . fix . "\<Esc>"
    endfunction
    command FixSpellingUnderCursorGB call FixSpellingUnderCursorGB()
    nnoremap <Space>cf :FixSpellingUnderCursorGB<CR>
]]

-- fix spelling under cursor (American)
vim.cmd [[
    function! FixSpellingUnderCursorUS ( )
        let word = expand("<cword>")
        let fix = system("spell-check-fix -a '" . word . "'")
        execute "normal! ciw" . fix . "\<Esc>"
    endfunction
    command FixSpellingUnderCursorUS call FixSpellingUnderCursorUS()
    nnoremap <Space>cF :FixSpellingUnderCursorUS<CR>
]]

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

    au Filetype mail hi mailAttachment guifg=#ff7722
    au Filetype mail hi ExtraWhitespace guibg=NONE
    au Filetype mail setlocal linebreak
    au Filetype mail /\n\n--
]])

-- text files
vim.cmd([[
    augroup text
    autocmd!
    au Filetype text setlocal linebreak
]])

-- org files
vim.cmd [[
    function! RemoveOrgTodoHeader()
        normal mz
        normal 0
        s/ TODO \| NOTE \| DONE \| NOW / /e
        normal `z
    endfun
    command RemoveOrgTodoHeader call RemoveOrgTodoHeader()
]]

vim.cmd([[
    augroup org
    autocmd!
    au Filetype org inoremap <C-l> <Esc>ma0f<Space>i*<Esc>A
    au Filetype org inoremap <C-h> <Esc>ma0f<Space>hx<Esc>A
    au Filetype org setlocal nofoldenable
    au Filetype org hi @org.headline.level1.org guifg=#f5c2e7 gui=bold
    au Filetype org hi @org.headline.level2.org guifg=#cba6f7 gui=bold
    au Filetype org hi @org.headline.level3.org guifg=#a6e3a1
    au Filetype org hi @org.headline.level4.org guifg=#f9e2af
    au Filetype org hi @org.headline.level5.org guifg=#89dceb
    au Filetype org hi @org.headline.level6.org guifg=#f5c2e7
    au Filetype org hi @org.headline.level7.org guifg=#cba6f7
    au Filetype org hi @org.headline.level8.org guifg=#a6e3a1
    au Filetype org hi @org.directive.org gui=bold guifg=#fab387
    au Filetype org call matchadd('OrgDoneHeading', '*\+ DONE \(.*\)$', -1)
    au Filetype org hi OrgDoneHeading guifg=#9399b2 guibg=NONE
    au Filetype org call matchadd('OrgDone', '*\+ \(DONE\)', -1)
    au Filetype org hi OrgDone guifg=#00dd00 guibg=NONE gui=bold
    au Filetype org call matchadd('OrgLeadingStars', '*\+\(* \)\@=', -1)
    au Filetype org hi OrgLeadingStars guifg=#1e1e2e guibg=NONE
    au Filetype org call matchadd('OrgLeadingStar', '* ', -1)
    au Filetype org hi OrgLeadingStar gui=bold
    au Filetype org nnoremap T :RemoveOrgTodoHeader<CR>
    au Filetype org setlocal linebreak
]])

-- TODO edit from here
-- TODO check bright colours, including org keywords
-- tex files
vim.g.vimtex_view_method = 'zathura_simple'
vim.cmd([[
    augroup tex
    autocmd!
    au Filetype tex syntax enable
    au Filetype tex setlocal shiftwidth=2
    au Filetype tex let g:vimtex_matchparen_enabled = 0
    au Filetype tex let g:vimtex_compiler_silent = 1
    au Filetype tex let g:vimtex_quickfix_mode = 0
    au Filetype tex let g:vimtex_quickfix_method = 'pplatex'
    au Filetype tex let g:tex_fast = ''
    au Filetype tex let g:vimtex_syntax_conceal_disable = 1
    au Filetype tex let g:vimtex_quickfix_autoclose_after_keystrokes = 1
    au Filetype tex let g:vimtex_indent_delims =
        \ {'open': ['{', '(', '['], 'close' : ['}', ')', ']']}
    au Filetype tex hi QuickFixLine guifg=NONE guibg=NONE gui=bold
    au Filetype tex nnoremap ,b :update<CR>:VimtexCompileSS<CR>
    au Filetype tex nnoremap ,v :VimtexView<CR>
    au Filetype tex nnoremap ,k :VimtexStopAll<CR>
    au Filetype tex nnoremap ,w :VimtexErrors<CR>
    au Filetype tex nnoremap ,e V<plug>(vimtex-ae)
    au Filetype tex inoremap <C-L> <C-X><C-O>
    au Filetype tex inoremap <C-J> <C-N>
    au Filetype tex inoremap <C-K> <C-P>
    au Filetype tex hi texTitleArg gui=bold guifg=#f9e2af
    au Filetype tex hi texPartArgTitle gui=bold guifg=#f9e2af
]])
--vim.cmd([[
    --augroup tex
    --autocmd!
    --au Filetype tex :ColorizerDetachFromBuffer
    --au Filetype tex hi QuickFixLine guifg=NONE guibg=NONE gui=bold
    --au Filetype tex hi texCmdInput gui=bold guifg=#ff79c6
    --au Filetype tex hi texCmdStyle gui=bold guifg=#bd93f9
    --au Filetype tex hi texFileArg guifg=#8be9fd
    --au Filetype tex hi texCmdEnv gui=bold guifg=#ff79c6
    --au Filetype tex hi texEnvArgName gui=bold guifg=#50fa7b
    --au Filetype tex hi texCmdTitle gui=bold guifg=#ff79c6
    --au Filetype tex hi texCmdAuthor gui=bold guifg=#ff79c6
    --au Filetype tex hi texAuthorArg guifg=#bd93f9
    --au Filetype tex hi texCmd gui=bold guifg=#ff79c6
    --au Filetype tex hi texRefArg guifg=#8be9fd
    --au Filetype tex hi texDelim guifg=#8be9fd
    --au Filetype tex hi texTabularChar gui=bold guifg=#ff0000
    --au Filetype tex hi texMathZoneTI guifg=#bd93f9
    --au Filetype tex hi texMathArg guifg=#bd93f9
    --au Filetype tex hi texMathGroup guifg=#bd93f9
    --au Filetype tex hi texMathZoneEnv guifg=#bd93f9
    --au Filetype tex hi texMathSuperSub gui=bold guifg=#6272a4
    --au Filetype tex hi texMathSub guifg=#bd93f9
    --au Filetype tex hi texMathSuper guifg=#bd93f9
    --au Filetype tex hi texMathSymbol gui=NONE guifg=#ff79c6
    --au Filetype tex hi texMathCmd guifg=#ff79c6
    --au Filetype tex hi texSpecialChar guifg=#bd93f9
    --au Filetype tex hi texMathDelimZoneLD guifg=#ff0000
    --au Filetype tex hi texMathEnvArgName gui=bold guifg=#50fa7b
    --au Filetype tex hi texMathDelimZoneTI gui=bold guifg=#ff0000
    --au Filetype tex hi texMathDelimZoneTD gui=bold guifg=#ff0000
    --au Filetype tex hi texTheoremEnvOpt gui=bold guifg=#ffff22
    --au Filetype tex hi texProofEnvOpt gui=bold guifg=#ffff22
    --au Filetype tex hi Special gui=NONE guifg=#f8f8f2
    --au Filetype tex call matchadd('texPartArgTitle',
        --\ '^[^%]*\\proofparagraph{\zs[^}][^}]*\ze}', -1)
    --au Filetype tex call matchadd('texPartArgTitle',
        --\ '^[^%]*\\begin{frame}\(\[.*\]\)\?{\zs[^}][^}]*\ze}', -1)
    --au Filetype tex call matchadd('texPageCmd',
        --\ '\\pagebreak\|\\newpage\|\\clearpage\|\\appendix', -1)
    --au Filetype tex hi texPageCmd gui=bold guifg=#ff0000
    --au Filetype tex nnoremap ,b :update<CR>:VimtexCompileSS<CR>
    --au Filetype tex nnoremap ,v :VimtexView<CR>
    --au Filetype tex nnoremap ,k :VimtexStopAll<CR>
    --au Filetype tex nnoremap ,w :VimtexErrors<CR>
    --au Filetype tex nnoremap ,e V<plug>(vimtex-ae)
    --au Filetype tex inoremap <C-L> <C-X><C-O>
    --au Filetype tex inoremap <C-J> <C-N>
    --au Filetype tex inoremap <C-K> <C-P>
--]])
