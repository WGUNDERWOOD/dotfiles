

use ispell::SpellLauncher;
use regex::Regex;
use std::collections::HashMap;
use std::env;
use std::fs;
use std::io;
use std::path;

const WORDLIST_PATH: &str = "./wordlist.txt";

fn main() {
    // get filenames from arguments
    let args: Vec<String> = env::args().collect();
    assert!(args.len() >= 2, "No file provided");
    let filenames = &args[1..];

    // check wordlist and files all exist
    make_wordlist();
    assert!(filenames.iter().all(|f| path::Path::new(f).exists()));

    // read from wordlist and rewrite wordlist file
    let (accept, reject) = read_wordlist();
    rewrite_wordlist(&accept, &reject);

    for filename in filenames {
        let file = fs::read_to_string(filename).expect("Should have been able to read the file");

        // check spelling using accept list
        let mistakes = spell_check_get_mistakes(&file, &accept, &reject);

        // check aspell interprets accept list as errors
        check_accept_are_errors(&accept);

        // check aspell interprets reject list as ok
        check_reject_are_ok(&reject);
    }
}

fn make_wordlist() {
    if !path::Path::new(WORDLIST_PATH).exists() {
        println!("No wordlist.txt found! Generate a new wordlist.txt? [y] ");
        let mut generate_wordlist = String::new();
        io::stdin()
            .read_line(&mut generate_wordlist)
            .expect("Failed to read input");
        if generate_wordlist == "y\n" {
            fs::write(WORDLIST_PATH, "# accept\n\n# reject\n").unwrap();
            println!("Generated a new wordlist!");
        } else {
            panic!("Skipping wordlist.txt generation. Quitting.")
        };
    };
}

fn read_wordlist() -> (Vec<String>, Vec<String>) {
    // get the accept and reject lists
    let wordlist = fs::read_to_string(WORDLIST_PATH).unwrap();
    let wordlist_split: Vec<&str> = wordlist.split("\n\n").collect();
    assert!(wordlist_split.len() == 2, "Incorrectly formatted wordlist");
    let mut accept: Vec<String> = wordlist_split[0].split("\n").map(str::to_string).collect();
    let mut reject: Vec<String> = wordlist_split[1].split("\n").map(str::to_string).collect();
    assert!(accept[0] == "# accept", "Incorrectly formatted wordlist");
    assert!(reject[0] == "# reject", "Incorrectly formatted wordlist");
    accept.remove(0);
    reject.remove(0);
    accept.retain(|x| !x.is_empty());
    reject.retain(|x| !x.is_empty());
    accept.sort_by_key(|x| x.to_lowercase());
    reject.sort_by_key(|x| x.to_lowercase());

    // check accept and reject lists are unique
    let mut unique_words = HashMap::<String, bool>::new();
    let mut accept_reject = accept.clone();
    accept_reject.append(&mut reject.clone());

    for w in accept_reject {
        if unique_words.contains_key(&w) {
            panic!("{} is duplicated in wordlist", w)
        } else {
            unique_words.insert(w, true);
        }
    }

    (accept, reject)
}

fn rewrite_wordlist(accept: &Vec<String>, reject: &Vec<String>) {
    let mut new_wordlist: String = "# accept\n".to_owned();
    for w in accept {
        new_wordlist = String::new() + &new_wordlist + w + "\n";
    }
    new_wordlist = String::new() + &new_wordlist + "\n# reject\n";
    for w in reject {
        new_wordlist = String::new() + &new_wordlist + w + "\n";
    }
    fs::write(WORDLIST_PATH, new_wordlist).unwrap();
}

fn spell_check_get_mistakes(
    file: &str,
    accept: &Vec<String>,
    reject: &Vec<String>,
) -> Vec<(usize, String, String)> {
    // add accept list to aspell
    let mut checker = SpellLauncher::new().aspell().launch().unwrap();
    for w in accept {
        checker.add_word(w).unwrap();
    }
    // run aspell to get mistakes
    let ms = checker.check(&file.replace("\n", " ")).unwrap();
    let mut ms: Vec<String> = ms.iter().map(|x| x.misspelled.clone()).collect();
    ms.append(&mut reject.clone());
    ms.sort();
    ms.dedup();
    let ms_re: Vec<Regex> = ms
        .iter()
        .map(|w| Regex::new(&(String::new() + r"\b" + w + r"\b")).unwrap())
        .collect();

    // format mistakes as (line number, mistake word, line from file)
    let mut mistakes: Vec<(usize, String, String)> = vec![];
    let lines: Vec<&str> = file.lines().collect();
    for i in 0..lines.len() {
        let l = lines[i];
        for j in 0..ms.len() {
            if ms_re[j].is_match(l) {
                mistakes.push((i, ms[j].clone(), l.to_string()));
            }
        }
    }

    //dbg!(&mistakes);
    mistakes
}

fn check_accept_are_errors(accept: &Vec<String>) {
    let mut checker = SpellLauncher::new().aspell().launch().unwrap();
    let ms = checker.check(&accept.join(" ")).unwrap();
    let ms: Vec<String> = ms.iter().map(|x| x.misspelled.clone()).collect();
    for w in accept {
        if !ms.contains(w) {
            println!("{} does not need to be on accept list", w);
        }
    }
    assert!(&ms == accept, "Accept list contains unnecessary words.")
}

fn check_reject_are_ok(reject: &Vec<String>) {
    let mut checker = SpellLauncher::new().aspell().launch().unwrap();
    let ms = checker.check(&reject.join(" ")).unwrap();
    let ms: Vec<String> = ms.iter().map(|x| x.misspelled.clone()).collect();
    for w in &ms {
        println!("{} does not need to be on reject list", w)
    }
    assert!(ms.is_empty(), "Reject list contains unnecessary words.")
}

//# output results
//if len(mistakes) > 0:
//header = "\033[0;33m\033[1m" + check + "\033[00m\033[0m"
//print(header)

//for m in mistakes:
//linenum = "\033[0;32m\033[1m" + str(m[0] + 1) + ":\033[00m\033[0m"
//word = m[1]
//line = m[2]
//line = re.sub(word, "\033[0;31m\033[1m" + word + "\033[00m\033[0m", line)
//print(linenum + " " + line)
//
