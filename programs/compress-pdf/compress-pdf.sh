#!usr/bin/env bash

# TODO allow multiple runs

# colors
RED='\033[1;31m'
YELLOW='\033[1;33m'
PURPLE='\033[1;34m'
PINK='\033[1;35m'
GREEN='\033[1;32m'
WHITE='\033[1;37m'
RESET='\033[0m'

# get quality level from flags
quality='perfect'
while getopts 'hl' flag; do
    case "${flag}" in
        h) quality='high' ;;
        l) quality='low' ;;
        *) exit 1 ;;
    esac
done

shift $((OPTIND - 1))

# print script name and quality
printf "%bcompress-pdf (%s) %b\n" "$YELLOW" "$quality" "$RESET"

# error if no files provided
if [[ -z "$*" ]]; then
    printf "%bno input file(s) specified%b\n" "$RED" "$RESET"
    exit 1
fi

# make temporary working directory
tempdir=$(mktemp -d)

# perfect quality optimization
optimize_perfect() {
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH \
        -dDetectDuplicateImages -dCompressFonts=true \
        -sOutputFile="${tempfile}" "${infile}"
}

# high quality optimization
optimize_high() {
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH \
        -dDetectDuplicateImages -dCompressFonts=true \
        -dPDFSETTINGS=/ebook \
        -sOutputFile="${tempfile}" "${infile}"
}

# low quality optimization
optimize_low() {
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH \
        -dDetectDuplicateImages -dCompressFonts=true \
        -dPDFSETTINGS=/screen \
        -sOutputFile="${tempfile}" "${infile}"
}

# error if not all files are pdfs
for infile in "$@"; do
    if [ "${infile: -4}" != ".pdf" ]; then
        printf "%b%s %bis not a pdf%b\n" "$PURPLE" "$infile" "$RED" "$RESET"
        exit 1
    fi
done

for infile in "$@"; do

    # get initial file size
    infilebase="$(basename "$infile" .pdf)"
    tempfile="${tempdir}/${infilebase}_cmp.pdf"
    outfile="$infilebase".pdf
    insize=$(stat -c "%s" "${infile}")
    insizeh=$(du -h "${infile}" | cut -f -1)
    printf "%b%-40.40s  %b%s %b-> %b" \
        "$PURPLE" "$infile" "$PINK" "$insizeh" "$WHITE" "$RESET"

    # run the selected optimizer
    case $quality in
        perfect) optimize_perfect ;;
        high) optimize_high ;;
        low) optimize_low ;;
    esac

    # get new size
    tempsize=$(stat -c "%s" "${tempfile}")
    tempsizeh=$(du -h "${tempfile}" | cut -f -1)

    # handle new size
    if [ "$tempsize" -eq 0 ]; then
        echo "No output, keeping original"
        printf "%bNo output, keeping original%b\n" "$RED" "$RESET"
    fi
    if [ "$tempsize" -ge "$insize" ]; then
        printf "%b%s%b\n" "$RED" "$tempsizeh" "$RESET"
    else
        percentage=$(("$tempsize" * 100 / "$insize"))
        printf "%b%s (%s%%)%b\n" "$GREEN" "$tempsizeh" "$percentage" "$RESET"
        cp "$tempfile" "$outfile"
    fi

done

# clean up
rm -r "$tempdir"
exit 0
