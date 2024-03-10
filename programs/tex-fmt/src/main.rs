use core::cmp::max;
use lazy_static::lazy_static;
use regex::Regex;
use std::fs;
use clap::Parser;

const TAB: i32 = 2;
const OPENS: [char; 3] = ['(', '[', '{'];
const CLOSES: [char; 3] = [')', ']', '}'];
const LISTS: [&str; 3] = ["itemize", "enumerate", "description"];

#[derive(Parser)]
struct Cli {
    #[arg(long, short, help="Print to stdout, do not modify files")]
    dryrun: bool,
    #[arg(required = true)]
    filenames: Vec<String>,
}

lazy_static! {
    static ref RE_NEWLINES: Regex = Regex::new(r"\n\n\n+").unwrap();
    static ref RE_TABS: Regex = Regex::new(r"\t").unwrap();
    static ref RE_PERCENT: Regex = Regex::new(r"\\\%").unwrap();
    static ref RE_COMMENT: Regex = Regex::new(r"\%.*").unwrap();
    static ref RE_ITEM: Regex = Regex::new(r".*\\item.*").unwrap();
    static ref RE_DOCUMENT_BEGIN: Regex =
        Regex::new(r".*\\begin\{document\}.*").unwrap();
    static ref RE_DOCUMENT_END: Regex =
        Regex::new(r".*\\end\{document\}.*").unwrap();
    static ref RE_ENV_BEGIN: Regex =
        Regex::new(r".*\\begin\{[a-z\*]*\}.*").unwrap();
    static ref RE_ENV_END: Regex =
        Regex::new(r".*\\end\{[a-z\*]*\}.*").unwrap();
    static ref RE_LISTS_BEGIN: Vec<Regex> = LISTS
        .iter()
        .map(|l| Regex::new(&format!(r".*\\begin\{{{}}}.*", l)).unwrap())
        .collect();
    static ref RE_LISTS_END: Vec<Regex> = LISTS
        .iter()
        .map(|l| Regex::new(&format!(r".*\\end\{{{}}}.*", l)).unwrap())
        .collect();
}

fn remove_extra_newlines(file: &str) -> String {
    RE_NEWLINES.replace_all(file, "\n\n").to_string()
}

fn remove_tabs(file: &str) -> String {
    let replace = (0..TAB).map(|_| " ").collect::<String>();
    RE_TABS.replace_all(file, replace).to_string()
}

fn remove_comment(line: &str) -> String {
    let new_line = RE_PERCENT.replace_all(line, "").to_string();
    RE_COMMENT.replace_all(&new_line, "").to_string()
}

fn get_back(line: &str) -> i32 {
    // no deindentation for ending document
    if RE_DOCUMENT_END.is_match(line) {
        return 0;
    };

    // list environments get double indents for indenting items
    for re_list_end in RE_LISTS_END.iter() {
        if re_list_end.is_match(line) {
            return 2;
        };
    }

    // other environments get single indents
    if RE_ENV_END.is_match(line) {
        return 1;
    };

    // deindent items to make the rest of item environment appear indented
    if RE_ITEM.is_match(line) {
        return 1;
    };

    let mut back: i32 = 0;
    let mut cumul: i32 = 0;
    for c in line.chars() {
        cumul -= OPENS.contains(&c) as i32;
        cumul += CLOSES.contains(&c) as i32;
        back = max(cumul, back);
    }
    back
}

fn get_diff(line: &str) -> i32 {
    // no indentation for document
    if RE_DOCUMENT_BEGIN.is_match(line) {
        return 0;
    };
    if RE_DOCUMENT_END.is_match(line) {
        return 0;
    };

    // list environments get double indents
    let mut diff: i32 = 0;
    for re_list_begin in RE_LISTS_BEGIN.iter() {
        if re_list_begin.is_match(line) {
            diff += 1
        };
    }

    for re_list_end in RE_LISTS_END.iter() {
        if re_list_end.is_match(line) {
            diff -= 1
        };
    }

    // other environments get single indents
    if RE_ENV_BEGIN.is_match(line) {
        diff += 1
    };
    if RE_ENV_END.is_match(line) {
        diff -= 1
    };

    // delimiters
    for c in OPENS {
        diff += line.chars().filter(|&x| x == c).count() as i32;
    }
    for c in CLOSES {
        diff -= line.chars().filter(|&x| x == c).count() as i32;
    }
    diff
}

fn main() {

    // get arguments
    let args = Cli::parse();
    let dryrun = args.dryrun;
    let filenames = args.filenames;

    // check files are in correct format
    assert!(filenames
        .iter()
        .all(|f| f.ends_with(".tex") || f.ends_with(".bib")));

    for filename in filenames {
        // read lines from file
        let mut file = fs::read_to_string(&filename)
            .expect("Should have read the file");

        // preformat
        file = remove_extra_newlines(&file);
        file = remove_tabs(&file);
        let lines: Vec<&str> = file.lines().collect();

        // set up variables
        let mut count: i32 = 0;
        let n_lines = lines.len();
        let mut indents: Vec<i32> = vec![0; lines.len()];
        let mut new_lines = vec!["".to_owned(); n_lines];

        // main loop through file
        for i in 0..n_lines {
            // calculate indent
            let line = lines[i];
            let line_strip = &remove_comment(line);
            let back = get_back(line_strip);
            let diff = get_diff(line_strip);
            let indent: i32 = count - back;
            assert!(indent >= 0);
            indents[i] = indent;
            count += diff;

            // apply indent
            let mut new_line = line.trim_start().to_string();
            if !new_line.is_empty() {
                let n_spaces = indents[i] * TAB;
                let spaces: String = (0..n_spaces).map(|_| " ").collect();
                new_line.insert_str(0, &spaces);
            }
            new_lines[i] = new_line
        }

        // check indents return to zero
        assert!(indents.first().unwrap() == &0);
        assert!(indents.last().unwrap() == &0);

        // prepare indented file
        let mut new_file = new_lines.join("\n");
        new_file.push('\n');

        if dryrun {
            // print new file
            println!("{}", &new_file);
        } else {
            // backup original file and write new file
            let filepath = fs::canonicalize(&filename).unwrap();
            let mut bak = filepath.clone().into_os_string().into_string().unwrap();
            bak.push_str(".bak");
            fs::copy(filepath.clone(), &bak).unwrap();
            fs::write(filepath, new_file).unwrap();
        }
    }
}
