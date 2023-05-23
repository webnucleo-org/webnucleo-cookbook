.. _python:

Python
======

(Note that if you are using a :doc:`Docker <./Docker>` container,
you should not need to
follow the steps below since starting the container will already install
the necessary python libraries.
You will also already be in the appropriate directory.)

There are a number of `python packages <https://webnucleo.readthedocs.io/en/latest/python_packages.html>`_ useful for handling Webnucleo files.  They can be
installed individually according to the instructions for the given package.
It is useful for the cookbooks to install
`wnnet <https://wnnet.readthedocs.io>`_, which will also install
`wnutils <https://wnutils.readthedocs.io>`_.  For flow and current digrams,
it is useful to have *networkx* and *pygraphviz*.
To install these, you can type::

    $ python -m pip install --user wnnet networkx pygraphviz

Users are encouraged to check out the tutorials for
`wnnet <https://github.com/mbradle/wnnet/tree/main/tutorial>`_ and
`wnutils <https://github.com/mbradle/wnutils_tutorials/>`_.
