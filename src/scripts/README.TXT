		 	MLWORKS DISTRIBUTION
			
This directory contains the MLWorks distribution. For unix versions,
the file INSTALL.TXT contains instructions for installing MLWorks, and
a list of files in the distribution with brief descriptions is in the
file MANIFEST.

MLWorks implements the Definition of Standard ML (Revised 1996), and
provides the Standard ML Basis Library.  Both these involve some
changes to the original definition of Standard ML.  MLWorks provides
backwards compatibility modes to support existing code.

Larry Paulson has updated his book "ML for the Working Programmer" to
use the new Definition and the new Basis Library.  Ask for the second
edition.  (CUP, 1996, ISBN 0 521 57050 6 (hardback), 0 521 56543 X
(paperback)).

The revised version of the Definition of Standard ML is written by the
authors of the original definition, and will be published by MIT Press.
The authors have supplied a brief overview of the penultimate version,
which you can find in postscript format in the file sml_97.ps.  The
most important changes are:

  - Adoption of the value restriction rule for generalising polymorphic
    types.  This removes the need for imperative type variables (in
    effect, all type variables are "imperative").

  - The addition of type abbreviations in signatures.

  - The addition of a construct for opaque signature matching.

  - Some limitations on type sharing, and changing structure sharing
    to a derived form.

  - The addition of new special constants for words and hexadecimal 
    integers.

  - Overloaded constants and functions elaborate to a default type if
    the context does not force them to a particular type.

The authors of the Definition have asked us to point out that the final
version of the revised definition will not include the "own" reserved
word mentioned in the sml_97.ps document, and will include a construct
for copying datatypes.

To use code written for the original Definition of Standard ML, set the
SML 1990 option in the Mode Preferences dialog.


The Standard ML Basis Library is a proposal for a sophisticated library
to replace the minimal "initial basis" provided by the original Definition
of Standard ML.   This has been developed jointly by Harlequin and the
developers of Standard ML of New Jersey and Moscow ML.  The full definition
can be found on the World-Wide Web at:

  http://cm.bell-labs.com/cm/cs/what/smlnj/basis/pages/sml-std-basis.html

A European mirror site is currently at:

  http://www.dina.kvl.dk/%7Esestoft/sml/sml-std-basis.html 

The library is largely a conservative extension of the initial basis 
described in the original Definition of Standard ML, but there are
a few incompatibilities:

  - The IO operations are no longer at top-level, and some of the IO
    functions have changed.

  - The maths functions (sqrt, sin, etc.) are no longer at top level.

  - A type char of characters has been added.  The functions implode,
    explode, ord and chr use this type instead of strings.

  - Real values are now explicitly IEEE floating-point, with non-trapping
    semantics.

  - Numeric constants may be overloaded on different-sizes of representations.

  - Certain exceptions have been eliminated or replaced with new exceptions.

To use code written for the original Definition of Standard ML, open
the "Old" structure in the Basis Library.
