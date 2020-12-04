Some areas for expansion on this utility project.

# Progress Indicator

Consider support for progress indication on the output. The engine appears to take a different amount of time depending on the voice that is speaking. More test data is needed before we could build any prediction on how long it would take.

```
Inference took 63.146s for 120.000s audio file.
Inference took 88.346s for 120.000s audio file.
Inference took 170.705s for 300.000s audio file.
Inference took 202.408s for 300.000s audio file.
```

# Dependency Filesize

The binary model and scorer files are the largest aspect of this project both in terms of data uploaded and downloaded. An idea to consider here is whether we can compress these images as part of the Docker image. We can imagine storing the binary file in a compressed form inside the image and decompressing on the fly at each execution. This would achieve the goal of reducing the size of the Docker image at the cost of execution time on image startup.

```
cat deepspeech-0.9.1-models.scorer | bzip2 --best > best.bzip2
time cat best.bzip2 | bzip2 --decompress > test
real	0m55.531s
813942398 bytes

cat deepspeech-0.9.1-models.scorer | bzip2 --fast > fast.bzip2
time cat fast.bzip2 | bzip2 --decompress > test
real	0m45.242s
838485266 bytes

cat deepspeech-0.9.1-models.scorer | gzip --best > best.gzip
time cat best.gzip | gzip --decompress > test
real	0m5.077s
851036470 bytes

cat deepspeech-0.9.1-models.scorer | gzip --fast > fast.gzip
time cat fast.gzip | gzip --decompress > test
real	0m5.110s
842375930 bytes
```

From this testing we can see that the scorer file compresses best with bzip2 in best mode, but takes too long to decompress to be useful. Instead gzip with fast mode produces the smallest size with only 5 seconds decompression time. This means we can save 11.6% on the file size with only 5 seconds of delay on startup.
After experimentation with runtime decompression we can say that this adds around 10 seconds of delay to the processing.

```
time docker run --rm -v "$PWD/audio:/audio" -ti gencore/audio-transcribe-mozilla-deepspeech test-short.mp3
real	1m31.649s
1.54GB

time docker run --rm -v "$PWD/audio:/audio" -ti gencore/audio-transcribe-mozilla-deepspeech-0-9-1:f322c50 test-short.mp3
real	1m16.178s
1.67GB
```

Summary, we are adding ~15 seconds to processing time for a ~130MB file saving to the Docker image. For larger audio files this time would be reduced as ffmpeg would take longer to process them, that said the processing time is very small. On the other hand the processing time in total is measured in minutes for a 2 minute sample file. For the moment we will stick with the file size saving. If this changes we can remove the compression functionality.

# Dependencies

We might want to consider looking inside the following image:
docker pull mozilla/deepspeech-server:latest
This appears to be an official mozilla image which may contain the training data. This could be used as an alternative method of getting these files rather than asking the developer to download them. (removes need for curl - one less step)

The mozilla/deepspeech-server image contains older versions of the product and so we will not consider it further.