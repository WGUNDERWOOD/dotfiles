use std::env;
use std::fs;

// declare max acceptable line length
const MAX_LEN: usize = 80;

// declare colors
const YELLOW: &str = "\x1b[33m\x1b[1m";
const PINK: &str = "\x1b[35m\x1b[1m";
const GREEN: &str = "\x1b[32m\x1b[1m";
const RED: &str = "\x1b[31m\x1b[1m";
const PURPLE: &str = "\x1b[34m";
const RESET: &str = "\x1b[00m\x1b[0m";

fn main() {
    // get filenames from arguments
    let args: Vec<String> = env::args().collect();
    assert!(args.len() >= 2, "No file provided");
    let filenames = &args[1..];

    // print script name
    println!("{}", String::new() + PINK + "long-lines" + RESET);

    for filename in filenames {
        // print the file name
        println!("{}", String::new() + YELLOW + filename + RESET);

        // read lines from file
        let file = fs::read_to_string(filename).expect("Should have been able to read the file");
        let lines: Vec<&str> = file.lines().collect();

        // sort lines by length
        let n = lines.len();
        let mut order: Vec<usize> = (0..n).collect();
        order.sort_by_key(|&i| lines[i].len());
        let sorted_lines: Vec<&str> = order.iter().map(|&i| lines[i]).collect();

        // display all the long lines
        for i in 0..n {
            let line = sorted_lines[i];
            let len = line.len();
            if len > MAX_LEN {
                print!(
                    "{}",
                    String::new() + GREEN + &(order[i] + 1).to_string() + ": " + RESET
                );
                print!("{}", String::new() + RED + &len.to_string() + " " + RESET);
                print!("{}", line[0..MAX_LEN].to_string());
                print!("{}", String::new() + PURPLE + "..." + RESET);
                println!();
            }
        }
    }
}
