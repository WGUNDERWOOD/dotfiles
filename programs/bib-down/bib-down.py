# TODO split the resulting text into multiple lines

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

for i in range(len(results)):
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

choice = input(CYAN + "Select (default 1): " + RESET)

if len(choice) >= 1:
    choice = int(choice)
else:
    choice = 1

result = results[choice - 1]
doi = result["DOI"]
bibtex = cn.content_negotiation(ids=doi, format="bibentry")
print()
print(WHITE + bibtex + RESET)
print()
pc.copy(bibtex)
print(GREEN + "Copied to clipboard!" + RESET)
