.. _update_reaction_data:

Update Reaction Data
====================

It is possible to update reaction data from another XML file.  This
cookbook demonstrates how to do that using the fixed neutron abundance
calculation.

First, prepare the network code as described in the
:doc:`Specify Abundances <./Specify_Abundances>` cookbook.  Now run
the network calculation::

    $ ./single_zone_network @specific_species.rsp --output_xml out_sp.xml

Now rerun the calculation with updated data for the
:math:`n + ^{56}{\rm Fe} \to ^{57}{\rm Fe} + \gamma` reaction.
Those new data will be from a Talys calculation.  Create the new XML
data by following the instructions at `OSF <https://osf.io/536nj/wiki/home/>`_.
The resulting *new.xml* has the Talys reaction data.

It is a good idea first
to  compare the new rate to that computed from the data in the original
XML file.  This can be done with the python code
`compare_rates.py <https://osf.io/aewqz>`_,
which you can download with the command::

    $ curl -o compare_rates.py -J -L https://osf.io/aewqz/download

The resulting file looks like `this <https://osf.io/8kcr7>`_.

Now run the network calculation with the new data.  To do so, use the
``--extra_reac_xml`` option::

    $ ./single_zone_network @specific_species.rsp --output_xml out_sp_mod.xml --extra_reac_xml new.xml

The network code parses in *new.xml* after the network data and overwrites
any reaction data from the original network file with those from the
extra reaction XML file.  Regarding this point, the network code
stores reactions as a string.  This means the order of the reactants
and products is import.  If data for the capture reaction are stored
such that network code would generate the string
:math:`^n + {56}{\rm Fe} \to ^{57}{\rm Fe} + \gamma` for the original
data and :math:`^{56}{\rm Fe} + n \to ^{57}{\rm Fe} + \gamma`, the code
will consider these as separate reactions, and the ``--extra_reac_xml''
option will cause the code to include both sets of data in the calculation.

Once the calculation is done, you can compare the results by typing::

    $ python
    >>> import wnutils.multi_xml as mx
    >>> xmls = mx.Multi_Xml(['out_sp.xml', 'out_sp_mod.xml'])
    >>> p_params = [{'label': 'Reference'}, {'label': 'Talys'}]
    >>> xmls.plot_mass_fraction_vs_property('time', 'fe58', xlim = [0, 1000], xfactor = 3.15e7, use_latex_names=True, xlabel = 'time (yr)', plotParams = p_params)

The resulting `file <https://osf.io/n4g8u>`_ shows that the faster capture rate
on :math:`^{56}{\rm Fe}` causes the mass fraction of :math:`^{58}{\rm Fe}`
to peak earlier in time and at a higher level.
