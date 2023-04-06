.. _docker:

Docker
======

It is possible to run Webnucleo codes inside a
`Docker <https://docker.com>`_ container.  The container automatically includes
all necessary libraries.

'Install <https://docker.com>`_ Docker Desktop appropriate for your computer.
Once Docker is installed, check that it is running properly by typing in
a terminal window::

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

Notice that if you exit Docker (by typing *exit*)
and restart (by typing *docker run -it webnucleo/ubuntu* again),
your changes will disappear (that is, in this example
the direxctory *my-projects* will disappear).  You
will need to keep the container running to maintain those changes.
