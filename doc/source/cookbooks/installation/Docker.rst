.. _docker:

Docker
======

It is possible to run Webnucleo codes inside a
`Docker <https://docker.com>`_ container.  The container automatically includes
all necessary libraries.

`Install <https://docker.com>`_ Docker Desktop appropriate for your computer.
Once Docker is installed, check that it is running properly by typing in
a terminal window (note the *$* indicates  the shell prompt--you don't type it)::

    $ docker run hello-world

If that runs correctly, try running the Webnucleo Ubuntu Docker image by
typing::

    $ docker run -it webnucleo/ubuntu

This pulls and installs the packages needed for webnucleo applications.
It then opens the ubuntu window in which you can install and run webnucleo
codes.  It's probably best to do this from inside the */home* directory, so
you can type something like::

    root@290c77381519:/# cd /home
    root@290c77381519:/# mkdir my-projects
    root@290c77381519:/# cd my-projects

You can see what containers are running by typing in a different terminal::

    $ docker ps

This  is useful because you can move files from outside the container into
it or vice versa.  For example, if *docker ps* returns::

    CONTAINER ID   IMAGE              COMMAND   CREATED          STATUS          PORTS     NAMES
    b51c4c6ecb0f   webnucleo/ubuntu   "bash"    36 seconds ago   Up 34 seconds             naughty_babbage

you can copy a file *my_file.txt* from a local directory
to your container by typing::

    $ docker cp my_file.txt b51c4c6ecb0f:/home/my-projects

In your container you can then type::

    root@b51c4c6ecb0f:/home/my-projects# ls 

which will show the file.  To copy the file back from the container, type::

    $ docker cp b51c4c6ecb0f:/home/my-projects/my_file.txt .

Once you are done with the container, you can type::

    root@b51c4c6ecb0f:/home/my-projects# exit

If you start the container again by typing::

    $ docker run -it webnucleo/ubuntu

it will appear quickly since Docker will not need to pull down a new image.
However, any changes you made in the previous container will be lost.  For
example, if you type::

    root@9f0d57c1d209:/# ls /home

you will see that the *my-projects* directory has disappeared since you have
started a new container.  You
will need to keep the container running to maintain those changes.

Note that you can see what images you have pulled by typing::

    $ docker image ls
