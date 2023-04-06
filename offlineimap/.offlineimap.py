import subprocess

gmail_pass = subprocess.check_output(["gpg", "-q", "-d", "/home/will/.config/mutt/passwords/gmail_password.gpg"])
princeton_pass = subprocess.check_output(["gpg", "-q", "-d", "/home/will/.config/mutt/passwords/princeton_password.gpg"])

gmail_user = subprocess.check_output(["cat", "/home/will/.config/mutt/passwords/gmail_user.txt"])
princeton_user = subprocess.check_output(["cat", "/home/will/.config/mutt/passwords/princeton_user.txt"])
