#!/usr/bin/env bash

# TODO -l for -pdflua
# TODO -x for -xelatex
# TODO -e for -shell-escape
# TODO -n for -norc

# TODO -quiet standard
# TODO -rc-report- standard
# TODO -Werror standard
# TODO grep for ignore nothing to do standard

# TODO -v to omit -quiet (verbose)
# TODO -r to omit -rc-report- (include rc report)
# TODO -w to omit -Werror (warnings are not errors)

# TODO handle files in another directory
# TODO handle multiple files
# TODO only copy pdf when ready

# get quality level from flags
#quality='perfect'
#while getopts 'hl' flag; do
    #case "${flag}" in
        #h) quality='high' ;;
        #l) quality='low' ;;
        #*) exit 1 ;;
    #esac
#done

# error if no files provided
#if [[ -z "$*" ]]; then
    #printf "%bno input file(s) specified%b\n" "$RED" "$RESET"
    #exit 1
#fi

# error if not all files are pdfs
#for infile in "$@"; do
    #if [ "${infile: -4}" != ".pdf" ]; then
        #printf "%b%s %bis not a pdf%b\n" "$PURPLE" "$infile" "$RED" "$RESET"
        #exit 1
    #fi
#done

#for infile in "$@"; do

    # set up variables and get initial file size
    #infilebase="$(basename "$infile" .pdf)"
    #outdir="$(dirname "$infile")"
    #shafile="${outdir}/${infilebase}.pdf.sha256"
    #cmpfile="${tempdir}/${infilebase}_cmp.pdf"
    #outfile="$infilebase".pdf
    #insize=$(du -b "${infile}" | cut -f -1)
    #insizeh=$(du -bh "${infile}" | cut -f -1)
    #printf "%b%-40.40s  %b%-4.4s %b-> %b" \
        #"$PURPLE" "$infile" "$PINK" "$insizeh" "$WHITE" "$RESET"
#done

# clean up
#exit 0
