#	==== MLWORKS PROJECT MAKEFILE ====
#
# Revision Log
# ------------
# $Log: Makefile,v $
# Revision 1.6  1996/08/22 10:48:37  jont
# Prevent accidental use
#
# Revision 1.5  1995/02/24  17:00:07  jont
# Make image building for distribution OS and architecture specific
#
# Revision 1.4  1995/02/24  15:40:04  jont
# Modify for new /u directory structure
#
# Revision 1.3  1994/01/28  17:15:43  daveb
# Changed location of SRC directory.
#
# Revision 1.2  1993/09/01  13:37:32  jont
# Changed to put the cd and make on one line, cos they don't work otherwise
#
# Revision 1.1  1993/05/12  16:26:45  jont
# Initial revision
#

SML_HOME=/u/sml
DISTDIR=$(SML_HOME)/distribution
SRC=$(SML_HOME)/MLW/src
RM=/bin/rm -f
LN=/bin/ln
CP=/bin/cp -p

distribution: force
ifdef OS
ifdef ARCH
	@echo Cannot make distribution from MLW, restart from src
	exit 1
else
	@echo Cannot make distribution, ARCH not set
	exit 1
endif
else
	@echo Cannot make distribution, OS not set
	exit 1
endif

force:
