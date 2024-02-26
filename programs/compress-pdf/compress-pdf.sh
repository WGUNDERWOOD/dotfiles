#!usr/bin/env bash

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
case $quality in
    perfect) printf "%bcompress-pdf %b\n" "$YELLOW" "$RESET" ;;
    high) printf "%bcompress-pdf (%s) %b\n" "$YELLOW" "$quality" "$RESET" ;;
    low) printf "%bcompress-pdf (%s) %b\n" "$YELLOW" "$quality" "$RESET" ;;
esac


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
        -sOutputFile="${cmpfile}" "${infile}"
}

# high quality optimization
optimize_high() {
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH \
        -dDetectDuplicateImages -dCompressFonts=true \
        -dPDFSETTINGS=/ebook \
        -sOutputFile="${cmpfile}" "${infile}"
}

# low quality optimization
optimize_low() {
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH \
        -dDetectDuplicateImages -dCompressFonts=true \
        -dPDFSETTINGS=/screen \
        -sOutputFile="${cmpfile}" "${infile}"
}

# error if not all files are pdfs
for infile in "$@"; do
    if [ "${infile: -4}" != ".pdf" ]; then
        printf "%b%s %bis not a pdf%b\n" "$PURPLE" "$infile" "$RED" "$RESET"
        exit 1
    fi
done

for infile in "$@"; do

    # set up variables and get initial file size
    infilebase="$(basename "$infile" .pdf)"
    outdir="$(dirname "$infile")"
    shafile="${outdir}/${infilebase}.pdf.sha256"
    cmpfile="${tempdir}/${infilebase}_cmp.pdf"
    outfile="$infilebase".pdf
    insize=$(du -b "${infile}" | cut -f -1)
    insizeh=$(du -bh "${infile}" | cut -f -1)
    printf "%b%-40.40s  %b%-4.4s %b-> %b" \
        "$PURPLE" "$infile" "$PINK" "$insizeh" "$WHITE" "$RESET"

    # check if a sha matches
    sha="$(sha256sum "$infile")"
    shamatch="false"
    if [ -f "$shafile" ]; then
        oldsha="$(cat "$shafile")"
        if [ "$sha" == "$oldsha" ]; then
            shamatch="true"
            printf "%b%s%b\n" "$GREEN" "SHA match" "$RESET"
        fi
    fi

    # if no sha match then run the optimizer
    if [ "$shamatch" != "true" ]; then

        # run the selected optimizer
        case $quality in
            perfect) optimize_perfect ;;
            high) optimize_high ;;
            low) optimize_low ;;
        esac

        # get first compression size
        cmpsize=$(du -b "${cmpfile}" | cut -f -1)
        cmpsizeh=$(du -bh "${cmpfile}" | cut -f -1)

        # first compression size is zero, keep original
        if [ "$cmpsize" -eq 0 ]; then
            printf "%bNo output, keeping original%b\n" "$RED" "$RESET"

        # first compression size is larger, keep original and save hash
        elif [ "$cmpsize" -ge "$insize" ]; then
            echo "$sha" > "$shafile"
            printf "%b%s%b\n" "$RED" "$cmpsizeh" "$RESET"

        # first compression size is smaller, keep compressed file
        else
            cmppercent=$(("$cmpsize" * 100 / "$insize"))
            printf "%b%s (%s%%)%b\n" "$GREEN" "$cmpsizeh" "$cmppercent" "$RESET"
            cp "$cmpfile" "$outdir/$outfile"
        fi

    fi

done

# clean up
rm -r "$tempdir"
exit 0
