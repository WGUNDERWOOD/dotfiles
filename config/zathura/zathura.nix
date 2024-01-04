{pkgs, ...}: {
    home.file.".config/zathura/zathurarc".text = ''
        map <M-i> recolor
        set default-bg "#282a36"
        set highlight-color "#bd93f9"
        set highlight-active-color "#ff79c6"
        set highlight-transparency 0.3
        set recolor true
        set recolor-darkcolor "#eeeeee"
        set recolor-lightcolor "#181818"
        set recolor-keephue true
        set page-padding 20
        map - zoom out
        map = zoom in
        map u zoom out
        map i zoom in
        unmap d
        set show-recent 200
        set font "Source Code Pro 14"
        set scroll-step 100
        map t toggle_statusbar
        set statusbar-home-tilde true
        set statusbar-bg "#44475a"
        set statusbar-basename true
        set guioptions none
        set selection-clipboard clipboard
        set sandbox none
        set completion-bg "#24273a"
        set completion-fg "#eeeeee"
        set completion-group-bg "#9d73d9"
        set completion-group-fg "#181818"
        set completion-highlight-bg "#44475a"
        set completion-highlight-fg "#ffff33"
        set inputbar-bg "#44475a"
        set inputbar-fg "#ff79c6"
        set index-bg "#24273a"
        set index-fg "#eeeeee"
        set index-active-bg "#44475a"
        set index-active-fg "#ffff33"
        set highlight-fg "#8be9fd"
        set database sqlite
        map <Space> feedkeys <Esc>
        '';
}
