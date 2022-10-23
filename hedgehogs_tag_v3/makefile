#! /bin/bash

gif: output.gif

# Make a workign copy
FRAMES = ./frames/frame_%04d.png

# Make ffmpeg quieter
FFMPEG_FLAGS = -hide_banner -loglevel error -stats

# Dont ask for confirmation
FFMPEG_FLAGS += -y

FFMPEG = ffmpeg $(FFMPEG_FLAGS)

# Count number of frames in the frames folder
N_FRAMES=$(shell ls -1 frames/ | wc -l) 
DURATION=$(shell echo "$(N_FRAMES)/30 + 4" | bc)

FILTER="\
[0]tpad=stop_duration=1:stop_mode=clone[v0];\
[v0]fade=type=out:st=$(DURATION):d=1:alpha=1[v0];\
[0]tpad=start_duration=$(DURATION)[v1];\
[v1][v0]overlay[both];\
[both]trim=2:$(shell echo "$(DURATION)+2" | bc),setpts=PTS-STARTPTS[out]\
"

cross_fade.mp4:
	$(FFMPEG) -i $(FRAMES) -filter_complex $(FILTER) -map [out] -c:v libx264 -qp 0 $@

# Make into a gif
# VF="\
# split[0][1];\
# [1]palettegen[p];\
# [0]scale=512:512,fps=30[3];\
# [3][p]paletteuse[out]\
# "

VF="scale=512:512,fps=30"

output.gif: cross_fade.mp4
	$(FFMPEG) -i $< -vf $(VF) -loop 0 $@

clean:
	rm -rf cross_fade.mp4 output.gif