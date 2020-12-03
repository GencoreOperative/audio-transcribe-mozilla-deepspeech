all: deepspeech/deepspeech-0.9.1-models.pbmm deepspeech/deepspeech-0.9.1-models.scorer build

deepspeech/deepspeech-0.9.1-models.pbmm:
	curl -L https://github.com/mozilla/DeepSpeech/releases/download/v0.9.1/deepspeech-0.9.1-models.pbmm > deepspeech/deepspeech-0.9.1-models.pbmm

deepspeech/deepspeech-0.9.1-models.scorer:
	curl -L https://github.com/mozilla/DeepSpeech/releases/download/v0.9.1/deepspeech-0.9.1-models.scorer > deepspeech/deepspeech-0.9.1-models.scorer

version = 0.9.1
git = $(shell git rev-parse --short HEAD)
build_date = $(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
tag = $(version)-$(git)

build:
	@echo "Building Docker Image"
	docker build deepspeech \
		--tag gencore/audio-transcribe-mozilla-deepspeech:$(tag) \
		--tag gencore/audio-transcribe-mozilla-deepspeech:latest \
		--build-arg VERSION=$(version) \
		--build-arg VCS_REF=$(git) \
    	--build-arg BUILD_DATE=$(build_date)

release: build
	@echo "Pushing to DockerHub"
	docker push gencore/audio-transcribe-mozilla-deepspeech:$(tag)
	docker push gencore/audio-transcribe-mozilla-deepspeech:latest