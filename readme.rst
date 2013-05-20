MLWorks Repository
==================
MLWorks is a compiler and interactive development environment for the
Standard ML language, developed by Harlequin in the 1990s and now owned by
Ravenbrook Limited.

The main project page is at <http://www.ravenbrook.com/project/mlworks/>.

MLWorks has recently been rebooted [#reboot]_ and we now have a command-line
compiler that can compile itself on Windows.  See `the roadmap` for
our plans to get it running on other platforms, and work beyond that.
Get involved!

Want to run the command-line compiler?  On Windows, grab
<http://www.ravenbrook.com/project/mlworks/release/reboot/MLWorks-reboot.zip>.
Unpack that then::

    cd MLWorks-reboot
    bin\I386\NT\main -MLWpass foo -load images\I386\NT\batch.img -MLWpass foo

and you should get a batch compiler.

Append arguments to the batch compiler to the second command.  For
example::

    bin\I386\NT\main -MLWpass foo -load images\I386\NT\batch.img -MLWpass foo -help

This is the barest of bare releases, but it's enough to compile a
compiler.

**IMPORTANT**: This repository currently starts at the latest revision
of the MLWorks sources, and does not include the full version history.
The master branch at some point be *rebased* to include the full
history. Please work in branches to keep the number of master commits
low and minimise disruption when this occurs.  For details, see
<https://github.com/Ravenbrook/mlworks/wiki/History-recovery>.

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

.. [#reboot] See "MLWorks rebooted!" in the mlworks-discussion mailing
   list archive
   <http://mailman.ravenbrook.com/mailman/private/mlworks-discussion/2013-May/000056.html>
