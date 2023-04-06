.. _macos:

MacOs
=====

To install the necessary libraries, you can use `MacPorts <https://macports.org>`_.  To
do so, in a terminal window, type::

     $ sudo port selfupdate

     $ sudo port upgrade outdated

     $ sudo port install boost dot2tex gcc git gsl hdf5 +gcc libxml2 subversion valgrind wget

Some users may instead prefer to use `Homebrew <https://brew.sh>`_.  Ueers
should modify the above instructions appropriately.
