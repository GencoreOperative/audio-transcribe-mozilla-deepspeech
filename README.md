# Speech-to-Text using Mozilla DeepSpeech

This Docker project allows you to convert audio files containing speech into the text transcription using the Mozilla DeepSpeech Speech-to-Text engine.

The conversion is performed offline and locally and outputs the transcription to the command line.

## Requirements

This project requires Docker to run. Please see [Getting Started with Docker](https://www.docker.com/get-started) for more details.

## Mozilla DeepSpeech

The project uses the [Mozilla DeepSpeech](https://github.com/mozilla/DeepSpeech) project and includes the training models they have provided in their release. These training models are quite large and the Docker image is over 1GB in size as a result. Download of the image on a broadband connection is recommended.

The training models determine which voices can be recognised and this is currently limited to only American English speaking voices.

## Run

In order to transcribe an audio file, the Docker command needs access to the local folder on your system where the audio files are stored. If we had them in a folder called `audio` in the current folder then the command would be as follows:

```
docker run --rm -v "$PWD/audio:/audio" -ti gencore/audio-transcribe-mozilla-deepspeech test-short.mp3
```

This would then output the transcription to the command line.

*Note:* The path provided to the `-v` command needs to be a full path and should be mapped to the `/audio` folder within the container.