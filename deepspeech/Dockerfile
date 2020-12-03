FROM python:3.8-slim

RUN apt-get update \
    && apt-get install -y \
    wget \
    procps \
    ffmpeg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip install deepspeech==0.9.1

RUN mkdir deepspeech

# Model files; the pbmm file is aimed at faster systems
#RUN wget https://github.com/mozilla/DeepSpeech/releases/download/v0.9.1/deepspeech-0.9.1-models.pbmm
COPY deepspeech-0.9.1-models.pbmm.gz /deepspeech/model.pbmm.gz

# Scorer files
# RUN wget https://github.com/mozilla/DeepSpeech/releases/download/v0.9.1/deepspeech-0.9.1-models.scorer
COPY deepspeech-0.9.1-models.scorer.gz /deepspeech/scorer.gz

COPY entrypoint.sh /opt/entrypoint.sh

ARG VERSION
ARG VCS_REF
ARG BUILD_DATE

LABEL org.label-schema.name = "Audio Transcribe using Mozilla DeepSpeech" \
  org.label-schema.description = "A command line Docker utility for speech-to-text." \
  org.label-schema.version = "${VERSION}" \
  org.label-schema.build-date=${BUILD_DATE} \
  org.label-schema.vcs-ref=${VCS_REF} \
  org.label-schema.vcs-url="https://github.com/GencoreOperative/audio-transcribe-mozilla-deepspeech" \
  org.label-schema.schema-version = "1.0"

ENTRYPOINT ["/bin/bash", "/opt/entrypoint.sh"]