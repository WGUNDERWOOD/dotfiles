use std::env;
use std::fs;
use regex::Regex;

// declare matches
const MATCH: [&str; 4] = [
    "error",
    "warn",
    "overfull",
    "underfull",
];

// declare non matches
const NOMATCH: [&str; 3] = [
    "Package: infwarerr",
    "file:line:error style",
    "pgfplots.errorbars.code.tex",
];

// declare colors
const YELLOW: &str = "\x1b[33m\x1b[1m";
const GREEN: &str = "\x1b[32m\x1b[1m";
const RED: &str = "\x1b[31m\x1b[1m";
const RESET: &str = "\x1b[00m\x1b[0m";

fn main() {

    // get filenames from arguments
    let args: Vec<String> = env::args().collect();
    assert!(args.len() >= 2, "No file provided");
    let filenames = &args[1..];

    // check file is correct format
    assert!(filenames.iter().all(|f| f.ends_with(".log") || f.ends_with(".blg")));

    // get regexes
    let matches = MATCH.map(|w| Regex::new(&(String::new() + "(?i)" + w)).unwrap());
    let nomatches = NOMATCH.map(|w| Regex::new(&(String::new() + "(?i)" + w)).unwrap());

    for filename in filenames {
        // read lines from file
        let file = fs::read_to_string(filename).expect("Should have been able to read the file");
        let lines: Vec<&str> = file.lines().collect();
        let mut warnings: Vec<(usize, &str)> = vec![];
        let n = lines.len();

        // check for matches
        let mut imax = 0;
        for i in 0..n {
            let line = lines[i];
            for m in &matches {
                if m.is_match(line) {
                    if i > imax {
                        warnings.push((i, line));
                        imax = i;
                    }
                }
            }
        }

        // remove non-matches
        for i in 0..warnings.len() {
            let w = warnings[i];
            for v in &nomatches {
                if v.is_match(w.1) {
                    warnings[i] = (0, "");
                }
            }
        }
        warnings.retain(|w| !w.1.is_empty());

        // output results
        if warnings.len() > 0 {
            println!("{}", String::new() + YELLOW + filename + RESET);
            for w in &warnings {

                //let mut formatted_warning = w.1.to_string();

                // format warning words
                //for i in 0..matches.len() {
                    //let re = &matches[i];
                    //let m = &MATCH[i];
                    //let colored_m = String::new() + RED + &m.to_string() + RESET;
                    //formatted_warning = re.replace_all(&formatted_warning, colored_m).to_string();
                //}

                print!("{}", String::new() + GREEN + &(w.0 + 1).to_string() + ": " + RESET);
                //print!("{}", formatted_warning);
                print!("{}", String::new() + RED + w.1 + RESET);
                println!();
            }
        }
    }
}
