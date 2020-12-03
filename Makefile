all: deepspeech/deepspeech-0.9.1-models.pbmm deepspeech/deepspeech-0.9.1-models.scorer build

deepspeech/deepspeech-0.9.1-models.pbmm:
	curl -L https://github.com/mozilla/DeepSpeech/releases/download/v0.9.1/deepspeech-0.9.1-models.pbmm > deepspeech/deepspeech-0.9.1-models.pbmm

deepspeech/deepspeech-0.9.1-models.scorer:
	curl -L https://github.com/mozilla/DeepSpeech/releases/download/v0.9.1/deepspeech-0.9.1-models.scorer > deepspeech/deepspeech-0.9.1-models.scorer

build:
	docker build deepspeech -t audio-transcribe-mozilla-deepspeech-0-9-1