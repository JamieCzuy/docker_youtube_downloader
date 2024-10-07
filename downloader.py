import os
import yt_dlp

def download_youtube_audio(youtube_url, output_path="."):
    ydl_opts = {
        'format': 'bestaudio/best',
        'postprocessors': [{
            'key': 'FFmpegExtractAudio',
            'preferredcodec': 'mp3',
            'preferredquality': '192',
        }],
        'outtmpl': f'{output_path}/%(title)s.%(ext)s',
    }
    with yt_dlp.YoutubeDL(ydl_opts) as ydl:
        ydl.download([youtube_url])

# ---- Call the youtube_download function  ---- #
# ---- Getting URL parameter from EnvVar ---- #
youtube_url = os.getenv("YOUTUBE_URL")
if not youtube_url:
    raise EnvironmentError("The YOUTUBE_URL environment variable is not set!")

output_path = "/downloaded_files"

download_youtube_audio(youtube_url, output_path)
