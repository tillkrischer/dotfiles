install_ffmpeg() {
  install_archive_prefix \
    "ffmpeg" \
    "8.1.1" \
    "https://github.com/Tyrrrz/FFmpegBin/releases/download/8.1.1/ffmpeg-osx-arm64.zip" \
    "0bae4f67393eb210ad99e8aa8d787cd27f238104709ed5d5a8fdfc7d104d17f6" \
    "." \
    "ffmpeg:ffmpeg,ffprobe:ffprobe,ffplay:ffplay"
}
