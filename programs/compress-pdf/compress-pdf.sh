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
        -sOutputFile="${bfile}" "${afile}"
}

# high quality optimization
optimize_high() {
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH \
        -dDetectDuplicateImages -dCompressFonts=true \
        -dPDFSETTINGS=/ebook \
        -sOutputFile="${bfile}" "${afile}"
}

# low quality optimization
optimize_low() {
    gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dNOPAUSE -dQUIET -dBATCH \
        -dDetectDuplicateImages -dCompressFonts=true \
        -dPDFSETTINGS=/screen \
        -sOutputFile="${bfile}" "${afile}"
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
    cmp1file="${tempdir}/${infilebase}_cmp1.pdf"
    cmp2file="${tempdir}/${infilebase}_cmp2.pdf"
    outfile="$infilebase".pdf
    insize=$(du -b "${infile}" | cut -f -1)
    insizeh=$(du -bh "${infile}" | cut -f -1)
    printf "%b%-40.40s  %b%s %b-> %b" \
        "$PURPLE" "$infile" "$PINK" "$insizeh" "$WHITE" "$RESET"

    # run the selected optimizer
    afile="$infile"
    bfile="$cmp1file"
    case $quality in
        perfect) optimize_perfect ;;
        high) optimize_high ;;
        low) optimize_low ;;
    esac

    # get first compression size
    cmp1size=$(du -b "${cmp1file}" | cut -f -1)
    cmp1sizeh=$(du -bh "${cmp1file}" | cut -f -1)

    # first compression size is zero
    if [ "$cmp1size" -eq 0 ]; then
        printf "%bNo output, keeping original%b\n" "$RED" "$RESET"

    # first compression size is larger
    elif [ "$cmp1size" -ge "$insize" ]; then
        printf "%b%s%b\n" "$RED" "$cmp1sizeh" "$RESET"

    # first compression size is much smaller
    elif [ "$cmp1size" -le "$(( 9 * "$insize" / 10 ))" ]; then

        cmp1percent=$(("$cmp1size" * 100 / "$insize"))
        printf "%b%s (%s%%)%b" "$GREEN" "$cmp1sizeh" "$cmp1percent" "$RESET"
        printf "%b -> %b" "$WHITE" "$RESET"

        # compress again
        afile="$cmp1file"
        bfile="$cmp2file"
        case $quality in
            perfect) optimize_perfect ;;
            high) optimize_high ;;
            low) optimize_low ;;
        esac

        # get second compression size
        cmp2size=$(du -b "${cmp2file}" | cut -f -1)
        cmp2sizeh=$(du -bh "${cmp2file}" | cut -f -1)

        # second compression size is zero
        if [ "$cmp2size" -eq 0 ]; then
            printf "%bNo output, keeping first compression%b\n" "$RED" "$RESET"
            cp "$cmp1file" "$outfile"

        # second compression size is larger
        elif [ "$cmp2size" -ge "$cmp1size" ]; then
            printf "%b%s%b\n" "$RED" "$cmp2sizeh" "$RESET"
            cp "$cmp1file" "$outfile"

        # second compression size is smaller
        else
            cmp2percent=$(("$cmp2size" * 100 / "$insize"))
            printf "%b%s (%s%%)%b\n" "$GREEN" "$cmp2sizeh" "$cmp2percent" "$RESET"
            cp "$cmp2file" "$outfile"
        fi

    # first compression size is a little smaller
    else
        cmp1percent=$(("$cmp1size" * 100 / "$insize"))
        printf "%b%s (%s%%)%b\n" "$GREEN" "$cmp1sizeh" "$cmp1percent" "$RESET"
        cp "$cmp1file" "$outfile"
    fi

done

# clean up
rm -r "$tempdir"
exit 0
