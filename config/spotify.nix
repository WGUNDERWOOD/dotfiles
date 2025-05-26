{...}: {
  home.file.".config/spotify-player/app.toml".text = ''
    theme = "dracula"
    playback_format = """
    {status} {track} / {artists}
    {album}
    {metadata}"""
    play_icon = "PLAY"
    pause_icon = "PAUSE"
    liked_icon = "Y"
    enable_notify = false
    seek_duration_secs = 10

    [device]
    volume = 100
    bitrate = 320
    audio_cache = true
    normalization = false
    autoplay = false
  '';

  home.file.".config/spotify-player/theme.toml".text = ''
    [[themes]]
    name = "dracula"

    [themes.palette]
    background = "#121218"
    foreground = "#f8f8f2"
    black = "#000000"
    red = "#ff5555"
    green = "#50fa7b"
    yellow = "#f1fa8c"
    blue = "#bd93f9"
    magenta = "#ff79c6"
    cyan = "#8be9fd"
    white = "#bbbbbb"
    bright_black = "#555555"
    bright_red = "#ff5555"
    bright_green = "#50fa7b"
    bright_yellow = "#f1fa8c"
    bright_blue = "#bd93f9"
    bright_magenta = "#ff79c6"
    bright_cyan = "#8be9fd"
    bright_white = "#ffffff"

    [themes.component_style]
    block_title = { fg = "Magenta"  }
    border = {}
    playback_status = { fg = "Cyan", modifiers = ["Bold"] }
    playback_track = { fg = "Cyan", modifiers = ["Bold"] }
    playback_artists = { fg = "Cyan", modifiers = ["Bold"] }
    playback_album = { fg = "Yellow" }
    playback_metadata = { fg = "BrightBlack" }
    playback_progress_bar = { bg = "BrightBlack", fg = "Green" }
    current_playing = { fg = "Green", modifiers = ["Bold"] }
    page_desc = { fg = "Cyan", modifiers = ["Bold"] }
    playlist_desc = { fg = "BrightBlack", modifiers = ["Dim"] }
    table_header = { fg = "Blue" }
    secondary_row = {}
    like = {}
    lyrics_played = { modifiers = ["Dim"] }
  '';
}
