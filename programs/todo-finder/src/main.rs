use std::env;
use std::fs;

// declare keywords
const KEYWORDS: [&str; 5] = ["TODO", "BUG", "NOTE", "NOW", "XXX"];
const EXCLUDES: [&str; 3] = ["\\newcommand{\\TODO}", "NOTES", "ACKNOWLEDGMENT"];

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

    for filename in filenames {
        // read lines from file
        let file = fs::read_to_string(filename).expect("Should have been able to read the file");
        let lines: Vec<&str> = file.lines().collect();

        // print file name if any matches
        if lines.iter().any(|l| check_match(l)) {
            println!("{}", String::new() + YELLOW + filename + RESET)
        }

        // print formatted lines
        for i in 0..lines.len() {
            let line = lines[i];
            if check_match(line) {
                format_print(line, i);
            }
        }
    }
}

fn check_match(line: &str) -> bool {
    let contains_keyword = KEYWORDS.iter().any(|w| line.contains(w));
    let contains_exclude = EXCLUDES.iter().any(|w| line.contains(w));
    return contains_keyword && !contains_exclude;
}

fn format_print(line: &str, i: usize) {
    print!(
        "{}",
        String::new() + GREEN + &(i + 1).to_string() + ": " + RESET
    );
    let mut formatted: String = line.to_string();
    for k in KEYWORDS {
        let colored_k = String::new() + RED + k + RESET;
        formatted = formatted.replace(k, &colored_k);
    }
    print!("{}", &formatted);
    println!();
}
