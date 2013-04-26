
README for foreign/samples  (Win32 platforms)
=============================================

CONTENTS:

  1.    Introduction
  2.    The hello example
  3.    DLLexport and DLLimport
  4.    Further assistance


1. Introduction
===============

A single example is given illustrating how the MLWorks(TM) FI operates.
As an example, it does not do a great deal in it's own right.  However,
we hope that it illustrates the basic concept and suggest the kind of
thing that is needed to put your own interfaces together via the FI.

There are many coding styles possible within ML and this sample
is merely a particular example - we neither recommend nor condemn
it.  In particular, the code given here is advisory and given purely
to assist you with making use of the MLWorks FI.


2. The hello example
====================

The example should be run from a source directory containing the
sample in a subdirectory called `foreign\samples'.  This requirement
can be changed by editing the appropriate filename used by calls of
`loadObjectFile' in the ML files.

Before the example can be executed from MLWorks, the corresponding C
code has to be compiled.  To do this, type:

   nmake hello.dll

in the foreign\samples directory.  This will generate the object code
and DLL's for your platform.  When you wish to remove the object files
(including shared object code), type:

   nmake clean

The hello example can either be compiled and loaded using the Project Workspace tool in the MLWorks GUI and opening the foreign_samples.mlp project file, or 
programmatically as shown below:

    Shell.Project.openProject "foreign\\samples\\foreign_samples.mlp";
    Shell.Project.setTargets ["hello.sml"];
    Shell.Project.compileAll ();
    Shell.Project.loadAll ();

Description:
    A very simple example which calls a simple foreign function
    with an integer argument.  It prints a message to standard
    output - this will usually be the controlling Command Prompt
    window.

    Note that when this example is loaded by using loadSource, the message
    printed by the foreign function appears *before* all the ML binding
    information is printed.  This is because the foreign function is
    called *during* the load - and the bindings are always printed at the
    end of the load.


3.    DLLexport and DLLimport
=============================

When making a DLL (Dynamiclly Linked Library) in C, functions and
other defined values will need to be explicitly exported.  With
MicroSoft compilers (e.g. VC++ 4.0), this may be done by -EITHER-
creating a seperate DEF file which lists the exported values -OR- by
annotating with DLLexport or DLLimport appropriately e.g.:

     DLLexport int f (void) { return 42; }
     DLLexport int x = 4

     DLLimport int y;
     DLLimport int g (int);

Simplifying slightly, DLLexport is used to qualify definitions and
DLLimport qualifies declarations.

The names `DLLexport' and `DLLimport' are defined in
foreign\samples\dll.h.  The definition of such names is recommended by
MicroSoft in their documentation.

For further information about DLL's, please consult the MicroSoft
documentation (e.g. MSDN Library and/or VC++ documentation),
obtainable direct from MicroSoft.


4. Further assistance:
======================

Please contact MLWorks support at Harlequin - we will do all we can to
assist you further.

       mlworks-support@harlequin.co.uk
          - UK, Europe, Australia, Africa & South East Asia.

       mlworks-support@harlequin.com
          - North America, Japan & South America.
