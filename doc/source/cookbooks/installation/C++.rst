.. _c++:

C++
===

The `Webnucleo <https://webnucleo.readthedocs.io>`_ C++ codes are organized
as a set of header files and separate individual projects.  To install a
project, first create a directory where you would like the projects to
be located.  You can create type something like::

    $ mkdir my-projects
    $ cd my-projects

Once that's done, clone the header files::

    $ git clone https://bitbucket.org/mbradle/wn_user

Then pull down and compile the single-zone network project::

    $ git clone https://bitbucket.org/mbradle/single_zone
    $ cd single_zone
    $ ./project_make

If that compiles correctly, then you should be able to type::

    $ ./single_zone_network

which should print out some usage information::

    Usage: ./single_zone_network [program_options]
    Help Options:
      --help                print out usage statement and exit
                        
      --example             print out example usage and exit
                        
      --response-file arg   can be specified with '@name', too
                        
      --program_options arg print out list of program options (help, hydro, 
                            matrix_modifier, network_data, network_evolver, 
                            network_limiter, network_time, nse_corrector, 
                            outputter, properties_updater, rate_modifier, 
                            rate_registerer, screener, step_printer, time_adjuster,
                            zone_data, or all) and exit


Further usage information can be obtained by specifying the class::

    $ ./single_zone_network --program_options network_data

or, even, for short::

    $ ./single_zone_network --prog network_data
    
