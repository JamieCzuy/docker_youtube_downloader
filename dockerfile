FROM python:latest

RUN apt update && apt install -y \
  ffmpeg

WORKDIR /youtube

COPY downloader.py downloader.py

RUN pip install yt_dlp

CMD ["python", "downloader.py"]