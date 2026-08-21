#!usr/bin/env python3

import subprocess
from PIL import Image

W, H = 3840, 2160
logo_size = 800
background = "#181818"

subprocess.run([
    "resvg",
    "nixos.svg",
    "logo.png",
    "-w", str(logo_size),
    "-h", str(logo_size),
], check=True)

logo = Image.open("logo.png").convert("RGBA")

out = Image.new("RGBA", (W, H), background)

x = (W - logo.width) // 2
y = (H - logo.height) // 2

out.alpha_composite(logo, (x, y))

out.convert("RGB").save("wallpaper.png")
