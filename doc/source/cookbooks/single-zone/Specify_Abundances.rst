.. _specify_abundances:

Specify Abundances
==================

The network code follows the change of all abundances due to nuclear
reactions occuring during the nucleosynthesis.  It is often helpful
for understanding a process of nucleosynthesis to keep a species abundance
fixed.  This cookbook follow
`s-process nucleosynthesis <https://en.wikipedia.org/wiki/S-process>`_
with a fixed neutron abundance.

You must first recompile the code to use the appropriate matrix modification
class.  In your *single_zone* directory, type::

    $ cp default/master.h .

Now edit *master.h*.  In particular change the line::

    #include "matrix_modifier/detail/default.hpp"

to instead read::

    #include "matrix_modifier/detail/specific_species.hpp"

Now set the environment variable *WN_USER* to tell the compiler to use
the new class and recompile::

    $ export WN_USER=1
    $ ./project_make

If that successfully compiles, type::

    $ ./single_zone_network --prog matrix_modifier

You should see the lines::

    Matrix modifications options:
      --specific_species arg Species to keep at specified abundance (enter as 
                         doublet {name; abundance})

Keep the number density of neutrons fixed at :math:`10^8` per cc.  The
number density :math:`n_i` of a species :math:`i` is given by
:math:`n_i = \rho N_A Y_i`, where :math:`\rho` is the mass density,
:math:`N_A` is
`Avogadro's Number <https://en.wikipedia.org/wiki/Avogadro_constant>`_,
and :math:`Y_i` is the abundance per nucleon of species :math:`i`.  If the
mass density is :math:`10^3` g/cc, then the abundance of the neutrons should
be :math:`Y_n = 1.6 \times 10^{-19}`.

For this cookbook, make sure you have the standard input network XML file
by typing::

    $ make data

Set up the network code inputs.  Since the input will be a little complicated,
use a :doc:`response file <./Response_Files>`,
called *specific_species.rsp*, which reads::

    --network_xml ../nucnet-tools-code/data_pub/my_net.xml
    --t9_0 0.2 --rho_0 1000
    --specific_species "{n; 1.6e-19}"
    --t_end 3.15e12
    --init_mass_frac "{fe56; 1}"
    --nuc_xpath "[z <= 84]"
    --reac_xpath "[(reactant = 'n' and not(reactant = 'he4') and product = 'gamma') or (product = 'positron') or (product = 'electron' and not(product = 'h1' or product = 'he4')) or (count(reactant) = 1 and product = 'he4')]"
    --abundance_check 1.e300

You can create this file directly or download it from
`OSF <https://osf.io/g3hbw/>`_ by typing::

    $ curl -o specific_species.rsp -J -L https://osf.io/pksdv/download

This file has the calculation run with a temperature of :math:`T_9 = 0.2` and
a mass density :math:`\rho` of :math:`10^3` g/cc.  The neutrons will
be kept at :math:`10^8` per cc and the calculation will start with 100%
of the mass in :math:`^{56}{\rm Fe}`.  The network includes all species
up to Polonium and only includes neutron-capture, beta-minus decay rates,
and alpha-decay rates, which are the most important reactions in the s process.
The end time for the calculation is :math:`10^5` years.

The abundance check parameter
needs to be set to a very large number. The reason is
that, in order to keep the abundance of neutrons fixed, the code needs to
keep adding in neutrons.  This then increases the mass in the network
relative to the starting mass.  The network solver checks the mass fractions
at each timestep to ensure that the mass is conserved to within the range
set by *abundance_check*.  By making the number extremely large, the code
ignores the (unphysical) increase in mass.

Run the calculation by typing::

    $ ./single_zone_network @specific_species.rsp --output_xml out_sp.xml

Once the calculation is done, try confirming that the neutron abundance is
constant in time by plotting::

    $ python
    >>> import wnutils.xml as wx
    >>> xml = wx.Xml('out_sp.xml')
    >>> xml.plot_mass_fractions_vs_property('time', ['n'])

Then try plotting the abundance of some other species as
a function of time.  For example, you can plot the
`iron mass fractions <https://osf.io/5ch8g/>`_ by typing::

    >>> xml.plot_mass_fractions_vs_property('time', ['fe56', 'fe57', 'fe58'], xlim = [0, 1000], xfactor = 3.15e7, xlabel='time (yr)', use_latex_names=True)

