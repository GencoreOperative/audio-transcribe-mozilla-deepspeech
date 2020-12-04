FROM python:3.8-slim

RUN apt-get update \
    && apt-get install -y \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip install deepspeech==0.9.1

RUN mkdir deepspeech

# Model files; the pbmm file is aimed at faster systems
RUN wget -O /deepspeech/model.pbmm https://github.com/mozilla/DeepSpeech/releases/download/v0.9.1/deepspeech-0.9.1-models.pbmm
#COPY deepspeech-0.9.1-models.pbmm /deepspeech/model.pbmm

# Scorer files; required by the engine
RUN wget -O /deepspeech/scorer https://github.com/mozilla/DeepSpeech/releases/download/v0.9.1/deepspeech-0.9.1-models.scorer
#COPY deepspeech-0.9.1-models.scorer /deepspeech/scorer

ARG VERSION
ARG VCS_REF

LABEL org.label-schema.name = "Base image for Mozilla DeepSpeech" \
  org.label-schema.description = "A Python image which inludes the deepspeech package" \
  org.label-schema.version = "${VERSION}" \
  org.label-schema.vcs-ref=${VCS_REF} \
  org.label-schema.vcs-url="https://github.com/GencoreOperative/audio-transcribe-mozilla-deepspeech" \
  org.label-schema.schema-version = "1.0"

ENTRYPOINT ["/usr/local/bin/python", "/usr/local/bin/deepspeech", "--model", "/deepspeech/model.pbmm", "--scorer", "/deepspeech/scorer"]