#!usr/bin/env python3

import sys
from habanero import Crossref, cn
import pyperclip as pc
import unidecode
import re
from colorama import Fore, Style

assert len(sys.argv) >= 2, "Please provide a search query"

cr = Crossref()
GREEN = Fore.GREEN + Style.BRIGHT
WHITE = Style.BRIGHT
CYAN = Fore.CYAN + Style.BRIGHT
PINK = Fore.MAGENTA + Style.BRIGHT
RESET = Style.RESET_ALL
arg = " ".join(sys.argv[1:])
results = cr.works(query = arg)
max_results = 10
results = results["message"]["items"][0:max_results]

def slugify(s):
    s = s.replace("'", "")
    s = unidecode.unidecode(s)
    return s

def truncate(s):
    l = 70
    if len(s) <= l:
        return s
    else:
        return s[0:l] + "..."

for i in reversed(range(len(results))):
    result = results[i]
    pad = (len(str(i+1)) + 2) * " "
    print(GREEN + str(i+1) + ") " + RESET, end = "")

    try:
        authors = "-".join([author["family"] for author in result["author"]])
        print(WHITE + slugify(authors) + RESET)
    except:
        print()

    try:
        year = result["published-print"]["date-parts"][0][0]
        print(pad + str(year))
    except:
        pass

    try:
        title = truncate(result["title"][0])
        print(pad + slugify(title))
    except:
        pass

    try:
        journal = truncate(result["short-container-title"][0])
        print(pad + slugify(journal))
    except:
        pass

    print()

# get choice from user
choice = input(CYAN + "Select (default 1): " + RESET)
if len(choice) >= 1:
    choice = int(choice)
else:
    choice = 1
result = results[choice - 1]
doi = result["DOI"]

# format bibtex item
bibtex = cn.content_negotiation(ids=doi, format="bibentry")
bibtex_formatted = ""
brace_count = 0
for c in bibtex:
    if c == "{":
        brace_count += 1
    elif c == "}":
        brace_count -= 1
    if brace_count == 1 and c == ",":
        bibtex_formatted += c
        bibtex_formatted += "\n   "
    elif brace_count == 0 and c == "}":
        bibtex_formatted += "\n"
        bibtex_formatted += c
    else:
        bibtex_formatted += c
if bibtex_formatted[0] == " ":
    bibtex_formatted = bibtex_formatted[1:]
bibtex_formatted = bibtex_formatted.replace(" \n", "\n")

# print bibtex item
print()
print(PINK + bibtex_formatted + RESET)
pc.copy(bibtex_formatted)
print(GREEN + "Copied to clipboard!" + RESET)
