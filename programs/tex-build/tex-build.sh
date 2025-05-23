#!/usr/bin/env bash

# colors
RED='\033[1;31m'
YELLOW='\033[1;33m'
PINK='\033[1;35m'
RESET='\033[0m'

# get flags from user
pdf="-pdf"
quiet="-quiet"
report="-rc-report-"
warn=""
esc=""
norc=""

while getopts 'lxenvw' flag; do
    case "${flag}" in
        l) pdf="-pdflua" ;;
        x) pdf="-xelatex" ;;
        e) esc="-shell-escape" ;;
        n) norc="-norc" ;;
        v) quiet=""; report="" ;;
        w) warn="-Werror" ;;
        *) exit 1 ;;
    esac
done

shift $((OPTIND - 1))

# get around empty flags
if [[ -z "$quiet" ]]; then quiet="$pdf"; fi
if [[ -z "$report" ]]; then report="$pdf"; fi
if [[ -z "$warn" ]]; then warn="$pdf"; fi
if [[ -z "$esc" ]]; then esc="$pdf"; fi
if [[ -z "$norc" ]]; then norc="$pdf"; fi

# error if no files provided
if [[ -z "$*" ]]; then
    printf "%bno input file(s) specified%b\n" "$RED" "$RESET"
    exit 1
fi

# error if not all files are tex
for file in "$@"; do
    if [ "${file: -4}" != ".tex" ]; then
        printf "%b%s %bis not a tex file%b\n" "$YELLOW" "$file" "$RED" "$RESET"
        exit 1
    fi
done

# print script name
printf "%b%s%b\n" "$PINK" "tex-build" "$RESET"

for file in "$@"; do

    # get absolute paths and print file
    filepath="$(realpath "$file")"
    dir="$(dirname "$filepath")"
    printf "%b%s%b\n" "$YELLOW" "$file" "$RESET"

    # set basic grep colors
    GREP_COLORS_BASE=":mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36"

    # run latexmk
    (
    cd "$dir"
    (latexmk "$pdf" "$quiet" "$report" "$warn" \
        -pdflatex="pdflatex -synctex=1 %O %S" \
        -lualatex="lualatex -synctex=1 %O %S" \
        -xelatex="xelatex -synctex=1 %O %S" \
        "$esc" "$norc" "$filepath" 2>&1) | \
        { grep --line-buffered -v -e \
            "^Latexmk: Nothing to do for " -e "^$" || true; } | \
        { GREP_COLORS="ms=01;34$GREP_COLORS_BASE" \
            grep --line-buffered --color=always -E \
                "Latexmk:|$" || true; } | \
        { GREP_COLORS="ms=01;36$GREP_COLORS_BASE" \
            grep --line-buffered --color=always -E \
                "Run number .*|$" || true; }
    )

done

exit 0
