# Docker_YouTube_Downloader

Docker wrapper around the awesome yt_dlp python package for simple audio downloading. You don't need anything local except docker.

Running the script like so:

```bash
./download.sh https://www.youtube.com/watch\?v\=<youtube_id>
```

* Creates a docker image (downloader) using the Python base and installs the yt_dpl python package and the ffmpeg libraries.
* Runs that image - creates the container (downloader) where the downloading work is done
* Shows the folder where the downloaded file was created
