# MOVE SCRIPTS AND MAN PAGES TO DISTRIBUTION DIRECTORY
#
# This directory contains the scripts and man pages needed for the
# MLWorks distribution.  This Makefile puts them in the right place.
#
# Revision Log
# ------------
# $Log: Makefile,v $
# Revision 1.33  1998/08/27 16:13:46  mitchell
# [Bug #30470]
# Add mlworks.gif to the distribution
#
# Revision 1.32  1998/06/23  13:56:23  jkbrook
# [Bug #30427]
# Different formatting required for legal agreement under Windows
#
# Revision 1.31  1998/06/17  11:13:31  jkbrook
# [Bug #30424]
# Restore links to doc from MLWorks
#
# Revision 1.30  1998/06/12  09:21:25  jkbrook
# [Bug #30411]
# Include file containing licence agreement
#
# Revision 1.29  1998/04/06  12:44:34  jkbrook
# [Bug #50046]
# Temporarily include dummy HTML file for Help menu
#
# Revision 1.28  1998/02/06  16:12:25  jkbrook
# [Bug #30132]
# README.TXT should be README on Unix
#
# Revision 1.27  1998/02/06  14:10:09  jkbrook
# [Bug #30216]
# Adding -tty script for Windows
#
# Revision 1.26  1997/12/16  14:42:34  jont
# [Bug #30246]
# Move dummy script creation from rts/GNUmakefile to scripts/Makefile
#
# Revision 1.25  1997/10/01  17:19:42  jkbrook
# [Bug #20088]
# Merging from MLWorks_11:
# SML'96 should be SML'97
#
# Revision 1.24  1997/09/30  10:44:47  jkbrook
# [Bug #30254]
# Adding single entry page for html documentation
#
# Revision 1.23  1997/04/04  09:55:25  daveb
# Moved README to README.TXT
#
# Revision 1.22  1997/01/09  11:25:45  jont
# [Bug #1816]
# Some modifications to cope with new version of GNU tools
#
# Revision 1.21  1996/11/15  17:35:12  daveb
# Added bug-template.txt to the top level items.
#
# Revision 1.20  1996/11/06  15:30:14  jont
# Add mlimage-console.bat.in and mlimage-windows.bat.in
# Remove mlimage.bat.in
#
# Revision 1.19  1996/10/11  16:16:32  jont
# Remove INSTALL.TXT from PC distribution
#
# Revision 1.18  1996/10/11  15:01:50  jont
# More improvements to building install-mlworks
#
# Revision 1.17  1996/09/03  11:22:51  jont
# Sort out problems making stuff universally readable
#
# Revision 1.16  1996/08/23  12:28:02  jont
# Ensure all directories and files created are world readable
#
# Revision 1.15  1996/08/20  11:23:22  daveb
# Changed default destination directory from /usr/sml to /u/sml.
#
# Revision 1.14  1996/08/16  10:53:49  jont
# Add mlimage to list of man pages to be put in a release
#
# Revision 1.13  1996/07/31  13:50:26  jont
# install has become install-mlworks
#
# Revision 1.12  1996/07/04  15:55:09  jont
# Add mlworks-basis.in to list of scripts for distribution
#
# Revision 1.11  1996/07/02  16:18:59  jont
# Add mlimage.bat.in to list of scripts for Win32
#
# Revision 1.10  1996/06/24  16:31:09  daveb
# Added sml_96.ps.
#
# Revision 1.9  1996/06/14  13:28:35  jont
# Modify so correct scripts are installed under NT
#
# Revision 1.8  1996/05/29  12:05:04  jont
# Add mlimage to set of scripts
#
# Revision 1.7  1996/04/23  10:49:38  jont
# Tidying up for Win95 and NT distributions
#
# Revision 1.6  1996/04/02  16:33:07  jont
# Modify install en route to distribution directory to acquire
# ARCH and OS en route
#
# Revision 1.5  1996/03/01  17:05:05  jont
# Modifications to make distribution work on NT
#
# Revision 1.4  1994/01/31  11:43:50  daveb
# Added chmod comand to make install script executable after copying.
#
# Revision 1.3  1993/09/28  10:46:47  daveb
# Merged in bug fix.
#
# Revision 1.1.1.3  1993/09/28  10:46:08  daveb
# Added Log.
#

DISTDIR = /u/sml/distribution

ifeq "$(OS)" "NT"
NTTYPE=TRUE
else
ifeq "$(OS)" "Win95"
NTTYPE=TRUE
else
NTTYPE=FALSE
endif
endif
ifeq "$(NTTYPE)" "TRUE"
RM		= rm -rf
CP		= cp
MKDIR		= mkdir
else
RM      = /bin/rm -rf
CP      = /bin/cp -p
MKDIR   = /bin/mkdir
endif

