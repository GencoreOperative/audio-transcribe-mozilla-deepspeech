all: binaries build

binaries: deepspeech/deepspeech-0.9.1-models.pbmm.gz deepspeech/deepspeech-0.9.1-models.scorer.gz

deepspeech/deepspeech-0.9.1-models.pbmm.gz:
	curl -L https://github.com/mozilla/DeepSpeech/releases/download/v0.9.1/deepspeech-0.9.1-models.pbmm | gzip --fast > deepspeech/deepspeech-0.9.1-models.pbmm.gz

deepspeech/deepspeech-0.9.1-models.scorer.gz:
	curl -L https://github.com/mozilla/DeepSpeech/releases/download/v0.9.1/deepspeech-0.9.1-models.scorer | gzip --fast > deepspeech/deepspeech-0.9.1-models.scorer.gz

version = 0.9.1
git = $(shell git rev-parse --short HEAD)
build_date = $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")

build:
	@echo "Building Docker Image"
	docker build deepspeech \
		--tag gencore/audio-transcribe-mozilla-deepspeech:$(version) \
		--tag gencore/audio-transcribe-mozilla-deepspeech:$(git) \
		--tag gencore/audio-transcribe-mozilla-deepspeech:latest \
		--build-arg VERSION=$(version) \
		--build-arg VCS_REF=$(git) \
    	--build-arg BUILD_DATE=$(build_date)

release: build
	@echo "Pushing to DockerHub"
	docker push gencore/audio-transcribe-mozilla-deepspeech:$(version)
	docker push gencore/audio-transcribe-mozilla-deepspeech:$(git)
	docker push gencore/audio-transcribe-mozilla-deepspeech:latest

pwd = $(shell pwd)

run: build
	docker run --rm -v "$(pwd)/audio:/audio" -ti gencore/audio-transcribe-mozilla-deepspeech test-short.mp3
