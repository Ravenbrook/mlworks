# MOVE DEMOS TO DISTRIBUTION DIRECTORY
#
# This directory contains the examples for the MLWorks distribution.
# This Makefile puts them in the right place.
#
# Copyright (C) 1997 The Harlequin Group Ltd.  All rights reserved.
#
# Revision Log
# ------------
# $Log: Makefile,v $
# Revision 1.17  1998/08/19 13:48:51  johnh
# [Bug #30472]
# Make project files for demos/
#
# Revision 1.16  1998/07/23  12:24:51  johnh
# [Bug #30441]
# Distribute capi demo.
#
# Revision 1.15  1998/05/06  18:25:52  jkbrook
# [Bug #30408]
# Add project examples (from doc)
#
# Revision 1.14  1998/01/14  17:15:14  jkbrook
# [Bug #30306]
# Removing incomplete FI from distribution in 2.0m2
#
# Revision 1.13  1997/06/13  17:08:11  jkbrook
# [Bug #50007]
# Merging changes from 1.0r2c2 into 2.0m0
#
#
# Revision 1.12  1997/05/19  15:28:03  stephenb
# [Bug #30121]
# Move to new FI: update distribution mechanism to distribute
# the examples for the new FI.
#
# Revision 1.11  1997/05/15  12:38:14  daveb
# [Bug #30117]
# On Windows, copy README to README.TXT
#
# Revision 1.10  1997/04/03  12:07:59  andreww
# [Bug #2016]
# adding threads demos to distribution.
#
# Revision 1.9  1997/01/09  15:23:41  jont
# [Bug #1845]
# Tidying up, and stuff to do with getting permissions
# correct in distribution so installer doesn't have to do it
#
# Revision 1.8  1997/01/08  15:46:55  jont
# [Bug #1816]
# Modify for use with beta-17 GNU tools
#
# Revision 1.7  1996/11/07  15:49:17  jont
# Ensure distribution of motif or mswindows ass appropriate
#
# Revision 1.6  1996/10/09  10:40:18  jont
# Stop putting cypher example in demos due to US stupidity
#
# Revision 1.5  1996/08/23  12:05:13  jont
# Ensure all directories and files created are world readable
#
# Revision 1.4  1996/08/22  10:51:13  jont
# Sort out problems with remove_log.sh
#
# Revision 1.3  1996/08/21  09:44:56  jont
# Use an explicit path to find remove_hdr.sh
#
# Revision 1.2  1996/08/20  10:59:25  daveb
# Changed name of destination directory to examples.
#
# Revision 1.1  1996/08/19  14:13:35  daveb
# new unit
# Makefile for distributing demo files.
#
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
CAPI_PROJECT    = gui/capi-mswindows.mlp
WINSYS		= mswindows
else
RM      	= /bin/rm -rf
CP      	= /bin/cp -p
MKDIR   	= /bin/mkdir
CAPI_PROJECT    = gui/capi-motif.mlp
WINSYS		= motif
endif

remove_log	= ../tools/remove_log.sh
ifeq "$(NTTYPE)" "TRUE"
distribution: basis mswindows threads projects gui
else
distribution: basis motif threads projects gui
endif

chmod_exec=chmod 775
chmod_non_exec=chmod 664
chmod_read_only=chmod 444


