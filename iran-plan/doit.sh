#!/bin/sh

./extract-snippets -i timings.txt > output_name.tmp; vlc --play-and-exit snippets/`cat output_name.tmp`
