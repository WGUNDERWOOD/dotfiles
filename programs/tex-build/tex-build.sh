#!/usr/bin/env bash

# TODO only copy pdf when it is ready, use latexmk -outdir
# TODO print options if work being done
# TODO print file name

# colors
RED='\033[1;31m'
YELLOW='\033[1;33m'
PURPLE='\033[1;34m'
PINK='\033[1;35m'
GREEN='\033[1;32m'
WHITE='\033[1;37m'
RESET='\033[0m'

# get flags from user
pdf="-pdf"
quiet="-quiet"
report="-rc-report-"
warn="-Werror"

while getopts 'lxenvrw' flag; do
    case "${flag}" in
        l) pdf="-pdflua" ;;
        x) pdf="-xelatex" ;;
        e) esc="-shell-escape" ;;
        n) norc="-norc" ;;
        v) quiet="" ;;
        r) report="" ;;
        w) warn="" ;;
        *) exit 1 ;;
    esac
done

shift $((OPTIND - 1))

# error if no files provided
if [[ -z "$*" ]]; then
    printf "%bno input file(s) specified%b\n" "$RED" "$RESET"
    exit 1
fi

# error if not all files are tex
for file in "$@"; do
    if [ "${file: -4}" != ".tex" ]; then
        printf "%b%s %bis not a tex file%b\n" "$PURPLE" "$file" "$RED" "$RESET"
        exit 1
    fi
done

for file in "$@"; do

    filepath="$(realpath "$file")"
    dir="$(dirname "$filepath")"
    (cd $dir &&
        latexmk "$pdf" "$quiet" "$report" "$warn" "$filepath" | \
            grep -v 'Latexmk: Nothing to do for' | grep '^.' || true
    )

done

exit 0
