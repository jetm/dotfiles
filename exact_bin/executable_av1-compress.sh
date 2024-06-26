#!/bin/bash

v="${1}"

# Keep same overall bit rate from original video
n=$(ffmpeg -i "${v}" 2>&1 | awk '/bitrate/ {print $6}')
r=$(((n + 700) / 1000))

ffmpeg -i "${v}" \
    -c:v libsvtav1 \
    -b:v "${r}M" \
    -pix_fmt yuv420p10le \
    -svtav1-params tune=0 \
    -sn \
    "$(basename "${v}" .mkv)"_AV1.mkv