basis:	force
	cd $(DISTDIR) && $(RM) examples/basis
	-$(MKDIR) $(DISTDIR)/examples/basis
	$(chmod_exec) $(DISTDIR)/examples/basis
	for x in basis/INDEX basis/*.mlp basis/reals basis/*.sml basis/*.txt; do $(remove_log) < $$x > $(DISTDIR)/examples/basis/`basename $$x`; done
	cd  $(DISTDIR) && $(RM) examples/basis/*cipher.sml
	$(chmod_non_exec) $(DISTDIR)/examples/basis/*

motif:	force
	$(RM) $(DISTDIR)/examples/motif
	-$(MKDIR) $(DISTDIR)/examples/motif
	$(chmod_exec) $(DISTDIR)/examples/motif
	for x in motif/*.mlp motif/*.sml motif/*.txt; do $(remove_log) < $$x > $(DISTDIR)/examples/motif/`basename $$x`; done
	$(chmod_non_exec) $(DISTDIR)/examples/motif/*

mswindows:	force
	cd $(DISTDIR) && $(RM) examples/mswindows
	-$(MKDIR) $(DISTDIR)/examples/mswindows
	$(chmod_exec) $(DISTDIR)/examples/mswindows
	for x in mswindows/*.mlp mswindows/*.sml mswindows/*.txt; do $(remove_log) < $$x > $(DISTDIR)/examples/mswindows/`basename $$x`; done
	$(chmod_non_exec) $(DISTDIR)/examples/mswindows/*

gui:	force
	cd $(DISTDIR) && $(RM) examples/gui examples/gui/$(WINSYS)
	-$(MKDIR) $(DISTDIR)/examples/gui
	-$(MKDIR) $(DISTDIR)/examples/gui/$(WINSYS)
	$(chmod_exec) $(DISTDIR)/examples/gui
	$(chmod_exec) $(DISTDIR)/examples/gui/$(WINSYS)
	for x in gui/*.sml; do $(remove_log) < $$x > $(DISTDIR)/examples/gui/`basename $$x`; done
	for x in gui/README; do $(remove_log) < $$x > $(DISTDIR)/examples/gui/`basename $$x`; done
	for x in gui/$(WINSYS)/*.sml; do $(remove_log) < $$x > $(DISTDIR)/examples/gui/$(WINSYS)/`basename $$x`; done
	for x in $(CAPI_PROJECT); do $(remove_log) < $$x > $(DISTDIR)/examples/gui/capi.mlp; done
	for x in gui/*.mlp; do $(remove_log) < $$x > $(DISTDIR)/examples/gui/`basename $$x`; done
	rm $(DISTDIR)/examples/gui/capi-mswindows.mlp
	rm $(DISTDIR)/examples/gui/capi-motif.mlp
	$(chmod_non_exec) $(DISTDIR)/examples/gui/$(WINSYS)/*
	$(chmod_non_exec) $(DISTDIR)/examples/gui/*.*

threads:	force
	cd $(DISTDIR) && $(RM) examples/threads
	-$(MKDIR) $(DISTDIR)/examples/threads
	$(chmod_exec) $(DISTDIR)/examples/threads
	for x in threads/README threads/*.mlp threads/*.sml; do $(remove_log) < $$x > $(DISTDIR)/examples/threads/`basename $$x`; done
ifeq "$(NTTYPE)" "TRUE"
	mv $(DISTDIR)/examples/threads/README $(DISTDIR)/examples/threads/README.TXT
else
endif
	$(chmod_non_exec) $(DISTDIR)/examples/threads/*

projects:	force
	cd $(DISTDIR) && $(RM) examples/projects examples/projects/subprojects
	-$(MKDIR) $(DISTDIR)/examples/projects
	-$(MKDIR) $(DISTDIR)/examples/projects/subprojects
	$(chmod_exec) $(DISTDIR)/examples/projects
	$(chmod_exec) $(DISTDIR)/examples/projects/subprojects
	for x in projects/*.sml; do $(remove_log) < $$x > $(DISTDIR)/examples/projects/`basename $$x`; done
	for x in projects/subprojects/*.sml projects/subprojects/*.mlp; do $(remove_log) < $$x > $(DISTDIR)/examples/projects/subprojects/`basename $$x`; done
	$(chmod_non_exec) $(DISTDIR)/examples/projects/*.sml
	$(chmod_non_exec) $(DISTDIR)/examples/projects/subprojects/*

force:
	-$(MKDIR) $(DISTDIR)/examples
	$(chmod_exec) $(DISTDIR)/examples


