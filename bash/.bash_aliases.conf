# .bash_aliases
# TODO this should be .sh not .conf

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

# rclone
# TODO rclone config in nix with secrets
# TODO move these functions to a script
# TODO rclone other remotes
# TODO filter files manage with nix
rclgdpl() {
    echo -e "\e[0;35m\033[1mrclone pull Google Drive\e[0;30m\033[0m";
    rclone sync -i -u \
        --exclude-from /home/will/github/dotfiles/rclone/rclone_excludes_google_drive.txt \
        google_drive: \
        ~/rclone/google_drive/;
    #rclone sync -i -u --drive-shared-with-me \
        #--exclude-from /home/will/github/dotfiles/rclone/rclone_excludes_google_drive.txt \
        #google_drive: \
        #~/rclone/google_drive/Shared/;
}
#rclgdps() {
    #echo -e "\e[0;35m\033[1mrclone push Google Drive\e[0;30m\033[0m";
    #rclone sync -i -u --drive-shared-with-me \
        #--exclude-from /home/will/github/dotfiles/rclone/rclone_excludes_google_drive.txt \
        #~/rclone/google_drive/ \
        #google_drive:;
#}
#rclgdppl() {
    #echo -e "\e[0;35m\033[1mrclone pull Google Drive Princeton\e[0;30m\033[0m";
    #rclone sync -i -u --drive-shared-with-me \
        #--exclude-from /home/will/github/dotfiles/rclone/rclone_excludes_google_drive_princeton.txt \
        #google_drive_princeton: \
        #~/rclone/google_drive_princeton/;
#}
#rclgdpps() {
    #echo -e "\e[0;35m\033[1mrclone push Google Drive Princeton\e[0;30m\033[0m";
    #rclone sync -i -u --drive-shared-with-me \
        #--exclude-from /home/will/github/dotfiles/rclone/rclone_excludes_google_drive_princeton.txt \
        #~/rclone/google_drive_princeton/ \
        #google_drive_princeton:;
#}

# TODO write a simple "view file script"
# TODO write a simple "edit file script"

# programs
alias b='bat --theme Dracula'
alias c='cd'
alias g='git'
alias m='(cd ~/downloads; neomutt)'
alias n='nvim'
z() { command zathura "$@" & }
#alias bibd='bibtex-download' # TODO
alias bm='btm'
alias cava='cava -p ~/cava.conf'
#alias cf='source ~/scripts/cd_fuzzy' # TODO
#alias fp='fd_git' # TODO
#alias rp='rg_git' # TODO
li() { command libreoffice "$@" & }
alias neofetch='neofetch --config ~/neofetch.conf'
#alias repos='(cd ~/Documents && git_status_all)' # TODO
#alias reposf='(cd ~/Documents && git_status_all -f)' # TODO
vv() { command vimiv "$@" & }
alias jpgcompress='mogrify -strip -interlace Plane -gaussian-blur 0.05 -quality 80%'
alias nixr='sudo nixos-rebuild switch'

# shortcuts
alias psgrep='ps -aux | grep -v "grep" | grep'
alias timenow='date +"%Y/%m/%d%n%H:%M:%S.%3N%n%:z"'
gcl() { command git clone "git@github.com:WGUNDERWOOD/$@" & }

# todoist
#alias tt='todoist-cli sync && todoist-cli --color list --filter "(overdue | today | p1)"' # TODO
#alias tl='todoist-cli sync && todoist-cli --color list' # TODO
#tq() { command todoist-cli quick "$@" && todoist-cli sync & } # TODO
#tc() { command todoist-cli close "$@" && todoist-cli sync & } # TODO
#td() { command todoist-cli delete "$@" && todoist-cli sync & } # TODO

# cd aliases
alias ..='cd ..'
alias ...='cd ../..'
#alias cddown='cd ~/Downloads/'
#alias cdconf='cd ~/.config/'
#alias cddoc='cd ~/Documents/'
#alias cdgd='cd ~/odrive/Google\ Drive/'
#alias cdgdp='cd ~/odrive/Google\ Drive\ Princeton/'
#alias cdhe='cd ~/odrive/Google\ Drive/Health'
#alias cdgh='cd ~/Documents/github'
#alias cdmon='cd ~/Documents/github/MondrianForests.jl'
#alias cdaoc='cd ~/Documents/github/advent-of-code-2021'
#alias cdrem='cd ~/Documents/remarkable'
#alias cdox='cd ~/odrive/Google\ Drive/Education/Oxford/'
#alias cdoxlec='cd ~/odrive/Google\ Drive/Education/Oxford/Oxford\ Lecture\ Notes'
#alias cdtextbk='cd ~/odrive/Google\ Drive/Education/Textbooks\ and\ Extra\ Notes'
#alias cddb='cd ~/odrive/Dropbox/'
#alias cddbp='cd ~/odrive/Dropbox\ Princeton/'
#alias cdmot='cd ~/Documents/github/motifcluster'
#alias cdwp='cd ~/Pictures/wallpapers'
#alias cdweb='cd ~/Documents/github/wgunderwood.github.io'
#alias cddot='cd ~/Documents/github/dotfiles'
#alias cdk='cd ~/Documents/github/research-dyadic-kde/'
#alias cdd='cd ~/Documents/github/DyadicKDE.jl/'
#alias cdr='cd ~/Documents/github/research-dyadic-regression/'
#alias cdf='cd ~/Documents/github/research-random-forests/'
#alias cdm='cd ~/Documents/github/research-martingale-yurinskii/'
#alias cdjob='cd ~/Documents/github/job-search-2023'
#alias cdac='cd ~/odrive/Dropbox\ Princeton/Underwood_Academic_Applications_2023'
#alias cdcv='cd ~/Documents/github/wgu-cv'
#alias cdpic='cd ~/Pictures'
#alias cdov='cd ~/Documents/overleaf'
#alias cdovk='cd ~/Documents/overleaf/CFU_2021_DyadicKDE'
#alias cdovm='cd ~/Documents/overleaf/CMU_2022_SAMartingale/'
#alias cdovf='cd ~/Documents/overleaf/CKU_2022_MondrianRF/'
#alias cdpton='cd ~/odrive/Google\ Drive/Education/Princeton'
#alias cdpub='cd ~/odrive/Google\ Drive/Publications/'
#alias cdmat='cd ~/odrive/Dropbox\ Princeton/00000_shared--CFF_2018_RandPartitioning/'
#alias cdric='cd ~/odrive/Dropbox\ Princeton/0000_shared--Cattaneo-Masini_2021_SA-Martingale/'
#alias cdjas='cd ~/odrive/Dropbox\ Princeton/0000_shared--CKU_2022_Mondrian/'
#alias cdjob='cd ~/Documents/github/job-search-2023'
#alias cdte='cd ~/odrive/Dropbox\ Princeton/2023Fall_ORF498/'
#alias cdts='cd ~/odrive/Google\ Drive/Career/Two\ Sigma'
#alias cdrv='cd ~/odrive/Google\ Drive/Education/Princeton/Reviewing/'
#alias cdtax='cd ~/odrive/Google\ Drive/Finances/Tax/Tax\ 2022'
#alias cdnot='cd ~/odrive/Google\ Drive/Notes'
#alias cdtr='cd ~/odrive/Google\ Drive/Travel'
#alias cdsco='cd ~/Documents/github/music-scores/'
#alias cdfel='cd ~/Documents/github/fellowship-applications/'
