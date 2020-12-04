all: build

binaries: deepspeech/deepspeech-0.9.1-models.pbmm deepspeech/deepspeech-0.9.1-models.scorer

deepspeech/deepspeech-0.9.1-models.pbmm:
	curl -L https://github.com/mozilla/DeepSpeech/releases/download/v0.9.1/deepspeech-0.9.1-models.pbmm > deepspeech/deepspeech-0.9.1-models.pbmm.gz

deepspeech/deepspeech-0.9.1-models.scorer:
	curl -L https://github.com/mozilla/DeepSpeech/releases/download/v0.9.1/deepspeech-0.9.1-models.scorer > deepspeech/deepspeech-0.9.1-models.scorer.gz

mozilla_version = 0.9.1
transcribe_version = 0.1
git = $(shell git rev-parse --short HEAD)
build_date = $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")

build_base: binaries
	@echo "Building base Docker image"
	docker build deepspeech \
		--tag gencore/mozilla-deepspeech:$(mozilla_version) \
		--tag gencore/mozilla-deepspeech:$(git) \
		--tag gencore/mozilla-deepspeech:latest \
		--build-arg VERSION=$(mozilla_version) \
		--build-arg VCS_REF=$(git)

build: build_base
	@echo "Building Audio Transcribe Docker Image"
	docker build transcribe \
		--tag gencore/audio-transcribe-mozilla-deepspeech:$(transcribe_version) \
		--tag gencore/audio-transcribe-mozilla-deepspeech:$(git) \
		--tag gencore/audio-transcribe-mozilla-deepspeech:latest \
		--build-arg VERSION=$(transcribe_version) \
		--build-arg VCS_REF=$(git)

release: build
	@echo "Pushing to DockerHub"
	docker push gencore/mozilla-deepspeech:$(mozilla_version)
	docker push gencore/mozilla-deepspeech:$(git)
	docker push gencore/mozilla-deepspeech:latest
	docker push gencore/audio-transcribe-mozilla-deepspeech:$(transcribe_version)
	docker push gencore/audio-transcribe-mozilla-deepspeech:$(git)
	docker push gencore/audio-transcribe-mozilla-deepspeech:latest

pwd = $(shell pwd)

run: build
	docker run --rm -v "$(pwd)/audio:/audio" -ti gencore/audio-transcribe-mozilla-deepspeech test-short.mp3
