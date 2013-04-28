MLWorks Temporary Repository
============================
MLWorks is a compiler and interactive development environment for the
Standard ML language, developed by Harlequin in the 1990s and now owned by
Ravenbrook Limited.

The main project page is at http://www.ravenbrook.com/project/mlworks/

MLWorks does not currently build.  The compiler is written in Standard
ML and should be easy to bootstrap.  The run-time system is a mixture of
C and assembler but is neither large nor complicated, and should be easy
to port.  Get involved!

**IMPORTANT**: This is a temporary Git repository starting at the latest
revision of the MLWorks sources, and does not include the full version
history. This repository will be *replaced* by one with a full history,
and any work will need to be migrated.  Please consider this before cloning
or forking.

Please join the MLWorks discussion mailing list 
<http://mailman.ravenbrook.com/mailman/listinfo/mlworks-discussion>.

MLWorks is a commercially developed "industrial strength" ML development
system, developed by Harlequin in the 1990s.  Harlequin broke up in
1998, and MLWorks became property of Xanalys Limited.  Ravenbrook
Limited (whose directors were members of the original MLWorks team)
acquired the rights to MLWorks on 2013-04-26 and open sourced the
project.

Ravenbrook would like to thank Xanalys, and especially Paul Miller, for
being both willing and generous to help with the open source publishing
of this work.

Build Notes
-----------

Ubuntu Linux
............

To get started building the rts on Linux, you will need the following
packages installed on top of a normal development environment:

* libelf-dev
* libxt-dev
* libxpm-dev
* libmotif-dev
* libxp-dev

If you are building on 64 bit Linux, you will also need:

* ia32-libs
* 32 bit versions of the above packages (``libelf-dev:i386``, etc).
