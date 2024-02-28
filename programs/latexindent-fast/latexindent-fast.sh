# colors
RED='\033[1;31m'
RESET='\033[0m'

indent_and_update_sha () {
    latexindent -wd -s -m "$file"
    new_sha="$(sha256sum "$file")"
    echo "$new_sha" > "$shafile"
}

# error if no files provided
if [[ -z "$*" ]]; then
    printf "%bno input file(s) specified%b\n" "$RED" "$RESET"
    exit 1
fi

for infile in "$@"; do

    file="$(realpath "$infile")"
    sha="$(sha256sum "$file")"
    shafile="$file.latexindent.sha256"

    if [ -f "$shafile" ]; then
        oldsha="$(cat "$shafile")"
        if [ "$sha" != "$oldsha" ]; then
            # sha has changed
            indent_and_update_sha
        fi
    else
        # sha file does not exist
        indent_and_update_sha
    fi

done
