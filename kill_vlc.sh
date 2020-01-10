pgrep vlc | awk '{system("kill "$1)}'
