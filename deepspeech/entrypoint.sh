#!/bin/bash

# For a given input file, convert it into a 16khz mono WAV file
# then run this through the Mozilla DeepSpeech utility to 
# generate a transcription of the audio.

FILE=/audio/$1
[ ! -f "$FILE" ] && echo "Error: must provide an audio file" && exit

cd deepspeech
gunzip model.pbmm.gz &
gunzip scorer.gz &

ffmpeg -i "$FILE" -vn -ar 16000 -ac 1 /tmp/output.wav
[ ! $? ] && echo "Conversion of audio file failed" && exit

echo
echo -n "Waiting for binaries to decompress... "
while [ ! -z "$(ps -eaf | grep gzip | grep -v grep)" ]
do
	sleep 0.1
done
echo "Done"
echo

deepspeech \
    --model /deepspeech/model.pbmm \
    --scorer /deepspeech/scorer \
    --audio /tmp/output.wav