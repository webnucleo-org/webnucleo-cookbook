.. _response_file:

Response Files
==============

If you have successfully run a
:doc:`first calculation <./First>` calculation,
you will have noticed
that you typed in a number of options.  Those are options that are supplied
to the various classes in the network code that govern how the calculation
runs.  In the first calculation, you typed them directly into the command
line.

It is often convenient instead to put those options into a *response file*,
which, by convention, is designated by the *.rsp* suffix.  This is
especially convenient when you are running multiple calculations in
which you are changing only a few parameters.

To illustrate
this, run a batch calculation of the default freezeout calculation
but with different initial densities.  The only things that change in
the calculations is the initial density *rho_0* and the output file.  Put all
the other option choices into a response file, called, for example,
*alpha.rsp*, which reads::

    --t9_0 10 --tau 0.1
    --network_xml ../nucnet-tools-code/data_pub/my_net.xml
    --nuc_xpath "[z <= 30]"
    --iterative_solver gmres
    --iterative_t9 2
    --init_mass_frac "{h1; 0.5}" "{n; 0.5}"
    --xml_steps 5

Notice that options can be on the same line (as with the case of the initial
temperature and expansion timescale).
The initial mass fractions can be specified
separately (each with their own ``--init_mass_frac``, as in the example
execution) or as a series of strings, as in the file shown here.
You can create this file directly or
obtain a copy of this file from `OSF <https://osf.io/gs3hp>`_ by typing::

    $ curl -o alpha.rsp -J -L https://osf.io/xudz8/download

Now create an execution script called, for example, *run.sh*, with the
lines::

    ./single_zone_network @alpha.rsp --rho_0 1.e9 --output_xml out_1.e9.xml
    ./single_zone_network @alpha.rsp --rho_0 1.e8 --output_xml out_1.e8.xml
    ./single_zone_network @alpha.rsp --rho_0 1.e7 --output_xml out_1.e7.xml

You can create this file directly or
obtain a copy of this file from `OSF <https://osf.io/gs3hp>`_ by typing::

    $ curl -o run.sh -J -L https://osf.io/adez7/download

In the script, the *@* indicates the response file.  You could also indicate the
response file with ``--response-file`` so that *run.sh* would read::

    ./single_zone_network --response-file alpha.rsp --rho_0 1.e9 --output_xml out_1.e9.xml
    ./single_zone_network --response-file alpha.rsp --rho_0 1.e8 --output_xml out_1.e8.xml
    ./single_zone_network --response-file alpha.rsp --rho_0 1.e7 --output_xml out_1.e7.xml

Once you create that file, make it executable and run it::

    $ chmod +x run.sh
    $ ./run.sh

That will execute the single-zone code three times with the three different
initial densities.  The output will be left in three different output
XML files: *out_1.e9.xml*, *out_1.e8.xml*, and *out_1.e7.xml*.

You can compare the output from the three calculations with
`wnutils <https://wnutils.readthedocs.io>`_ routines.  For example, you
can do the following::

    $ python
    >>> import wnutils.multi_xml as wm
    >>> mx = wm.Multi_Xml(['out_1.e9.xml', 'out_1.e8.xml', 'out_1.e7.xml'])
    >>> p_params = [{'label': '$\\rho_0 = 10^9$ g/cc'}, {'label': '$\\rho_0 = 10^8$ g/cc'}, {'label': '$\\rho_0 = 10^7$ g/cc'}]
    >>> mx.plot_mass_fraction_vs_property('time', 'he4', xlabel = 'time (s)', xlim = [0,1], plotParams = p_params, use_latex_names=True)

Your output should look like `this <https://osf.io/4cvnx>`_.

You can, of course, put all parameters for a network calculation into a
response file.  For example, you could have created three separate response
files for the above three calculations.  Those response files would have
to have included the initial density and the name of the output file in each
case.  It makes more sense, however, to include the non-varying parameters
in the response file and input the varying ones on the command line.
