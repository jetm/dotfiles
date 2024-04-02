#!/bin/sh

cliphist store
cliphist list | head -1 | cliphist decode | wl-copy --trim-newline
