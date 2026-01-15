#!/bin/bash

v="${1}"

ffmpeg -i "${v}" \
    -c:v copy \
    -c:a aac \
    -b:a 640k \
    -ac 6 \
    "$(basename "${v}" .mkv)"_AAC.mkv
