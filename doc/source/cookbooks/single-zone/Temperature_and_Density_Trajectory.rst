.. _temperature_and_density_trajectory:

Temperature and Density Trajectory
==================================

The default
:doc:`first calculation <./First>` calculation follows a temperature and
density dependence such that the mass density behaves as
:math:`\rho(t) = \rho_0 \exp(-t/\tau)`, with :math:`\tau` the density
e-folding timescale, and the temperature :math:`T`
behaves as :math:`\rho \propto T^3`.
If you do not supply the timescale, the temperature and density do not
change.

If, instead, you want the density and temperature to follow prescribed
values with time, you can use a *trajectory* file.  This cookbook shows
how to do that.

You must first recompile the code to use the appropriate trajectory file
class.  In your *single_zone* directory, type::

    $ cp default/master.h .

Now edit *master.h*.  In particular change the line::

    #include "hydro/single_zone/standard/detail/default.hpp"

to instead read::

    #include "hydro/single_zone/trajectory/detail/time_t9_rho.hpp"

Now set the environment variable *WN_USER* to tell the compiler to use
the new class and recompile::

    $ export WN_USER=1
    $ ./project_make

If that successfully compiles, type::

    $ ./single_zone_network --prog hydro

You should see the lines::

    Hydro options:
      --nse arg (=false)         Set initial abundances to NSE
      --interp_file arg          Interpolation file
      --every_point arg (=false) Hit every interp point

You now need a trajectory file that provides a series of points giving *time*
in seconds, *t9*, and *rho*, the masss density in *g/cc*.  Try a
`Nova trajectory <https://osf.io/q4mk2>`_ file.  Download this directly,
or type::

    $ curl -o nova_profile_rescaled.txt -J -L https://osf.io/q4mk2/download

Next use a set of mass fractions from a `zone xml <https://osf.io/n5mw2>`_
file.  These are the initial mass fractions based on a Solar-like composition.
Download the file directly, or type::

    $ curl -o zone_nova.xml -J -L https://osf.io/n5mw2/download

As a useful aside,
a convenient way to create your own zone xml files is to use the
*create_zone_xml.ipynb* Jupyter notebook available at the
`webnucleo_xml <https://github.com/mbradle/webnucleo_xml>`_ repository.

Now run the calculation.  Type::

    $ ./single_zone_network --network_xml ../nucnet-tools-code/data_pub/my_net.xml --nuc_xpath "[z <= 30]" --interp_file nova_profile_rescaled.txt --output_xml out_nova.xml --zone_xml zone_nova.xml --xml_steps 5 --t_end 1000.

Once the calculation is completed, plot quantities of interest.  For example,
check the `temperature <https://osf.io/68jak>`_ as a function of time::

    $ python
    >>> import wnutils.xml as wx
    >>> xml = wx.Xml('out_nova.xml')
    >>> xml.plot_property_vs_property('time', 't9', xlim = [0,1000], xlabel = 'time (s)', ylabel = '$T_9$')

You can also zoom in to see that the interpolater caught the
`double peak <https://osf.io/4cz9f>`_ in the interpolation file::

    >>> xml.plot_property_vs_property('time', 't9', xlim = [100, 110], xlabel = 'time (s)', ylabel = '$T_9$')
