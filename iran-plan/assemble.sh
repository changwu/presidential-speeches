#!/bin/sh

./extract-snippets -i timings.txt > output_names.tmp

rm output_names.tmp.tmp
for output_name in $(cat output_names.tmp); do
  printf "snippets/%s\n" "${output_name}" >> output_names.tmp.tmp
done
mv output_names.tmp.tmp output_names.tmp

vlc --play-and-exit $(cat output_names.tmp)

# Concatenate all extracts so far and play the result.
# 
# ### This leads to weird results right now.  But when I play each
# ### extracted snippet individually, it sounds fine (except for a few
# ### where the sound seems to not kick in).  I'm not sure what's
# ### going on.  Maybe Floyd will know more about this stuff.
# 
# (cd snippets;                                                            \
#  rm -f all.mp4 all.out;                                                  \
#  for name in *.mp4; do printf "file '%s'\n" "${name}" >> all.out; done;  \
#  ffmpeg -f concat -i all.out -c copy all.mp4;                            \
#  vlc all.mp4;                                                            \
# )
