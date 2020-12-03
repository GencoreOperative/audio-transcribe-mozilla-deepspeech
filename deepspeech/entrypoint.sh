#!/bin/bash

# For a given input file, convert it into a 16khz mono WAV file
# then run this through the Mozilla DeepSpeech utility to 
# generate a transcription of the audio.

FILE=/audio/$1
[ ! -f "$FILE" ] && echo "Error: must provide an audio file" && exit

ffmpeg -i "$FILE" -vn -ar 16000 -ac 1 /tmp/output.wav
[ ! $? ] && echo "Conversion of audio file failed" && exit

deepspeech \
    --model /deepspeech/deepspeech-0.9.1-models.pbmm\
    --scorer /deepspeech/deepspeech-0.9.1-models.scorer\
    --audio /tmp/output.wav