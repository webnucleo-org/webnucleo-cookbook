.. _xpath_selection:

XPath Selection
===============

Since Webnucleo network codes can read data from and store data to
`XML <https://www.w3.org/XML/>`_,
you can use `XPath <https://www.w3.org/TR/xpath/>`_ to select data for
a reaction network.  This cookbook helps you get familiar with how to
use XPath with Webnucleo codes.

Begin by retrieving a network XML file.  You can do this directly by
pulling one down from `OSF <https://osf.io/5cyg7/>`_.  To retrieve
a network XML file based on the V2.2 JINA Reaclib database, type::

     $ curl -L -J -o net.xml https://osf.io/kyhbs/download 

Now open *python* and read the file into a network instance::

     $ python
     >>> import wnnet as wn
     >>> net = wn.net.Net('net.xml')

Next, get and print out the nuclides in the network along with their atomic
and mass numbers::

     >>> nucs = net.get_nuclides()
     >>> for nuc in nucs:
     ...     print(nuc, nucs[nuc]['z'], nucs[nuc]['a'])
     ...

Get all the data about a particular nuclide by typing, for example::

     >>> print(nucs['o16'])

Now retrieve a subset of the nuclides.  Select only nuclides with neutron
number 50::

     >>> nucs_n_50 = net.get_nuclides(nuc_xpath = "[a - z = 50]")

and print them out::

     >>> for nuc in nucs_n_50:
     ...     print(nuc, nucs_n_50[nuc]['z'], nucs_n_50[nuc]['n'], nucs_n_50[nuc]['a'])
     ...

You must select on *a - z* because the network XML does not store *n*
separately.  Try other XPath expressions to get other nuclide subsets.

You can also use XPath to select reactions.  Begin by selecting all
reactions and printing them out::

     >>> reacs = net.get_reactions()
     >>> for reac in reacs:
     ...     print(reac)
     ...

Now try selecting only *(n,gamma)* reactions::

     >>> reacs_ng = net.get_reactions(reac_xpath="[reactant = 'n' and product = 'gamma']")
     >>> for reac in reacs_ng:
     ...     print(reac)
     ...

Now print out only reactions with *zr90* as a product::

     >>> for reac in net.get_reactions(reac_xpath="[product = 'zr90']"):
     ...     print(reac)
     ...

XPath has many `functions <https://www.w3schools.com/xml/xsl_functions.asp>`_.
Some may be useful for Webnucleo XML.  For example, you can find the
reactions with exactly three products::

     >>> for reac in net.get_reactions(reac_xpath="[count(product) = 3]"):
     ...     print(reac)
     ...

One can further refine that with::

     >>> for reac in net.get_reactions(reac_xpath="[count(product) = 3 and not(contains(., 'neutrino'))]"):
     ...     print(reac)
     ...

The *.* in this XPath expression refers to the current XML node that is being
evaluated by the parser.

Valid reactions in a Webnucleo reaction network are ones that are between
species actually included in the network (and that conserve baryon number,
charge, and lepton number).  Select valid neutron-capture reactions for
zinc isotopes::

     >>> reacs_zn_ng = net.get_valid_reactions(nuc_xpath = "[z = 30]", reac_xpath = "[reactant = 'n']")
     >>> for reac in reacs_zn_ng:
     ...     print(reac)
     ...

In fact, that prints out no reactions.  The reason is that you have not
included the neutrons in the network.  Fix that by typing::

     >>> reacs_zn_ng = net.get_valid_reactions(nuc_xpath = "[(a - z = 1) or (z = 30)]", reac_xpath = "[reactant = 'n']")

This emphasizes that all species involved in a reaction must be present for
the reaction to be valid.

This cookbook has used *wnnet* to illustrate XPath relevant to Webnucleo.
The C++ network codes similarly use XPath, with nuclide data selected by
the *nuc_xpath* option and reaction data selected by *reac_xpath*.  The
default in those codes is to use all nuclides and all reactions in the
network data.  Those defaults are equivalent to using the expressions
*nuc_xpath = ""* or *nuc_xpath = "[.]" and *reac_xpath = ""* and
*reac_xpath = "[.]"*.
