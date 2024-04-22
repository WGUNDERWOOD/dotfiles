use clap::Parser;
use serde_json::Value;
use std::collections::HashMap;
use std::process::Command;
use std::process::Stdio;

#[derive(Parser)]
struct Cli {
    #[arg(long, short, help = "Go to empty workspace")]
    go_to: bool,
    #[arg(long, short, help = "Move to empty workspace")]
    move_to: bool,
}

fn get_workspaces() -> Vec<HashMap<String, Value>> {
    let command = Command::new("swaymsg")
        .args(["-t", "get_workspaces"])
        .stdout(Stdio::piped())
        .spawn()
        .unwrap()
        .wait_with_output()
        .unwrap();
    let workspaces = String::from_utf8_lossy(&command.stdout);
    serde_json::from_str(&workspaces).unwrap()
}

fn get_first_empty_workspace(workspaces: Vec<HashMap<String, Value>>) -> u64 {
    let busy: Vec<u64> = workspaces
        .iter()
        .filter(|w| w["representation"] != Value::Null)
        .map(|w| w["num"].as_u64().unwrap())
        .collect();
    (1..11).filter(|i| !busy.contains(i)).min().unwrap()
}

fn main() {
    let args = Cli::parse();
    let first_empty = get_first_empty_workspace(get_workspaces());
    if args.go_to {
        let _ = Command::new("swaymsg")
            .arg(format!("workspace number {}", first_empty))
            .spawn();
    } else if args.move_to {
        let _ = Command::new("swaymsg")
            .arg(format!("move workspace number {}", first_empty))
            .spawn();
    } else {
        panic!("Must specify go to or move");
    }
}
