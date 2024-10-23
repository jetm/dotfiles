#!/bin/bash

v="${1}"
nv="$(basename "${v}" .mkv)"_AV1.mkv

ab-av1 auto-encode \
    -i "${v}" \
    -o "${nv}" \
    --min-crf 6 --max-crf 12 \
    --acodec aac ||
    ab-av1 auto-encode \
        -i "${v}" \
        -o "${nv}" \
        --min-crf 13 --max-crf 18 \
        --acodec aac
