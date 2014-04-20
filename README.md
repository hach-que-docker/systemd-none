Usage
----------

This image does not require any preconfiguration to run.

To run this image:

    /usr/bin/docker run hachque/systemd-none
    
This image is generally used as a base image for other Docker images.  You can build on this image by creating your own Dockerfiles.

SSH Host Keys
----------------

This image will generate SSH host keys on first run, and store them in /config.  For images derived from this one, this will ensure that the SSH host keys are kept in a /config/keycache folder (whereever this may be mapped on the host) so that the SSH host keys do not change between restarts.

If /config is not mapped in the container, then the SSH host keys will change each time a container is run from this image.
    
SSH / Login
--------------

**Username:** root

**Password:** linux
