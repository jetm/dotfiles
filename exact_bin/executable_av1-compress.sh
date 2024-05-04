#!/bin/bash

ffmpeg -i "${1}" \
    -c:v libsvtav1 \
    -crf 16 \
    -pix_fmt yuv444p10le \
    -c:a copy \
    -svtav1-params tune=0 \
    -sn \
    "$(basename "${1}" .mkv)"_AV1.mkv
