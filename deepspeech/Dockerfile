FROM python:3.8-slim

RUN apt-get update && apt-get install -y wget ffmpeg && apt-get clean

RUN pip install deepspeech==0.9.1

RUN mkdir deepspeech

# Model files; the pbmm file is aimed at faster systems
#RUN wget https://github.com/mozilla/DeepSpeech/releases/download/v0.9.1/deepspeech-0.9.1-models.pbmm
COPY deepspeech-0.9.1-models.pbmm /deepspeech/deepspeech-0.9.1-models.pbmm

# Scorer files
# RUN wget https://github.com/mozilla/DeepSpeech/releases/download/v0.9.1/deepspeech-0.9.1-models.scorer
COPY deepspeech-0.9.1-models.scorer /deepspeech/deepspeech-0.9.1-models.scorer

COPY entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT ["/bin/bash", "/opt/entrypoint.sh"]