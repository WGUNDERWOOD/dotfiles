cp "in.tex" "out.tex"
python tex-fmt.py "out.tex"
diff -u "desired.tex" "out.tex" | diff-so-fancy
