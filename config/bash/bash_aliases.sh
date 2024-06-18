# exa
alias l='exa'
alias lg='exa --all --long --git --git-ignore'
alias ltg='exa --long --tree --git --git-ignore'
alias lt='exa --all --long --sort newest'
alias ltt='exa --tree'
alias ll='exa --all --long --git'
alias lz='exa --all --long --git --sort size'
alias lrz='fd -tf -X exa --long --sort size'
alias lrc='ls -AiR1U ./ |
           sed -rn \
           "/^[./]/{h;n;};G; s|^ *([0-9][0-9]*)[^0-9][^/]*([~./].*):|\1:\2|p" |
           sort -t : -uk1.1,1n | cut -d: -f2 | sort -V | uniq -c |sort -n'

# programs
alias b='bat --theme Dracula'
alias c='cd'
alias ci='cdi'
f() { command feh "$@" & }
alias g='git'
alias j='just'
alias m='(cd ~/downloads; neomutt)'
alias n='nvim'
alias r='ranger'
z() { command zathura "$@" & }
alias bbd='bib-down'
alias bm='btm'
alias no='nvim notes.org'
alias nj='nvim justfile'
alias texc='tex-clean'
alias texf='tex-fmt'
alias pla='player-art'
alias cava='cava -p ~/cava.conf'
fp() { command fd "$@" "$(git rev-parse --show-toplevel)"; }
rp() { command rg "$@" "$(git rev-parse --show-toplevel)"; }
alias cpdf='compress-pdf'
alias rpdf='rename-pdf'
li() { command libreoffice "$@" & }
tex-labels() {
    command grep -o -e "\\\label{[^}]*}" "$@" | \
    grep --color -P "(?<={)[^}]*(?=})";
}
alias rcgdpl='rclone-sync -gl'
alias rcgdps='rclone-sync -gs'
alias rcgdppl='rclone-sync -pl'
alias rcgdpps='rclone-sync -ps'
alias rcdbppl='rclone-sync -dl'
alias rcdbpps='rclone-sync -ds'
alias rcpl='rcgdpl && rcgdppl && rcdbppl'
alias rcps='rcgdps && rcgdpps && rcdbpps'

# nix
nxr() {
    (
    DOTS="$HOME/github/dotfiles"
    cd "$DOTS"
    NIX="$DOTS/.#nixosConfigurations.$HOSTNAME.config.system.build.toplevel"
    alejandra -cq "$DOTS" &&
        sudo nom build "$NIX" &&
        sudo nixos-rebuild switch --flake "$DOTS#$HOSTNAME"
    )
}
nxu() {
    DOTS="$HOME/github/dotfiles"
    alejandra -cq "$DOTS" &&
        nix flake update "$DOTS"
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
alias t='rg --sort path -t org TODO $HOME/github $HOME/overleaf'
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
alias cdgdp='cd ~/rclone/google_drive_princeton/'
alias cddbp='cd ~/rclone/dropbox_princeton/'

# cd google drive
alias cdoxlec='cd ~/rclone/google_drive/Education/Oxford/Oxford\ Lecture\ Notes'
alias cdtextbk='cd ~/rclone/google_drive/Education/Textbooks\ and\ Extra\ Notes'
alias cdpton='cd ~/rclone/google_drive/Education/Princeton/'
alias cdtax='cd ~/rclone/google_drive/Finances/Tax/'

# cd github
alias cdgh='cd ~/github/'
alias cddot='cd ~/github/dotfiles/'
alias cdjob='cd ~/github/job-search-2023/'
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
alias cdrv='cd ~/github/reviewing/'

# cd dropbox
alias cdted='cd ~/rclone/dropbox_princeton/2024Spring_ORF499/'

# cd research github
alias cdrem='cd ~/github/research-martingale-yurinskii/'
alias cdref='cd ~/github/research-random-forests/'

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
