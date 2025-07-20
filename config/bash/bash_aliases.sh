# exa
alias l='exa --classify'
alias lg='exa --all --long --git --git-ignore --classify'
alias ltg='exa --long --tree --git --git-ignore --classify'
alias lt='exa --all --long --sort newest --classify'
alias ltt='exa --tree --classify'
alias ll='exa --all --long --git --classify'
alias lz='exa --all --long --git --sort size --classify'
alias lrz='fd -tf -X exa --long --sort size --classify'
alias lrc='ls -AiR1U ./ |
           sed -rn \
           "/^[./]/{h;n;};G; s|^ *([0-9][0-9]*)[^0-9][^/]*([~./].*):|\1:\2|p" |
           sort -t : -uk1.1,1n | cut -d: -f2 | sort -V | uniq -c |sort -n'

# programs
alias b='bat'
alias c='cd'
alias ci='cdi'
alias cf='cd-fuzzy'
f() { command feh "$@" & }
alias g='git'
alias j='just'
alias m='(cd ~/downloads; neomutt)'
alias n='nvim'
alias r='ranger'
z() { command zathura "$@" & }
alias bbd='bib-down'
alias bm='btm'
alias dav='davmail ~/.config/davmail/davmail.conf'
alias no='nvim notes.org'
alias nj='nvim justfile'
alias sp='spotify_player'
alias texc='tex-clean'
alias texf='tex-fmt'
cpref() { command cp --backup=numbered "$@" "$HOME/github/references/new/"; }
alias pla='player-art'
alias cava='cava -p ~/cava.conf'
fp() { command fd "$@" "$(git rev-parse --show-toplevel)"; }
rp() { command rg "$@" "$(git rev-parse --show-toplevel)"; }
rc() { command git show --no-patch :/"$@"; }
alias cpdf='compress-pdf'
alias rpdf='rename-pdf'
li() { command libreoffice "$@" & }
tex-labels() {
    command grep -o -e "\\\label{[^}]*}" "$@" | \
    grep --color -P "(?<={)[^}]*(?=})";
}
alias rmsha='rm --verbose *.sha256'
alias rcgdpl='rclone-sync -gl'
alias rcgdps='rclone-sync -gs'
alias rcpl='rcgdpl'
alias rcps='rcgdps'

# nix
nxr() {
    (
    DOTS="$HOME/github/dotfiles"
    cd "$DOTS"
    NIX="$DOTS/.#nixosConfigurations.$HOSTNAME.config.system.build.toplevel"
    deadnix -f "$DOTS" &&
        alejandra -q "$DOTS" &&
        sudo nom build "$NIX" &&
        sudo nixos-rebuild switch --flake "$DOTS#$HOSTNAME"
    )
}
nxu() {
    (
    DOTS="$HOME/github/dotfiles"
    cd "$DOTS"
    alejandra -cq "$DOTS" &&
        nix flake update
    )
}
alias nxq='nix-env -qa | fzf'
alias nxg='nix-collect-garbage --delete-old &&
           sudo nix-collect-garbage --delete-old'
alias nxb='nom build'
alias nxd='nom develop'
alias nxs='nix-shell'
nxp() { ls -l "$(which "$@")"; }
nxf() { find $(nix-build '<nixpkgs>' -A "$@" --no-link); }

# shortcuts
alias psgrep='ps -aux | grep -v "grep" | grep'
alias timenow='date +"%Y/%m/%d%n%H:%M:%S.%3N%n%:z"'
gcl() { command git clone "git@github.com:WGUNDERWOOD/$@" & }

# todoist
alias t='rg --sort path -t org TODO\|NOW $HOME/github $HOME/overleaf'
alias tt='todoist sync &&
          todoist --color list --filter "(overdue | today | p1)"'
alias tl='todoist sync && todoist --color list'
tq() { command todoist quick "$@" && todoist sync & }
tc() { command todoist close "$@" && todoist sync & }
td() { command todoist delete "$@" && todoist sync & }

# cd local
alias ..='cd ..'
alias ...='cd ../..'
alias cddow='cd ~/downloads/'
alias cdcon='cd ~/.config/'

# cd rclone
alias cdrc='cd ~/rclone/'
alias cdgd='cd ~/rclone/google_drive/'

# cd google drive
alias cdoxlec='cd ~/rclone/google_drive/Education/Oxford/Oxford\ Lecture\ Notes'
alias cdpton='cd ~/rclone/google_drive/Education/Princeton/'
alias cdtax='cd ~/rclone/google_drive/Finances/Tax/'

# cd github
alias cdgh='cd ~/github/'
alias cddot='cd ~/github/dotfiles/'
alias cdjob='cd ~/github/job-search-2023/'
alias cdref='cd ~/github/references/'
alias cdcv='cd ~/github/wgu-cv/'
alias cdnot='cd ~/github/notes/'
alias cdtf='cd ~/github/tex-fmt/'
alias cdtr='cd ~/github/notes/travel/'
alias cdphd='cd ~/github/phd-dissertation/'
alias cdweb='cd ~/github/wgunderwood.github.io/'
alias cdsco='cd ~/github/music-scores/'
alias cdmon='cd ~/github/MondrianForests.jl/'
alias cdmot='cd ~/github/motifcluster/'
alias cddy='cd ~/github/DyadicKDE.jl/'
alias cdte='cd ~/github/orf-499-spring-2024/'
alias cdrev='cd ~/github/reviewing/'

# cd research github
alias cdrm='cd ~/github/research-martingale-yurinskii/'
alias cdrf='cd ~/github/research-random-forests/'

# cd overleaf
alias cdov='cd ~/overleaf/'
alias cdovm='cd ~/overleaf/CMU_2022_SAMartingale/'
alias cdovf='cd ~/overleaf/CKU_2023_MondrianRF/'
alias cdovh='cd ~/overleaf/CMU_2023_HigherOrderLindeberg/'
alias cdova='cd ~/overleaf/CCKU_2024_AdaptiveMondrian/'

# completion
source $(which complete_alias)
complete -F _complete_alias bm
complete -F _complete_alias c
complete -F _complete_alias g
complete -F _complete_alias j
complete -f -o plusdirs -X '!*.pdf' zathura
complete -f -o plusdirs -X '!*.pdf' z
