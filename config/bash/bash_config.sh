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

# directories
rm -fd ~/Downloads/
mkdir -p ~/downloads/
mkdir -p ~/mail/gmail/
mkdir -p ~/mail/cambridge/

export PATH=$PATH:$HOME/scripts/
export RIPGREP_CONFIG_PATH="$HOME/.config/.ripgreprc"

# history
HISTCONTROL=ignoreboth
PROMPT_COMMAND='history -a'
mkdir -p "$XDG_STATE_HOME/bash/"
mkdir -p "$XDG_CACHE_HOME/less/"
source "$(fzf-share)/key-bindings.bash"
source "$(fzf-share)/completion.bash"

# colors
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
export LS_COLORS="$(vivid generate catppuccin-mocha)"
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:
    caret=01;32:locus=01:quote=01'
export FZF_DEFAULT_OPTS='
    --color=bg+:#1e1e2e,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8
    --color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#89dceb
    --color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8
    --color=selected-bg:#45475a
    --color=border:#313244,label:#cdd6f4'

# zoxide
export _ZO_DOCTOR=0
eval "$(zoxide init --cmd cd bash)"
