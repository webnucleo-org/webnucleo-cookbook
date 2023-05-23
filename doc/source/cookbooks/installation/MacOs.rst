.. _macos:

MacOs
=====

To install the necessary libraries, you can use `MacPorts <https://macports.org>`_.  To
do so, in a terminal window, type::

     $ sudo port selfupdate

     $ sudo port upgrade outdated

     $ sudo port install boost curl gcc11 git graphviz gsl hdf5 +gcc11 libxml2 subversion wget

Some users may instead prefer to use `Homebrew <https://brew.sh>`_.  Users
should modify the above instructions appropriately.
