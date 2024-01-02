# TODO detect no inputs and warn
# TODO handle multiple inputs
# TODO output one line per file

# colors
RED='\033[1;31m'
YELLOW='\033[1;33m'
PURPLE='\033[1;34m'
PINK='\033[1;35m'
GREEN='\033[1;32m'
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

# get file to process
shift $((OPTIND - 1))
infile="$*"

# error if no file provided
if [ "$infile" == "" ]; then
    printf "%bno input file specified%b\n" "$RED" "$RESET"
    exit 1
fi

# error if not a pdf
if [ "${infile: -4}" != ".pdf" ]; then
    printf "%b%s %bis not a pdf%b\n" "$PURPLE" "$infile" "$RED" "$RESET"
    exit 1
fi

# make temporary working directory
tempdir=$(mktemp -d)
infilebase="$(basename "$infile" .pdf)"
tempfile="${tempdir}/${infilebase}_cmp.pdf"
outfile="$infilebase".pdf
insize=$(stat -c "%s" "${infile}")
insizeh=$(du -h "${infile}" | cut -f -1)
printf "%bCompressing: %b%s%b\n" "$YELLOW" "$PURPLE" "$infile" "$RESET"
printf "%bQuality: %b%s%b\n" "$YELLOW" "$PURPLE" "$quality" "$RESET"
printf "%bInitial size: %b%s%b\n" "$YELLOW" "$PINK" "$insizeh" "$RESET"

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
    printf "%bFinal size: %b%s%b\n" "$YELLOW" "$RED" "$tempsizeh" "$RESET"
    printf "%bDidn't make smaller, keeping original%b\n" "$RED" "$RESET"
else
    percentage=$(("$tempsize" * 100 / "$insize"))
    printf "%bFinal size: %b%s (%s%%)%b\n" "$YELLOW" "$GREEN" "$tempsizeh" "$percentage" "$RESET"
    cp "$tempfile" "$outfile"
    printf "%bNew file: %b%s%b\n" "$YELLOW" "$GREEN" "$outfile" "$RESET"
fi

# clean up
rm -r "$tempdir"
exit 0
