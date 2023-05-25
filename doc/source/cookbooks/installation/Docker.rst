.. _docker:

Docker
======

It is possible to run Webnucleo codes inside a
`Docker <https://docker.com>`_ container.  The container automatically includes
all necessary libraries and codes.

Install `Docker Desktop <https://docker.com>`_ appropriate for your computer.
Once Docker is installed, check that it is running properly by typing in
a terminal window::

    $ docker run hello-world

If that runs correctly, try running the Webnucleo Ubuntu Docker image by
typing::

    $ docker run -it webnucleo/single_zone

This pulls and installs the packages needed for webnucleo applications.  It
also installs and compiles the single-zone network code.  Once the container
starts, you can type::

    # ls

The result should be::

    Makefile  default  project_make  single_zone_network  single_zone_network.cpp

You can see what containers are running by typing in a different terminal::

    $ docker ps

This  is useful because you can move files from outside the container into
it or vice versa.  For example, if *docker ps* returns::

    CONTAINER ID   IMAGE                   COMMAND   CREATED          STATUS          PORTS     NAMES
    e25ad5f695f0   webnucleo/single_zone   "bash"    16 seconds ago   Up 14 seconds             goofy_saha

the container ID is *e25ad5f695f0*.  You can copy a file *my_file.txt* from a
local directory to your container by typing::

    $ docker cp my_file.txt e25ad5f695f0:/my-projects/single_zone/

Of course, adjust the container ID to that shown in your execution
of *docker ps*.  In your container you can then again type::

    # ls

which will show the file.  To copy the file back from the container, type::

    $ docker cp e25ad5f695f0:/my-projects/single_zone/my_file.txt .

Once you are done with the container, you can type::

    # exit

If you start the container again by typing::

    $ docker run -it webnucleo/single_zone

it will appear quickly since Docker will not need to pull down a new image.
However, any changes you made in the previous container will be lost.  For
example, if you type::

    # ls

you will see that *my_file.txt* has disappeared since you have
started a new container.  You can think of the new container as a completely
new computer but with all the Webnucleo-required libraries installed.
If you do not want to lose your current work, you
will need to keep the container running.

Note that you can see what images you have pulled by typing::

    $ docker image ls

If in attempting to run Docker, you see the response::

    docker: Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?.
    See 'docker run --help'.

you will first need to restart the Docker Desktop application.
