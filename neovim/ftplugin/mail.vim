" mail
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
hi mailAttachment guifg=#ff7722
call matchadd('mailHeaderKeyName', '
            \^From:\|
            \^To:\|
            \^Cc:\|
            \^Bcc:\|
            \^Subject:\|
            \^Reply-To:\|
            \^In-Reply-To:',
            \ -1)
hi mailHeaderKeyName guifg=#ff79c6 gui=bold
hi mailSubject guifg=#8be9fd
hi mailEmail guifg=#f1fa8c
hi mailHeaderEmail guifg=#f1fa8c
hi mailSignature guifg=#8be9fd
hi mailQuoted1 guifg=#bd93f9
hi mailQuoted2 guifg=#ffb86c
hi mailQuoted3 guifg=#50fa7b
hi mailQuoted4 guifg=#8be9fd
hi ExtraWhitespace guibg=NONE
/\n\n--
