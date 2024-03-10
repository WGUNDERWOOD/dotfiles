use regex::Regex;
use std::env;
use std::fs;

// declare matches
const MATCH_ERROR: [&str; 1] = ["error"];
const MATCH_WARNING: [&str; 1] = ["warn"];
const MATCH_OTHER: [&str; 2] = ["overfull", "underfull"];

// declare non matches
const NOMATCH: [&str; 5] = [
    "Package: infwarerr",
    "file:line:error style",
    "pgfplots.errorbars.code.tex",
    "warning\\$ -- 0",
    "Package caption Warning: Unknown document class",
];

// declare colors
const YELLOW: &str = "\x1b[33m\x1b[1m";
const PINK: &str = "\x1b[35m\x1b[1m";
const GREEN: &str = "\x1b[32m\x1b[1m";
const RED: &str = "\x1b[31m\x1b[1m";
const PURPLE: &str = "\x1b[34m\x1b[1m";
const CYAN: &str = "\x1b[36m\x1b[1m";
const RESET: &str = "\x1b[00m\x1b[0m";

fn main() {

    // get filenames from arguments
    let args: Vec<String> = env::args().collect();
    assert!(args.len() >= 2, "No file provided");
    let filenames = &args[1..];

    // check files are correct format
    assert!(filenames
            .iter()
            .all(|f| f.ends_with(".log") || f.ends_with(".blg")));

    // print script name
    println!("{}", String::new() + PINK + "tex-check" + RESET);

    // get regexes
    let match_errors = MATCH_ERROR.map(|w| Regex::new(&(String::new() + "(?i)" + w)).unwrap());
    let match_warnings = MATCH_WARNING.map(|w| Regex::new(&(String::new() + "(?i)" + w)).unwrap());
    let match_others = MATCH_OTHER.map(|w| Regex::new(&(String::new() + "(?i)" + w)).unwrap());
    let nomatches = NOMATCH.map(|w| Regex::new(&(String::new() + "(?i)" + w)).unwrap());

    for filename in filenames {

        // read lines from file
        println!("{}", String::new() + YELLOW + filename + RESET);
        let file = fs::read_to_string(filename).expect("Should have read the file");
        let lines: Vec<&str> = file.lines().collect();
        // warning is (line number, line contents, match type)
        let mut warnings: Vec<(usize, &str, &str)> = vec![];
        let n = lines.len();

        // check for matches
        let mut imax = 0;
        for i in 0..n {
            let line = lines[i];
            for m in &match_errors {
                if m.is_match(line) && i >= imax {
                    warnings.push((i, line, "error"));
                    imax = i + 1;
                }
            }
            for m in &match_warnings {
                if m.is_match(line) && i >= imax {
                    warnings.push((i, line, "warning"));
                    imax = i + 1;
                }
            }
            for m in &match_others {
                if m.is_match(line) && i >= imax {
                    warnings.push((i, line, "other"));
                    imax = i + 1;
                }
            }
        }

        // remove non-matches
        for i in 0..warnings.len() {
            let w = warnings[i];
            for v in &nomatches {
                if v.is_match(w.1) {
                    warnings[i] = (0, "", "");
                }
            }
        }
        warnings.retain(|w| !w.1.is_empty());

        // output results
        for w in &warnings {
            print!(
                "{}",
                String::new() + GREEN + &(w.0 + 1).to_string() + ": " + RESET
                );
            let color = match w.2 {
                "error" => RED,
                "warning" => PURPLE,
                "other" => CYAN,
                &_ => panic!(),
            };
            print!("{}", String::new() + color + w.1 + RESET);
            println!();
        }
    }

}
