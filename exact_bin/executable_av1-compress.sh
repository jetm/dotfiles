#!/bin/bash

    # -pix_fmt yuv444p10le \
ffmpeg -i "${1}" \
    -c:v libsvtav1 \
    -c:a copy \
    -crf 5 \
    -pix_fmt yuv420p10le \
    -svtav1-params tune=0 \
    -sn \
    "$(basename "${1}" .mkv)"_AV1.mkv