chmod_exec=chmod 775
chmod_non_exec=chmod 664
chmod_read_only=chmod 444

ifeq "$(NTTYPE)" "TRUE"
TOPLEVEL = README.TXT sml_97.ps bug-template.txt
else
TOPLEVEL = INSTALL.TXT README.TXT sml_97.ps bug-template.txt
endif

ENV = cshenv.in emacs.in rcenv.in shenv.in
MAN1 = mlbatch.1.in mlrun.1.in mlpervasive.1.in mlworks.1.in mlimage.1.in mlworks-basis.1.in
ifeq "$(NTTYPE)" "TRUE"
SCRIPTS = mlbatch.bat.in mlpervasive.bat.in mlimage-console.bat.in mlimage-windows.bat.in mlconsole.bat.in
HTML = doc_indx.htm hqnlogo.gif mlworks.gif
else
SCRIPTS = mlbatch.in mlpervasive.in mlworks.in mlworks-basis.in mlimage.in 
endif

ifeq "$(NTTYPE)" "TRUE"
distribution: toplevel scripts html
else
distribution: toplevel env man1 scripts install_script
endif

toplevel: $(TOPLEVEL)
	cd $(DISTDIR) && $(RM) $(TOPLEVEL)
	$(CP) $(TOPLEVEL) $(DISTDIR)
	$(chmod_read_only) $(TOPLEVEL:%=$(DISTDIR)/%)
ifeq "$(NTTYPE)" "TRUE"
else
	cd $(DISTDIR) && mv README.TXT README
endif

install_script: install-mlworks
	cd $(DISTDIR) && $(RM) install-mlworks
ifeq "$(OS)" "Solaris"
	sed -e "s/ARCH=SPARC/ARCH=$(ARCH)/g;s/OS=SunOS/OS=$(OS)/g;s?XKEYSYMDB=/usr/lib/X11/XKeysymDB?XKEYSYMDB=/usr/openwin/lib/X11/XKeysymDB?g" install-mlworks > $(DISTDIR)/install-mlworks
else
ifeq "$(OS)" "Irix"
	sed -e "s/ARCH=SPARC/ARCH=$(ARCH)/g;s/OS=SunOS/OS=$(OS)/g;s?XKEYSYMDB=/usr/lib/X11/XKeysymDB?#XKEYSYMDB=/usr/lib/X11/XKeysymDB?g;s?export XKEYSYMDB?#export XKEYSYMDB?g" install-mlworks > $(DISTDIR)/install-mlworks
else
	sed -e "s/ARCH=SPARC/ARCH=$(ARCH)/g;s/OS=SunOS/OS=$(OS)/g" install-mlworks > $(DISTDIR)/install-mlworks
endif
endif
	chmod 555 $(DISTDIR)/install-mlworks

env: $(ENV)
	$(RM) -r $(DISTDIR)/env
	$(MKDIR) $(DISTDIR)/env
	$(CP) $(ENV) $(DISTDIR)/env
	$(chmod_read_only) $(ENV:%=$(DISTDIR)/env/%)

man1: $(MAN1)
	$(RM) -r $(DISTDIR)/man
	$(MKDIR) $(DISTDIR)/man $(DISTDIR)/man/man1
	$(CP) $(MAN1) $(DISTDIR)/man/man1
	$(chmod_read_only) $(MAN1:%=$(DISTDIR)/man/man1/%)

scripts: $(SCRIPTS)
ifeq "$(NTTYPE)" "TRUE"
	cat NUL: > $(DISTDIR)/bin/$(ARCH)/$(OS)/mlbatch.bat
	cat NUL: > $(DISTDIR)/bin/$(ARCH)/$(OS)/mlpervasive.bat
	cat NUL: > $(DISTDIR)/bin/$(ARCH)/$(OS)/mlimage-windows.bat
	cat NUL: > $(DISTDIR)/bin/$(ARCH)/$(OS)/mlimage-console.bat
	cat NUL: > $(DISTDIR)/bin/$(ARCH)/$(OS)/mlconsole.bat
endif
	cd $(DISTDIR) && $(RM) scripts
	$(MKDIR) $(DISTDIR)/scripts
	$(CP) $(SCRIPTS) $(DISTDIR)/scripts
	$(chmod_read_only) $(SCRIPTS:%=$(DISTDIR)/scripts/%)

html: $(HTML)
	cd $(DISTDIR) && $(RM) html 
	$(MKDIR) $(DISTDIR)/html
	$(CP) $(HTML) $(DISTDIR)/html
	$(chmod_read_only) $(HTML:%=$(DISTDIR)/html/%)
