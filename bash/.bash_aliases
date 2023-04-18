#! /usr/bin/env bash

# exa aliases
alias l='exa'
alias lg='exa --all --long --git --git-ignore'
alias lt='exa --all --long --sort newest'
alias ltt='exa --tree'
alias ll='exa --all --long --git'
alias lz='exa --all --long --sort size'
alias lrz='fd -tf -X exa --long --sort size'

# one letter aliases
alias b='bat --theme Dracula'
alias g='git'
alias m='(cd ~/Downloads; neomutt)'
alias n='nvim'
alias o='odrivesync'
alias v='vim'
z() { command zathura "$@" & }

# programs
alias cava='cava -p ~/cava.conf'
alias cf='source ~/scripts/cd_fuzzy'
alias getclip='xclip -selection c -o'
alias gl='glances --disable-bg -t 2'
li() { command libreoffice "$@" & }
alias lnb='find . -xtype l' # broken symlinks
alias neofetch='neofetch --config ~/neofetch.conf'
alias or='odrive refresh .'
alias pipes='pipes -p 5 -R -t 1 -r 10000 && clear'
alias Rscript='Rscript --quiet'
alias setclip='xclip -selection c'
alias sshad='ssh adroit'
vv() { command vimiv "$@" & }
alias jpgcompress='mogrify -strip -interlace Plane -gaussian-blur 0.05 -quality 80%'

# shortcuts
alias sudo='sudo '
alias psgrep='ps -aux | grep -v "grep" | grep'
alias pacgrep='pacman -Q | grep'
alias timenow='date +"%Y/%m/%d%n%H:%M:%S.%3N%n%:z"'
gcl() { command git clone "git@github.com:WGUNDERWOOD/$@" & }

# todoist
alias tt='todoist-cli sync && todoist-cli --color list --filter "(overdue | today | p1)"'
alias tl='todoist-cli sync && todoist-cli --color list'
tq() { command todoist-cli quick "$@" && todoist-cli sync & }
tc() { command todoist-cli close "$@" && todoist-cli sync & }
td() { command todoist-cli delete "$@" && todoist-cli sync & }

# cd aliases
alias ..='cd ..'
alias ...='cd ../..'
alias cddown='cd ~/Downloads/'
alias cdconf='cd ~/.config/'
alias cdgd='cd ~/odrive/Google\ Drive/'
alias cdgdp='cd ~/odrive/Google\ Drive\ Princeton/'
alias cdhe='cd ~/odrive/Google\ Drive/Health'
alias cdgh='cd ~/Documents/github'
alias cdaoc='cd ~/Documents/github/advent-of-code-2021'
alias cdrem='cd ~/Documents/remarkable'
alias cdox='cd ~/odrive/Google\ Drive/Education/Oxford/'
alias cdoxlec='cd ~/odrive/Google\ Drive/Education/Oxford/Oxford\ Lecture\ Notes'
alias cdtextbk='cd ~/odrive/Google\ Drive/Education/Textbooks\ and\ Extra\ Notes'
alias cddb='cd ~/odrive/Dropbox/'
alias cddbp='cd ~/odrive/Dropbox\ Princeton/'
alias cdmot='cd ~/Documents/github/motifcluster'
alias cdwp='cd ~/Pictures/wallpapers'
alias cdweb='cd ~/Documents/github/wgunderwood.github.io'
alias cddot='cd ~/Documents/github/dotfiles'
alias cdk='cd ~/Documents/github/research-dyadic-kde/'
alias cdd='cd ~/Documents/github/DyadicKDE.jl/'
alias cdr='cd ~/Documents/github/research-dyadic-regression/'
alias cdf='cd ~/Documents/github/research-random-forests/'
alias cdm='cd ~/Documents/github/research-martingale-yurinskii/'
alias cdcv='cd ~/Documents/github/wgu-cv'
alias cdpic='cd ~/Pictures'
alias cdov='cd ~/Documents/overleaf'
alias cdovk='cd ~/Documents/overleaf/CFU_2021_DyadicKDE'
alias cdovm='cd ~/Documents/overleaf/CMU_2022_SAMartingale/'
alias cdovf='cd ~/Documents/overleaf/CKU_2022_MondrianRF/'
alias cdpton='cd ~/odrive/Google\ Drive/Education/Princeton'
alias cdpub='cd ~/odrive/Google\ Drive/Publications/'
alias cdmat='cd ~/odrive/Dropbox\ Princeton/00000_shared--CFF_2018_RandPartitioning/'
alias cdric='cd ~/odrive/Dropbox\ Princeton/0000_shared--Cattaneo-Masini_2021_SA-Martingale/'
alias cdjas='cd ~/odrive/Dropbox\ Princeton/0000_shared--CKU_2022_Mondrian/'
alias cdte='cd ~/odrive/Google\ Drive\ Princeton/Shared\ with\ Me/TAs_ORF363_F21'
alias cdteg='cd ~/Documents/github/orf363/'
alias cdts='cd ~/odrive/Google\ Drive/Career/Two\ Sigma'
alias cdrv='cd ~/odrive/Google\ Drive/Education/Princeton/Reviewing/'
alias cdtax='cd ~/odrive/Google\ Drive/Finances/Tax/Tax\ 2022'
alias cdnot='cd ~/odrive/Google\ Drive/Notes'
alias cdtr='cd ~/odrive/Google\ Drive/Travel'
alias cdsco='cd ~/Documents/github/music-scores/'
alias cdfel='cd ~/Documents/github/fellowship-applications/'
