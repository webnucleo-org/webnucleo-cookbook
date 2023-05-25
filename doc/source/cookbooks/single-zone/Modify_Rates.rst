.. _modify_rates:

Modify Rates
============

It is natural to ask how the value of a particular reaction rate
governs the results of a network calculation.  This may be done via
the *--rate_mod* option.  To understand how this works, vary
:math:`(\alpha, \gamma)` reaction rates from their values in the network
data file.

Use a :doc:`response file <Response_Files>` and a script.  Choose
a calculation similar to the default calculation but use an initial
density of :math:`10^7` g/cc.
Thus, create a response file *alpha_mod.rsp* with the lines::

    --t9_0 10 --tau 0.1 --rho_0 1.e7
    --network_xml ../nucnet-tools-code/data_pub/my_net.xml
    --nuc_xpath "[z <= 30]"
    --iterative_solver gmres
    --iterative_t9 2
    --init_mass_frac "{h1; 0.5}" "{n; 0.5}"
    --xml_steps 5
    --t_end 10

You can create that file directly,
download it from `OSF <https://osf.io/es6rx/>`_, or type::

    $ curl -o alpha_mod.rsp -J -L https://osf.io/snby3/download

Now create a script *run_mod.sh* with the lines::

    ./single_zone_network @alpha_mod.rsp --output_xml out_ref.xml
    ./single_zone_network @alpha_mod.rsp --rate_mod "{[(z = 2 and a = 4) or (z >= 10 and z <= 20)]; [reactant = 'he4' and product = 'gamma']; 10}" --output_xml out_mod.xml

As with the response file, you can create this file directly,
download it from `OSF <https://osf.io/es6rx/>`_, or type::

    $ curl -o run_mod.sh -J -L https://osf.io/b25es/download

The first line is for the reference calculation that uses the default network
data.  The second line uses :doc:`XPath <../xml_and_xpath/XPath_Selection>`
to increase :math:`(\alpha, \gamma)` reaction rates
(uniformly at all temperatures)
on nuclear species in the subnetwork between Ne and Ca isotopes.
The modification is entered as a triplet consisting of a nuclear XPath
expression to choose the subnetwork, a reaction XPath to choose the reaction(s)
to modify, and the factor by which to multiply the rate(s) at each temperature.

Make the script executable and run it::

    $ chmod +x run_mod.sh
    $ ./run_mod.sh

When the code runs with the modified rates, it first prints out the
modification *view*, which shows the reactions whose rates are to be
modified and the modification factor.

Check the `effect <https://osf.io/6emgv>`_
of the rate modifications by typing in Python, for example::

    >>> import wnutils.multi_xml as wm
    >>> mx = wm.Multi_Xml(['out_ref.xml', 'out_mod.xml'])
    >>> p_params = [{'label': 'Reference'}, {'label': 'Modified Rates'}]
    >>> mx.plot_mass_fraction_vs_property('time', 'si28', xlabel = 'time (s)', xlim = [0,1], plotParams = p_params, use_latex_names=True, yscale = 'log', ylim = [1.e-10,1.e-2])

It is possible to have multiple modification views.  To modify the
:math:`(\alpha, \gamma)` rates, as above, and the rate for the triple-alpha
reaction at the same time, type::

    $ ./single_zone_network @alpha_mod.rsp --rate_mod "{[(z = 2 and a = 4) or (z >= 10 and z <= 20)]; [reactant = 'he4' and product = 'gamma']; 10}" "{[.]; [(count(reactant[.='he4']) = 3) and product = 'gamma']; 10}" --output_xml out_mod2.xml

The *[.]* selects all species, but the only reaction whose rate will be
modified is *he4 + he4 + he4 -> c12 + gamma*, as verified in modification
view 1.  You can add the results of this calculation to your previous plot.

It is possible to have as many modification views as you want, although
you will need to choose the views judiciously to explore the governing
role of particular reaction rates.
