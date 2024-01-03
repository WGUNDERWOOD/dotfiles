#!usr/bin/env python3

import json
import subprocess
import argparse

# get arguments
parser = argparse.ArgumentParser()
parser.add_argument("-g", "--go", help="go to", action="store_true")
parser.add_argument("-m", "--move", help="move to", action="store_true")
args = parser.parse_args()

# find first empty workspace
workspaces = subprocess.check_output(['swaymsg', '-t', 'get_workspaces'])
workspaces = json.loads(workspaces)
busy = [w["num"] for w in workspaces if w["representation"] != None]
first_empty = min([i for i in range(1, 10) if i not in busy])

if args.go:
    subprocess.call(["swaymsg", 'workspace number %i' % first_empty])

elif args.move:
    subprocess.call(["swaymsg", "move workspace number %i" % first_empty])

else:
    raise ValueError("specify go to or move")
