# Developer Notes

The Docker image is essentially a Python based image with additional utilities added to smooth out the user experience. `ffmpeg` is used in the Docker image to perform on the fly audio conversion of the users audio file prior to starting the `deepspeech` Python command.

# Dependencies

If you would like to build the project locally then you will need the following dependencies:

* `git` for version control
* `curl` for downloading required dependencies
* `make` for the assembly of the Docker image