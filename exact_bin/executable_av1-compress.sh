#!/bin/bash

v="${1}"

# Keep same overall bit rate from original video
n=$(ffmpeg -i "${v}" 2>&1 | awk '/bitrate/ {print $6}')
r=$(((n + 700) / 1000))

# Copy two audio tracks and transcode video
#   -map 0:0 \
#   -c:v
#   ...
#   -map 0:1 \
#   -map 0:2 \
#   -c:a copy \

    # -pix_fmt yuv420p10le \
ffmpeg -i "${v}" \
    -c:v libsvtav1 \
    -movflags +faststart \
    -b:v "${r}M" \
    -svtav1-params tune=0 \
    -sn \
    "$(basename "${v}" .mkv)"_AV1.mkv

# libx264
# ffmpeg -i "${v}" \
#     -c:v libx264 \
#     -b:v "${r}M" \
#     -movflags +faststart \
#     -sn \
#     "$(basename "${v}" .mkv)"_x264.mkv
