# exa
alias l='exa'
alias lg='exa --all --long --git --git-ignore'
alias ltg='exa --long --tree --git --git-ignore'
alias lt='exa --all --long --sort newest'
alias ltt='exa --tree'
alias ll='exa --all --long --git'
alias lz='exa --all --long --sort size'
alias lrz='fd -tf -X exa --long --sort size'
alias lrc='ls -AiR1U ./ |
           sed -rn "/^[./]/{h;n;};G; s|^ *([0-9][0-9]*)[^0-9][^/]*([~./].*):|\1:\2|p" |
           sort -t : -uk1.1,1n | cut -d: -f2 | sort -V | uniq -c |sort -n'

# programs
alias b='bat --theme Dracula'
alias c='cd'
alias g='git'
alias m='(cd ~/downloads; neomutt)'
alias n='nvim'
z() { command zathura "$@" & }
alias bbd='bib-down'
alias bm='btm'
alias no='nvim notes.org'
alias cava='cava -p ~/cava.conf'
fp() { command fd "$@" "$(git rev-parse --show-toplevel)"; }
rp() { command rg "$@" "$(git rev-parse --show-toplevel)"; }
alias cpdf='compress-pdf'
li() { command libreoffice "$@" & }
tex-labels() { command grep -o -e "\\\label{[^}]*}" "$@" | grep --color -P "(?<={)[^}]*(?=})"; }
alias rcgdpl='rclone-sync -gl'
alias rcgdps='rclone-sync -gs'
alias rcgdppl='rclone-sync -pl'
alias rcgdpps='rclone-sync -ps'
alias rcdbppl='rclone-sync -dl'
alias rcdbpps='rclone-sync -ds'
alias rcpl='rcgdpl && rcgdppl && rcdbppl'
alias rcps='rcgdps && rcgdpps && rcdbpps'
alias jpgcompress='mogrify -strip -interlace Plane -gaussian-blur 0.05 -quality 80%'

# nix
alias nxr='sudo nixos-rebuild switch'
alias nxq='nix-env -qa | fzf'
alias nxg='nix-store --gc'
alias nxs='nix-shell'
alias nxu='nixos-update'
alias nxb='nix-build'
nxp() { ls -l "$(which "$@")"; }
nxf() { find $(nix-build '<nixpkgs>' -A "$@" --no-link); }

# shortcuts
alias psgrep='ps -aux | grep -v "grep" | grep'
alias timenow='date +"%Y/%m/%d%n%H:%M:%S.%3N%n%:z"'
gcl() { command git clone "git@github.com:WGUNDERWOOD/$@" & }

# todoist
alias tt='todoist sync && todoist --color list --filter "(overdue | today | p1)"'
alias tl='todoist sync && todoist --color list'
tq() { command todoist quick "$@" && todoist sync & }
tc() { command todoist close "$@" && todoist sync & }
td() { command todoist delete "$@" && todoist sync & }

# cd aliases
alias ..='cd ..'
alias ...='cd ../..'
alias cddow='cd ~/downloads/'
alias cdcon='cd ~/.config/'
alias cdrc='cd ~/rclone/'
alias cdgd='cd ~/rclone/google_drive/'
alias cdgdp='cd ~/rclone/google_drive_princeton/'
alias cddbp='cd ~/rclone/dropbox_princeton/'
alias cdgh='cd ~/github/'
alias cddot='cd ~/github/dotfiles/'
alias cdjob='cd ~/github/job-search-2023/'
alias cdcv='cd ~/github/wgu-cv/'
alias cdov='cd ~/overleaf/'
alias cdnot='cd ~/github/notes/'
#alias cdhe='cd ~/odrive/Google\ Drive/Health'
#alias cdmon='cd ~/Documents/github/MondrianForests.jl'
#alias cdaoc='cd ~/Documents/github/advent-of-code-2021'
#alias cdrem='cd ~/Documents/remarkable'
#alias cdox='cd ~/odrive/Google\ Drive/Education/Oxford/'
#alias cdoxlec='cd ~/odrive/Google\ Drive/Education/Oxford/Oxford\ Lecture\ Notes'
#alias cdtextbk='cd ~/odrive/Google\ Drive/Education/Textbooks\ and\ Extra\ Notes'
#alias cdmot='cd ~/Documents/github/motifcluster'
#alias cdwp='cd ~/Pictures/wallpapers'
#alias cdweb='cd ~/Documents/github/wgunderwood.github.io'
#alias cdk='cd ~/Documents/github/research-dyadic-kde/'
#alias cdd='cd ~/Documents/github/DyadicKDE.jl/'
#alias cdr='cd ~/Documents/github/research-dyadic-regression/'
#alias cdf='cd ~/Documents/github/research-random-forests/'
#alias cdm='cd ~/Documents/github/research-martingale-yurinskii/'
#alias cdac='cd ~/odrive/Dropbox\ Princeton/Underwood_Academic_Applications_2023'
#alias cdovk='cd ~/Documents/overleaf/CFU_2021_DyadicKDE'
#alias cdovm='cd ~/Documents/overleaf/CMU_2022_SAMartingale/'
#alias cdovf='cd ~/Documents/overleaf/CKU_2022_MondrianRF/'
#alias cdpton='cd ~/odrive/Google\ Drive/Education/Princeton'
#alias cdpub='cd ~/odrive/Google\ Drive/Publications/'
#alias cdmat='cd ~/odrive/Dropbox\ Princeton/00000_shared--CFF_2018_RandPartitioning/'
#alias cdric='cd ~/odrive/Dropbox\ Princeton/0000_shared--Cattaneo-Masini_2021_SA-Martingale/'
#alias cdjas='cd ~/odrive/Dropbox\ Princeton/0000_shared--CKU_2022_Mondrian/'
#alias cdte='cd ~/odrive/Dropbox\ Princeton/2023Fall_ORF498/'
#alias cdrv='cd ~/odrive/Google\ Drive/Education/Princeton/Reviewing/'
#alias cdtax='cd ~/odrive/Google\ Drive/Finances/Tax/Tax\ 2022'
#alias cdnot='cd ~/odrive/Google\ Drive/Notes'
#alias cdtr='cd ~/odrive/Google\ Drive/Travel'
#alias cdsco='cd ~/Documents/github/music-scores/'

# alias completion
source $(which complete_alias)
complete -F _complete_alias g
complete -F _complete_alias bm
