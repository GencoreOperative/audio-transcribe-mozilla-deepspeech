FROM gencore/mozilla-deepspeech:0.9.1

RUN apt-get update \
    && apt-get install -y \
    ffmpeg \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

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