Usage
----------

This image does not require any preconfiguration to run.

To run this image:

    /usr/bin/docker run hachque/systemd-none
    
This image is generally used as a base image for other Docker images.  You can build on this image by creating your own Dockerfiles.

SSH Access
----------

This image no longer provides SSH access.  Instead use `docker exec` to run commands in the container (originally `docker exec` was not available when the first versions of this image were made, so they provided SSHD running by default).

Starting Services
-----------------

When deriving from this image, you can start services by placing executable shell scripts in `/etc/init.simple`.  To make the container monitor service processes (and exit if any of them unexpectedly terminate), place files in `/run/watch` with a single PID inside each file.
