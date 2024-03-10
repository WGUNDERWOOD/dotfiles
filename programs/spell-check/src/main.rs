use regex::Regex;
use std::collections::HashMap;
use std::env;
use std::fs;
use std::io;
use std::path;
use std::process::Command;
use std::process::Stdio;

// path for wordlist file
const WORDLIST_PATH: &str = "./wordlist.txt";

// declare colors
const YELLOW: &str = "\x1b[33m\x1b[1m";
const PINK: &str = "\x1b[35m\x1b[1m";
const GREEN: &str = "\x1b[32m\x1b[1m";
const RED: &str = "\x1b[31m\x1b[1m";
const RESET: &str = "\x1b[00m\x1b[0m";

fn main() {
    // get filenames from arguments
    let args: Vec<String> = env::args().collect();
    assert!(args.len() >= 2, "No file provided");
    let filenames = &args[1..];

    // print script name
    println!("{}", String::new() + PINK + "spell-check" + RESET);

    // check wordlist and files all exist
    make_wordlist();
    assert!(filenames.iter().all(|f| path::Path::new(f).exists()));

    // read from wordlist and rewrite wordlist file
    let (accept, reject) = read_wordlist();
    write_temp_files(&accept, &reject);
    rewrite_wordlist(&accept, &reject);
    check_accept_are_errors(&accept);
    check_reject_are_ok();

    for filename in filenames {
        // print filename and read file
        println!("{}", String::new() + YELLOW + filename + RESET);
        let file = fs::read_to_string(filename).expect("Should have been able to read the file");
        let mistakes = spell_check_get_mistakes(filename, &file, &reject);

        // output results
        for m in mistakes {
            print!(
                "{}",
                String::new() + GREEN + &(m.0 + 1).to_string() + ": " + RESET
            );

            let mut formatted: String = m.2.to_string();
            for w in m.1 {
                let colored_w = String::new() + RED + &w + RESET;
                formatted = formatted.replace(&w, &colored_w);
            }
            println!("{}", &formatted);
        }
    }
    clean_up();
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
    let mut accept: Vec<String> = wordlist_split[0].split('\n').map(str::to_string).collect();
    let mut reject: Vec<String> = wordlist_split[1].split('\n').map(str::to_string).collect();
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
    filename: &str,
    file: &str,
    reject: &Vec<String>,
) -> Vec<(usize, Vec<String>, String)> {
    // run aspell to get mistakes
    fs::copy(filename, ".spell_file.tmp").unwrap();
    let output_cat = Command::new("cat")
        .arg(".spell_file.tmp")
        .stdout(Stdio::piped())
        .spawn()
        .unwrap();
    let output_aspell = Command::new("aspell")
        .args(["--home-dir=.", "--personal=.spell_accept.tmp", "-t", "list"])
        .stdin(Stdio::from(output_cat.stdout.unwrap()))
        .stdout(Stdio::piped())
        .spawn()
        .unwrap();
    let output = output_aspell.wait_with_output().unwrap();
    let output_string = String::from_utf8_lossy(&output.stdout);
    let mut ms: Vec<String> = output_string.split('\n').map(str::to_string).collect();

    // format mistakes
    ms.append(&mut reject.to_owned());
    ms.sort();
    ms.dedup();
    ms.retain(|x| !x.is_empty());
    let ms_re: Vec<Regex> = ms
        .iter()
        .map(|w| Regex::new(&(String::new() + r"\b" + w + r"\b")).unwrap())
        .collect();

    // format mistakes as (line number, mistake words, line from file)
    let mut mistakes: Vec<(usize, Vec<String>, String)> = vec![];
    let lines: Vec<&str> = file.lines().collect();
    for (i, l) in lines.iter().enumerate() {
        let words: Vec<String> = (0..ms.len())
            .filter(|&j| ms_re[j].is_match(l))
            .map(|j| ms[j].clone())
            .collect();
        if !words.is_empty() {
            mistakes.push((i, words, l.to_string()));
        }
    }
    mistakes
}

fn check_accept_are_errors(accept: &Vec<String>) {
    let output_tail = Command::new("tail")
        .args(["-n", "+2", ".spell_accept.tmp"])
        .stdout(Stdio::piped())
        .spawn()
        .unwrap();
    let output_aspell = Command::new("aspell")
        .args(["--home-dir=.", "-t", "list"])
        .stdin(Stdio::from(output_tail.stdout.unwrap()))
        .stdout(Stdio::piped())
        .spawn()
        .unwrap();
    let output = output_aspell.wait_with_output().unwrap();
    let output_string = String::from_utf8_lossy(&output.stdout);
    let mut ms: Vec<String> = output_string.split('\n').map(str::to_string).collect();
    ms.retain(|x| !x.is_empty());
    for w in accept {
        if !ms.contains(w) {
            println!("{} does not need to be on accept list", w);
        }
    }
    assert!(&ms == accept, "Accept list contains unnecessary words.")
}

fn check_reject_are_ok() {
    let output_tail = Command::new("tail")
        .args(["-n", "+2", ".spell_reject.tmp"])
        .stdout(Stdio::piped())
        .spawn()
        .unwrap();
    let output_aspell = Command::new("aspell")
        .args(["--home-dir=.", "-t", "list"])
        .stdin(Stdio::from(output_tail.stdout.unwrap()))
        .stdout(Stdio::piped())
        .spawn()
        .unwrap();
    let output = output_aspell.wait_with_output().unwrap();
    let output_string = String::from_utf8_lossy(&output.stdout);
    let mut ms: Vec<String> = output_string.split('\n').map(str::to_string).collect();
    ms.retain(|x| !x.is_empty());
    for w in &ms {
        println!("{} does not need to be on reject list", w)
    }
    assert!(ms.is_empty(), "Reject list contains unnecessary words.")
}

fn write_temp_files(accept: &[String], reject: &[String]) {
    let spell_accept: String =
        String::new() + "personal_ws-1.1 en 1000 utf-8\n" + &accept.join("\n");
    let spell_reject: String =
        String::new() + "personal_ws-1.1 en 1000 utf-8\n" + &reject.join("\n");
    fs::write(".spell_accept.tmp", spell_accept).unwrap();
    fs::write(".spell_reject.tmp", spell_reject).unwrap();
}

fn clean_up() {
    fs::remove_file(".spell_file.tmp").unwrap();
    fs::remove_file(".spell_accept.tmp").unwrap();
    fs::remove_file(".spell_reject.tmp").unwrap();
}
