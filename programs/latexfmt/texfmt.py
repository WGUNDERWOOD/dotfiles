import sys
import re

def remove_extra_newlines(file):
    return re.sub(r"\n\n\n+", "\n\n", file)

def remove_tabs(file):
    return re.sub("\t", TAB * " ", file)

def remove_comment(line):
    return re.sub("%.*", "", line)

def get_back(line):
    if re.match(r".*\\end{document}.*", line): return 0
    if re.match(r".*\\end{[a-z\*]*}.*", line): return 1
    back = 0
    cumul = 0
    for c in line:
        cumul -= (c in ["(", "{", "["])
        cumul += (c in [")", "}", "]"])
        back = max(cumul, back)
    return back

def get_diff(line):
    if re.match(r".*\\begin{document}.*", line): return 0
    if re.match(r".*\\end{document}.*", line): return 0
    if re.match(r".*\\begin{[a-z\*]*}.*", line): return 1
    if re.match(r".*\\end{[a-z\*]*}.*", line): return -1
    diff = 0
    diff += line.count("(")
    diff -= line.count(")")
    diff += line.count("{")
    diff -= line.count("}")
    diff += line.count("[")
    diff -= line.count("]")
    return diff

# set tab length
TAB = 2

# open file
filename = sys.argv[1]
file = open(filename, "r").read().strip("\n")

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
    print(new_line)
