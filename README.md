# Speech-to-Text using Mozilla DeepSpeech

This Docker project allows you to convert audio files containing speech into the text transcription using the Mozilla DeepSpeech Speech-to-Text engine.

The conversion is performed offline and locally and outputs the transcription to the command line.

## Requirements

This project needs Docker to run.

If you would like to build the project locally then you will need `curl` and `make` to download the dependencies and build the Docker image.

## Mozilla DeepSpeech

The project is using the [Mozilla DeepSpeech](https://github.com/mozilla/DeepSpeech) project and includes the training models they have provided in their release.

The training models determine which voices can be recognised and this is limited to only American English speaking voices.

## Run

The Docker command needs a local folder mounted which contains the audio file to be transcribed:

```
docker run --rm -v "$PWD/audio:/audio" -ti audio-transcribe-mozilla-deepspeech-0-9-1 test-short.mp3
```

This will output the transcription to the command line.

*Note:* The path provided to the `-v` command needs to be a full path and should be mapped to the `/audio` folder within the container.