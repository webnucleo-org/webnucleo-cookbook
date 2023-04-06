.. _linux:

Linux
=====

To install the necessary libraries, follow the instructions appropriate for
your Linux flavor.

Debian/Ubuntu
-------------

The appropriate package manager is `APT <https://ubuntu.com/server/docs/package-management>`_.  In a terminal window, type::

     $ sudo apt-get update

     $ sudo apt-get install dot2tex g++ gcc gfortran git gsl-bin libboost-all-dev libgsl-dev libhdf5-serial-dev libxml2 libxml2-dev libxml2-utils libxslt1-dev make subversion valgrind wget xsltproc

RedHat/Fedora
-------------

The appropriate package manager is likely `Yum <https://wiki.centos.org/PackageManagement/Yum>`_.  In a terminal window, type::

     $ sudo yum update

     $ sudo yum install boost boost-devel gcc gcc-c++ gcc-gfortran git gsl gsl-devel hdf5-devel libxml2 libxml2-devel subversion valgrind wget

