" org
nnoremap tt <Plug>(org_todo)
setlocal nofoldenable

hi OrgTSDirective guifg=#ffb86c gui=bold
hi OrgTSHeadlineLevel1 guifg=#ff79c6 gui=bold
hi OrgTSHeadlineLevel2 guifg=#bd93f9 gui=bold
hi OrgTSHeadlineLevel3 guifg=#50fa7b
hi OrgTSHeadlineLevel4 guifg=#f1fa8c
hi OrgTSHeadlineLevel5 guifg=#8be9fd
hi OrgTSHeadlineLevel6 guifg=#ff79c6
hi OrgTSHeadlineLevel7 guifg=#bd93f9
hi OrgTSHeadlineLevel8 guifg=#50fa7b

call matchadd('OrgDoneHeading', '*\+ DONE \(.*\)$', -1)
highlight OrgDoneHeading guifg=#6272a4 guibg=NONE
call matchadd('OrgDone', '*\+ \(DONE\)', -1)
highlight OrgDone guifg=#00dd00 guibg=NONE gui=bold
call matchadd('OrgLeadingStars', '*\+\(* \)\@=', -1)
highlight OrgLeadingStars guifg=#181a26 guibg=NONE
call matchadd('OrgLeadingStar', '* ', -1)
highlight OrgLeadingStar gui=bold

" remove todo heading
nnoremap T :set nohlsearch<CR> :s/ TODO \\| DONE \\| NOW / /<CR> /^^<CR> :hlsearch<CR>
