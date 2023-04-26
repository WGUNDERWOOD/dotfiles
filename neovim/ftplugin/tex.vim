" vimtex
syntax enable
setlocal shiftwidth=2
let g:vimtex_matchparen_enabled = 0
let g:vimtex_compiler_silent = 1
let g:vimtex_quickfix_mode = 0
let g:vimtex_quickfix_method = 'pplatex'
let g:vimtex_quickfix_autoclose_after_keystrokes = 1
let g:tex_fast = "M"
let g:vimtex_indent_delims = {
    \ 'open'  : ['{', '(', '['],
    \ 'close' : ['}', ')', ']'],
    \ }

nnoremap ,b :update<CR><Plug>(vimtex-compile-ss)
nnoremap ,v <Plug>(vimtex-view)
nnoremap ,k <Plug>(vimtex-stop-all)
nnoremap ,w <Plug>(vimtex-errors)
inoremap <C-L> <C-X><C-O>
inoremap <C-J> <C-N>
inoremap <C-K> <C-P>

hi QuickFixLine guifg=NONE gui=bold
hi texTitleArg gui=bold guifg=#ffff22
hi texPartArgTitle gui=bold guifg=#ffff22
hi texCmdInput gui=bold guifg=#ff79c6
hi texFileArg guifg=#8be9fd
hi texCmdEnv gui=bold guifg=#ff79c6
hi texEnvArgName gui=bold guifg=#50fa7b
hi texCmdTitle gui=bold guifg=#ff79c6
hi texCmdAuthor gui=bold guifg=#ff79c6
hi texAuthorArg guifg=#bd93f9
hi texCmd gui=bold guifg=#ff79c6
hi texRefArg guifg=#8be9fd
hi texTabularChar gui=bold guifg=#ff0000
hi texMathSuperSub gui=bold guifg=#6272a4
hi texMathCmd guifg=#bd93f9
hi texMathEnvArgName gui=bold guifg=#50fa7b
hi texMathDelimZoneTI gui=bold guifg=#ff0000

call matchadd('texPageCmd', '\\pagebreak\|\\newpage\|\\clearpage', -1)
highlight texPageCmd gui=bold guifg=#ff0000

