#!/usr/bin/env python3

import pretty_errors
import re
import sys
import unidecode
from pathlib import Path
import feedparser
import urllib.request
import json

def slugify(s):
    s = s.strip().replace(" ", "_")
    s = s.strip().replace("'", "")
    s = unidecode.unidecode(s)
    return re.sub(r"(?u)[^-\w.]", "", s)

def parse_arxiv(filename):
    ident = filename.stem
    source = "arxiv"
    feed = feedparser.parse(f"http://export.arxiv.org/api/query?id_list={ident}&max_results=1")
    paper = feed.entries[0]
    authors = [a.name.split()[-1] for a in paper["authors"]]
    year = paper.published_parsed.tm_year
    title = [w.capitalize() for w in paper["title"].split()]
    return dict(title = title, authors = authors, year = year,
                ident = ident, source = source)

def parse_science_direct(filename):

    # get doi
    ident = str(filename)[7:len(str(filename))-9]
    url = "http://www.sciencedirect.com/science/article/pii/" + ident
    headers = {
        "User-Agent":
        ("Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) "
         "Chrome/47.0.2526.106 Safari/537.36")}
    req = urllib.request.Request(url, headers=headers)
    html = urllib.request.urlopen(req).read().decode('utf8').replace("\n", "")
    doi_regex = ".*(\"doi\":\"[a-zA-Z0-9/\.\(\)\-]*\").*"
    doi_match = re.match(doi_regex, html).group(1)
    doi = doi_match[7:len(doi_match)-1]

    # use doi to get info
    url = "https://doi.org/" + doi
    headers = {
        "User-Agent":
        ("Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) "
         "Chrome/47.0.2526.106 Safari/537.36"),
        "Accept": "application/json; charset=utf-8"}
    req = urllib.request.Request(url, headers=headers)
    paper = urllib.request.urlopen(req).read()
    paper = paper.decode('utf8')
    paper = json.loads(paper)

    # format info
    authors_list = paper["author"]
    first_authors = [a["family"] for a in authors_list if a["sequence"] == "first"]
    other_authors = [a["family"] for a in authors_list if a["sequence"] != "first"]
    authors = first_authors + other_authors
    title = paper["title"].split(" ")
    year = paper["published-print"]["date-parts"][0][0]
    source = "science-direct"
    return dict(title = title, authors = authors, year = year,
                ident = ident, source = source)

def parse_jstor(filename):

    # get citation
    ident = filename.stem
    url = "https://www.jstor.org/citation/ris/" + ident
    headers = {
        "User-Agent":
        ("Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) "
         "Chrome/47.0.2526.106 Safari/537.36")}
    req = urllib.request.Request(url, headers=headers)
    bib = urllib.request.urlopen(req).read().decode('utf8').replace("\r", "").split("\n")

    # format info
    authors = [b[2:] for b in bib if b[0:2] == "AU"]
    authors = [re.match("[ -]*([a-zA-Z]*),", a).group(1) for a in authors]
    title = [b[2:] for b in bib if b[0:2] == "TI"][0]
    title = re.match(" *- *([a-zA-Z ]*)", title).group(1)
    title = title.split(" ")
    year = [b[2:] for b in bib if b[0:2] == "PY"][0]
    year = re.match(" *- *([0-9]{4})", year).group(1)
    source = "jstor"
    return dict(title = title, authors = authors, year = year,
                ident = ident, source = source)

def save_file(info):
    title_excluded_words = ["A", "An", "And", "The", "On", "When", "For",
                            "Can", "Note", "Of", "With"]
    title_words = [w.title() for w in info["title"] if w.title() not in title_excluded_words]
    title = slugify("-".join(title_words[0:2]))
    authors = [a.title() for a in info["authors"]]
    authors = slugify("-".join(authors[0:min(5, len(authors))]))
    year = info["year"]
    ident = info["ident"]
    source = info["source"]
    new_filename = filename.with_stem(f"{authors}_{year}_{title}_{source}-{ident}")
    message = ("\033[0;33m\033[1m" + str(filename) + "\033[00m\033[0m" +
               "\033[00m\033[1m --> \033[00m\033[0m" +
               "\033[0;32m\033[1m" + str(new_filename) + "\033[00m\033[0m")
    print(message)
    if not new_filename.exists():
        filename.rename(new_filename)
    else:
        print("\033[0;31m\033[1mFile already exists\033[00m\033[0m")

if __name__ == "__main__":
    filename = Path(sys.argv[1])
    arxiv_regex = "^[0-9]{4}\.[0-9]{4}[0-9]?\.pdf$"
    science_direct_regex = "^1-s2\.0-[A-Z]?[0-9].*-main\.pdf$"
    jstor_regex = "^[0-9]*\.pdf$"

    if re.match(arxiv_regex, str(filename)):
        save_file(parse_arxiv(filename))

    elif re.match(science_direct_regex, str(filename)):
        save_file(parse_science_direct(filename))

    elif re.match(jstor_regex, str(filename)):
        save_file(parse_jstor(filename))

    else:
        raise ValueError("Filename format not recognized!")
