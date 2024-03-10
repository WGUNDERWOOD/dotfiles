import sys
import os
import shutil
import re

def remove_extra_newlines(file):
    return re.sub(r"\n\n\n+", "\n\n", file)

def remove_tabs(file):
    return re.sub("\t", TAB * " ", file)

def remove_comment(line):
    new_line = re.sub("\\\%", "", line)
    return re.sub("%.*", "", new_line)

def get_back(line):
    # no deindentation for ending document
    if re.match(r".*\\end{document}.*", line): return 0
    # list environments get double indents for indenting items
    for l in LISTS:
        if re.match(r".*\\end{%s}.*" % l, line): return 2
    # other environments get single indents
    if re.match(r".*\\end{[a-z\*]*}.*", line): return 1
    # deindent items to make the rest of item environment appear indented
    if re.match(r".*\\item.*", line): return 1
    back = 0
    cumul = 0
    for c in line:
        cumul -= (c in OPENS)
        cumul += (c in CLOSES)
        back = max(cumul, back)
    return back

def get_diff(line):
    # no indentation for document
    if re.match(r".*\\begin{document}.*", line): return 0
    if re.match(r".*\\end{document}.*", line): return 0
    diff = 0
    # list environments get double indents
    for l in LISTS:
        if re.match(r".*\\begin{%s}.*" % l, line): diff += 1
        if re.match(r".*\\end{%s}.*" % l, line): diff -= 1
    # other environments get single indents
    if re.match(r".*\\begin{[a-z\*]*}.*", line): diff += 1
    if re.match(r".*\\end{[a-z\*]*}.*", line): diff -= 1
    # delimiters
    for c in OPENS:
        diff += line.count(c)
    for c in CLOSES:
        diff -= line.count(c)
    return diff

# set constants
TAB = 2
OPENS = ["(", "[", "{"]
CLOSES = [")", "]", "}"]
LISTS = ["itemize", "enumerate", "description"]

# open file
filename = sys.argv[1]
file = open(filename, "r").read()

# preformat
file = remove_extra_newlines(file)
file = remove_tabs(file)
lines = file.split("\n")

# calculate indents
count = 0
itemize = False
indents = [0 for _ in lines]

for i in range(len(lines)):
    line = lines[i]
    line = remove_comment(line)
    back = get_back(line)
    diff = get_diff(line)
    indent = count - back
    assert indent >= 0
    indents[i] = indent
    count += diff

# check indents returns to zero
assert indents[0] == 0
assert indents[-1] == 0

# apply indents
new_lines = ["" for _ in lines]
for i in range(len(lines)):
    line = lines[i]
    new_line = line.lstrip(" ")
    if new_line != "":
        new_line = (indents[i] * TAB * " ") + new_line
    new_lines[i] = new_line

# backup original file and write
filepath = os.path.abspath(filename)
shutil.copy(filepath, filepath + ".bak")
new_file = "\n".join(new_lines)
open(filepath + "_new.tex", "w").write(new_file)
