#
#	==== Makefile for MLWorks Emacs server ====
#
# Revision Log
# ------------
# $Log: Makefile,v $
# Revision 1.14  1999/03/20 16:29:05  mitchell
# Fix to work with RedHat 5.2
#
# Revision 1.13  1998/01/20  10:28:14  jkbrook
# [Bug #30289]
# Merging from MLWorks_10r3:
# strip is in /usr/bin on Linux
#
# Revision 1.12  1996/02/09  16:00:57  daveb
# Added link to current directory.
#
# Revision 1.11  1996/01/31  11:41:14  stephenb
# Instead of passing through OS names to the C code and having
# it #ifdef left right and center, now passes through feature
# names.
#
# Revision 1.10  1996/01/10  13:05:07  nickb
# Fix directory screw-up and add OS conditions.
#
# Revision 1.9  1995/05/04  15:10:30  jont
# Place mlworks-server in ARCH/OS specific place to avoid conflicts
#
# Revision 1.8  1995/05/04  09:20:49  jont
# Don't delete entire etc directory when making distribution
#
# Revision 1.7  1995/05/03  13:41:29  jont
# Pass ARCH to make of mlworks-server.c
# Place resulting mlworks-server in an arch/os specific directory
#
# Revision 1.6  1993/09/27  19:32:42  daveb
# Merged in bug fix.
#
# Revision 1.5.1.2  1993/09/27  19:30:52  daveb
# Remove entire target directory before copying new stuff across, then make
# sure that new target directory is created.
#
# Revision 1.5.1.1  1993/08/12  13:19:18  jont
# Fork for bug fixing
#
# Revision 1.5  1993/08/12  13:19:18  jont
# Changed to remove old mlworks-server before installing new one
#
# Revision 1.4  1993/06/22  13:17:38  richard
# Added a rule for mlworks-server-g for debugging purposes.
#
# Revision 1.3  1993/05/12  14:08:21  richard
# Added a rule for `distribution'.
#
# Revision 1.2  1993/03/15  14:13:06  richard
# New Makefile for a new server.
#


CC	= gcc
CFLAGS	= -O -ansi -I../../rts/src/OS/$(OS) -I../../rts/src -I../../rts/src/arch/$(ARCH)
RM	= /bin/rm -f
CP	= /bin/cp -p
LN	= /bin/ln
MKDIR   = /bin/mkdir
DISTDIR	= /u/sml/distribution
STRIP	= /bin/strip
CLIBS   =
CDEFS   =

ifeq "$(OS)" "Solaris"
STRIP	= /usr/ccs/bin/strip
CLIBS   = -lsocket
endif

ifeq "$(OS)" "Linux"
STRIP	= /usr/bin/strip
CDEFS   := $(CDEFS) -DMLW_DEFINE_SIGACTION
endif

ifeq "$(OS)" "Irix"
CDEFS   := $(CDEFS) -D_BSD_SIGNALS -D__EXTENSIONS__ -D_POSIX_SOURCE -DMLW_NO_SOCKET_PROTECTION
#
# MLW_NO_SOCKET_PROTECTION is there because if the socket is protected
# by chmoding it, the client cannot connect to the server.
endif

mlworks-server: force
	$(MAKE) $(ARCH)/$(OS)/mlworks-server
	$(RM) $@
	$(LN) -s $(ARCH)/$(OS)/mlworks-server $@

$(ARCH)/$(OS)/mlworks-server-g: mlworks-server.c
	$(CC) $(CFLAGS) -g -o $@ mlworks-server.c

$(ARCH)/$(OS)/mlworks-server: mlworks-server.c
	-$(MKDIR) -p $(ARCH)/$(OS)
	$(CC) $(CFLAGS) $(CLIBS) $(CDEFS) -o $@ mlworks-server.c
	$(STRIP) $(ARCH)/$(OS)/mlworks-server

clean:
	$(RM) $(ARCH)/$(OS)/mlworks-server* *.o *~ core

distribution: $(ARCH)/$(OS)/mlworks-server
	$(RM) -r $(DISTDIR)/lib/emacs/etc/$(ARCH)/$(OS)
	-$(MKDIR) $(DISTDIR)/lib $(DISTDIR)/lib/emacs $(DISTDIR)/lib/emacs/etc $(DISTDIR)/lib/emacs/etc/$(ARCH) $(DISTDIR)/lib/emacs/etc/$(ARCH)/$(OS)
	$(CP) $(ARCH)/$(OS)/mlworks-server $(DISTDIR)/lib/emacs/etc/$(ARCH)/$(OS)

force:
