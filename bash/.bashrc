# ~/.bashrc
##############################

# PATH
export PATH=$PATH:$HOME/scripts/
export PATH=$PATH:$HOME/.odrive-agent/bin
export PATH=$PATH:$HOME/.gem/ruby/3.0.0/bin
export PATH="$HOME/.rbenv/shims:$PATH"
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.cargo/bin

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# fzf
export FZF_DEFAULT_OPTS='--color=fg:#dddddd,bg:#181a26,hl:#bd93f9
    --color=fg+:#ffffff,bg+:#181a26,hl+:#bd93f9
    --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6
    --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

# zoxide
eval "$(zoxide init --no-cmd bash)"

# exa colors
LS_COLORS="$(vivid generate dracula)"

# rust path
export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/library

# openai key
export OPENAI_API_KEY=$(cat .openai_api_key)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# vi mode
set -o vi
bind '"kj":vi-movement-mode'

# colored man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# configure editor
export ALTERNATE_EDITOR="vim"
export EDITOR='nvim'
export VISUAL='nvim'

# aliases
source $HOME/.bash_aliases

# git autocomplete
source /usr/share/bash-completion/completions/git
__git_complete g __git_main

# make autocomplete
complete -W "\`grep -oE '^[a-zA-Z0-9_.-]+:([^=]|$)' ?akefile | sed 's/[^a-zA-Z0-9_.-]*$//'\`" make

# ripgrep config
export RIPGREP_CONFIG_PATH="$HOME/.config/.ripgreprc"

# starship prompt
eval "$(starship init bash)"
