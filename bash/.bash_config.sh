# .bashrc

# settings
set -o vi
bind '"kj":vi-movement-mode'
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'
bind -m vi-command 'Control-p: history-search-backward'
bind -m vi-insert 'Control-p: history-search-backward'
bind -m vi-command 'Control-n: history-search-forward'
bind -m vi-insert 'Control-n: history-search-forward'
## TODO git autocompletion
#__git_complete g __git_main

# directories
mkdir -p ~/mail/gmail/
mkdir -p ~/mail/princeton/

export PATH=$PATH:$HOME/scripts/
export RIPGREP_CONFIG_PATH="$HOME/.config/.ripgreprc"

# history
HISTCONTROL=ignoreboth

# colors
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
export LS_COLORS="$(vivid generate dracula)"
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:
    caret=01;32:locus=01:quote=01'
export FZF_DEFAULT_OPTS='--color=fg:#dddddd,bg:#181a26,hl:#bd93f9
    --color=fg+:#ffffff,bg+:#181a26,hl+:#bd93f9
    --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6
    --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'
