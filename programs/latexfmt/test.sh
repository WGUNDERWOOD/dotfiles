#latexindent -m "in.tex" > "desired.tex"
#rm -f "indent.log" "in.tex.bak"
python texfmt.py "in.tex" > "out.tex"
diff -u "desired.tex" "out.tex" | diff-so-fancy
