.. _cygwin:

Cygwin (Windows)
================

It is possible to run Webnucleo codes on a Windows computer through
`Cygwin <https://cygwin.com>`_.  Instructions at the website show how
to install packages, but it is also possible to do so from the command line.
To do so, open in Windows a
`Command Prompt <https://www.youtube.com/watch?v=MBBWVgE0ewk>`_.
The easiest thing to do is to
type *cmd* into the command search window near the Windows start icon.
That opens the Command Prompt, which will show something like::

    c:\Users\Brad>

Next download *setup-x86_64.exe* from
`Cygwin <https://cygwin.com/install.html>`_, assuming you have a 64 bit
machine. Otherwise download *setup-x86.exe* and replace any
*setup-x86_64.exe* in the instructions with *setup_x86.exe*.
The setup file will most likely go into the Downloads folder,
so in the Command Prompt, type::

    cd Downloads

Now type the following::

    setup-x86_64.exe -q -P pkg-config,gcc-core,gcc-fortran,gcc-g++,ghostscript,git,graphviz,gsl,hdf5,libboost-devel,libcrypt-devel,libfreetype-devel,libgsl-devel,libgtk2.0-devel,libhdf5-devel,libpng-devel,libxml2,libxml2-devel,libxslt,libxslt-devel,make,openbox,python3-h5py,python3-pyqt5,python3-sip,python36-devel,python36-numpy,python36-pip,subversion,texlive,texlive-collection-latex,texlive-collection-latexextra,texlive-collection-latexrecommended,texlive-collection-pictures,wget

This may ask you for your administrator password. If so, type that in.
The Cygwin installation window that appears should then query you on a
download site. You can just choose the first. The set up will install,
and a package page will appear. Hit Next a couple of times.
The installation will take some time (maybe about 10 minutes).
Once done, choose whether you want Icons installed (you probably do) and
click Finish.
