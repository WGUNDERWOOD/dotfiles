use std::env;
use std::fs;

fn main() {
    let args: Vec<String> = env::args().collect();
    assert!(args.len() == 2, "too many arguments");
    let filename: &String = &args[1];
    let file = fs::read_to_string(filename).unwrap();
    let file: Vec<&str> = file.split("\n").collect();


    dbg!(file);
}
