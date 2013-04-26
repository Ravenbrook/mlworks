#	==== MLWORKS SOURCE MAKEFILE ==== 
# 
# Revision Log
# ------------
# $Log: Makefile,v $
# Revision 1.81  1999/03/20 12:55:47  mitchell
# Replace incorrect uses of /$(ARCH)/$(OS) by /$(ARCH_OS)
#
# Revision 1.80  1999/03/18  12:17:45  johnh
# [Bug #190530]
# copy correct mutex mos (without batch precompiled).
#
# Revision 1.79  1999/03/17  17:39:20  johnh
# [Bug #190529]
# distribute FI stub generator
#
# Revision 1.78  1999/03/17  10:18:38  mitchell
# [Bug #190526]
# Abel doesn't understand touch --reference=file so use -r file instead
#
# Revision 1.77  1999/03/16  12:53:20  mitchell
# [Bug #190526]
# Move dependency files below the configuration subdirectory
#
# Revision 1.76  1999/03/15  14:21:54  johnh
# [Bug #190506]
# Copy correct gui mos into distribution.
#
# Revision 1.75  1999/03/13  13:19:26  mitchell
# [Bug #190526]
# Preserve file mod times when removing logs
#
# Revision 1.73  1999/03/12  11:41:11  johnh
# [Bug #190506]
# Remove old FI.
#
# Revision 1.72  1998/08/19  11:35:16  johnh
# [Bug #30472]
# Copy gui project file into distribution from scripts.
#
# Revision 1.71  1998/06/18  16:19:55  johnh
# [Bug #30425]
# Distribute basis project file.
#
# Revision 1.70  1998/06/18  14:29:51  jkbrook
# [Bug #50082]
# Make InstallShield source files writable so that they can
# be moved so as to avoid distributing them to users
#
# Revision 1.69  1998/05/11  16:44:07  jkbrook
# [Bug #50079]
# Fix copying of objects into distribution directory on Win95
#
# Revision 1.68  1998/05/05  18:55:43  jkbrook
# [Bug #30354]
# Temporarily restore old FI to distribution
#
# Revision 1.67  1998/05/05  17:56:54  io
# [Bug #50079]
# enable ARCH_OS for building shared distributions with NT mos and 95 runtimes
#
# Revision 1.66  1998/04/01  12:25:19  jont
# [Bug #70086]
# *windows has moved to *windows_gui
#
# Revision 1.65  1998/03/26  14:38:05  jkbrook
# [Bug #30362]
# Objects should be in objects/ARCH/OS/MODE
#
# Revision 1.64  1998/03/26  12:07:51  jkbrook
# [Bug #30374]
# {__}terminal.mo should be included in the distribution
#
# Revision 1.63  1998/03/20  20:35:33  jkbrook
# [Bug #30362]
# Need to copy object files from Mode subdirectory into distribution
#
# Revision 1.62  1998/02/16  17:25:05  jkbrook
# [Bug #30363]
# Change distribution directory structure to reflect flat object namespace
#
# Revision 1.61  1998/01/13  18:21:46  jkbrook
# [Bug #30306]
# Removing incomplete FI from 2.0m2 distribution
#
# Revision 1.60  1997/11/24  13:58:10  daveb
# [Bug #30304]
# Removed special treatment of SML90 files, as these are now part of the
# Basis Library.
#
# Revision 1.59  1997/10/10  09:52:00  daveb
# [Bug #20090]
# No longer need to call set_sml_time on object files.
#
# Revision 1.58  1997/10/01  14:33:56  jkbrook
# [Bug #50021]
# Merging from MLWorks_11:
# Make utils signatures read-only.
#
# Revision 1.57  1997/09/29  17:19:37  jkbrook
# [Bug #30153]
# Distribution must refer to sml90 instead of old
#
# Revision 1.56  1997/07/23  12:52:32  jont
# [Bug #20096]
# Ensure old MANIFEST files removed before moving in new one
#
# Revision 1.55  1997/07/01  14:10:48  stephenb
# [Bug #30029]
# The MLWorks<->C interface has grown.  Replace {__,}c.sml with
# {__,}mlworks_c_interface, {__,}mlworks_c_io, {__,}mlworks_dynamic_library,
# {__,}mlworks_c_resource and {_,}mlworks_c_pointer.sml
#
# Revision 1.54  1997/06/13  17:26:37  jkbrook
# [Bug #30149]
# Merging in changes from 1.0r2c2 into 2.0m0:
# On Windows, copy setup.rul and setup.lst to the distribution directory.
#
#
# Revision 1.53  1997/05/21  12:07:05  stephenb
# [Bug #30121]
# Move to new FI: update distribution mechanism to distribute
# the new FI rather than the old one.
#
# Revision 1.52  1997/05/15  12:37:24  daveb
# [Bug #30117]
# Copied foreign/samples/Win32/README to the distribution.
#
# Revision 1.51  1997/04/07  12:25:15  jont
# Set time stamps on object files explicitly, since cp -p
# seems to be failing under Win32
#
# Revision 1.50  1997/04/03  17:09:20  daveb
# Fixed mistake in previous change.
#
# Revision 1.49  1997/04/03  13:42:40  andreww
# [Bug #2016]
# adding mutexes to utils directory
#
# Revision 1.48  1997/01/09  14:44:58  jont
# [Bug #1845]
# Tidying up, and stuff to do with getting permissions
# correct in distribution so installer doesn't have to do it
#
# Revision 1.47  1997/01/08  16:11:23  jont
# [Bug #1816]
# Modify for use with beta-17 gnu tools
#
# Revision 1.46  1996/12/04  14:30:22  jont
# [Bug #0]
# Ensure .sml files are timestamp preserved when placed in distribution
#
# Revision 1.45  1996/11/19  17:30:51  jont
# Problem with add_copyright somewhere
#
# Revision 1.44  1996/11/13  18:08:04  jont
# [Bug #1762]
# Distribute basis/{,__}old.mo
#
# Revision 1.43  1996/11/13  10:52:55  daveb
# Added foreign/samples/$(PLATFORM)/README to distribution.
#
# Revision 1.42  1996/11/08  18:15:25  jont
# [Bug #1748]
# Run remove_log on distributed foreign sample files
#
# Revision 1.41  1996/11/08  16:53:03  jont
# [Bug #1747]
# Ensure only required stuff from foreign samples is distributed
#
# Revision 1.40  1996/11/07  15:44:13  andreww
# [Bug #1741]
# Removing foreign/samples/Unix/regexp.* from distribution.
#
# Revision 1.39  1996/11/06  11:30:24  jont
# Ensure only one Makefile distributed for foreign samples on unix
#
# Revision 1.38  1996/11/06  11:03:50  jont
# Remove spurious $/ in various shell lines
#
# Revision 1.37  1996/08/29  16:51:49  jont
# Fix problems of pervasive files losing timestamps on Win95 and NT
# when making distribution
#
# Revision 1.36  1996/08/22  10:45:05  jont
# Modify entry to demo directory to work better on NT and Win95
#
# Revision 1.35  1996/08/19  13:33:37  daveb
# Added call to make demos.
#
# Revision 1.34  1996/06/27  13:04:47  jont
# Change DESTDIR to DISTDIR
#
# Revision 1.33  1996/06/20  16:20:23  brianm
# Adding platform specific (Unix/Win32) foreign samples ...
#
# Revision 1.32  1996/06/14  13:10:49  jont
# Sort out problems on NT
#
# Revision 1.31  1996/06/07  12:52:00  jont
# Ensure all files and directories are made readable
#
# Revision 1.30  1996/06/06  15:30:29  jont
# Fix minor bungle when adding basis files to distribution
#
# Revision 1.29  1996/06/06  14:47:49  jont
# Add foreign samples to the distribution
#
# Revision 1.28  1996/06/06  11:48:56  jont
# Add stuff to put basis signatures in the distribution
#
# Revision 1.27  1996/05/16  16:23:08  jont
# Tidy up, add foreign to distribution
#
# Revision 1.26  1996/05/02  17:31:44  jont
# Get the basis files from the make process on images
#
# Revision 1.25  1996/04/25  11:46:43  jont
# Change maths to math
#
# Revision 1.24  1996/04/23  10:45:24  jont
# Tidying up for Win95 and NT distributions
#
# Revision 1.23  1996/04/18  17:22:48  jont
# initbasis becomes basis
#
# Revision 1.22  1996/04/11  11:17:31  stephenb
# Updated wrt process -> os_process name change in initbasis.
#
# Revision 1.21  1996/04/11  11:07:42  jont
# Modifications to file list for distribution
#
# Revision 1.20  1996/03/08  15:14:06  jont
# More distribution work
#
# Revision 1.19  1996/03/01  16:38:25  jont
# More changes to get distributions working under NT
#
# Revision 1.18  1996/02/28  17:37:28  jont
# Modifications to allow distributions to be built for NT and Win95
#
# Revision 1.17  1996/01/24  11:28:16  jont
# Move xm files into motif
#
# Revision 1.16  1996/01/18  16:33:58  stephenb
# OS reorganisation: add the UNIX/NT specific files that have
# been moved from the pervasive library.
#
# Revision 1.15  1995/05/10  18:13:12  daveb
# Added new files to the initial basis.
#
# Revision 1.14  1995/05/04  12:49:10  jont
# Add pervasive object files in architecture specific place
# Also add initial basis and xm library
#
# Revision 1.13  1995/05/03  11:09:25  jont
# Ensure ARCH and OS passed to emacs/etc make
#
# Revision 1.12  1995/02/24  17:01:19  jont
# Make image building for distribution OS and architecture specific
#
# Revision 1.11  1995/02/24  15:57:17  jont
# Modify for new /u directory structure
#
# Revision 1.10  1994/08/15  10:51:26  daveb
# Updated distribution command for new runtime organisation.
#
# Revision 1.9  1994/04/07  14:47:31  daveb
# Now removes DISTDIR/edlib before copying new edlib.
#
# Revision 1.8  1994/03/01  15:07:54  daveb
# Moving edlib source out of MLW directory.
#
# Revision 1.7  1994/03/01  14:44:01  daveb
# Added Edinburgh Library to distribution.
#
# Revision 1.6  1994/01/28  18:32:18  daveb
# Changed the src directory, instead of the root directory.  Ho hum.
#
# Revision 1.5  1994/01/28  17:34:33  daveb
# Changed location of src directory.
#
# Revision 1.4  1993/09/28  10:53:22  daveb
# Merged in bug fix.
#
# Revision 1.3.1.2  1993/09/27  18:42:21  daveb
# Ensure that target directory exists.  Added Makefiles for emacs/lisp &
# app-defaults directories.  Copy across pervasive .mo files, and finally
# create a MANIFEST.
#
# Revision 1.3.1.1  1993/09/01  15:46:11  jont
# Fork for bug fixing
#
# Revision 1.3  1993/09/01  15:46:11  jont
# Ensured scripts and man copied into distribution
#
# Revision 1.2  1993/08/12  14:32:43  jont
# Changed to remove lib/emacs/lisp/*.el before copying to avoid errors
#
# Revision 1.1  1993/05/12  14:40:55  richard
# Initial revision
#

chmod_exec=chmod 775
chmod_non_exec=chmod 664
chmod_read_only=chmod 444
remove_log	= ../tools/remove_log.sh

ifeq "$(OS)" "NT"
NTTYPE=TRUE
else
ifeq "$(OS)" "Win95"
NTTYPE=TRUE
else
NTTYPE=FALSE
endif
endif
SML_HOME	= /u/sml
ifeq "$(NTTYPE)" "TRUE"
SRC		= $(SML_HOME)/MLW/src
DISTDIR		= $(SML_HOME)/distribution
COUTALL		= $(SML_HOME)/tools/coutall
RM		= rm -rf
CP		= cp -p
TOUCH		= touch
MKDIR		= mkdir -p
PLATFORM	= Win32
else
SRC		= $(SML_HOME)/MLW/src
DISTDIR		= $(SML_HOME)/distribution
COUTALL		= $(SML_HOME)/tools/coutall
RM		= /bin/rm -rf
CP		= /bin/cp -p
LN		= /bin/ln
MKDIR		= /bin/mkdir
FIND		= /bin/find
TOUCH		= /bin/touch
PLATFORM	= Unix
endif

TERMINAL =      utils/terminal \
                utils/__terminal

XM = 		$(TERMINAL) motif/xm \
		motif/_xm \
		motif/__xm

WIN = 		$(TERMINAL) winsys/windows_gui \
		winsys/_windows_gui \
		winsys/__windows_gui

XMMO =		$(XM:%=%.mo)
XMSML =		$(XM:%=%.sml)
WINMO =		$(WIN:%=%.mo)
WINSML =	$(WIN:%=%.sml)

UTILS = 	utils/mutex \
		utils/__mutex

UTILSMO =	$(UTILS:%=%.mo)
UTILSML =	$(UTILS:%=%.sml)

ifeq "$(NTTYPE)" "TRUE"
FOREIGN_EG =	foreign/registry_spec.sml
else
FOREIGN_EG =    foreign/ndbm_fi_spec.sml
endif

FOREIGN = 	$(FOREIGN_EG) foreign/stub_gen.sml \
		foreign/__stub_gen_input.sml \
		foreign/mlworks_c_pointer.sml \
		foreign/mlworks_c_interface.sml \
		foreign/mlworks_c_resource.sml \
		foreign/mlworks_dynamic_library.sml \
		foreign/mlworks_c_io.sml

all:
	@echo Make all does nothing here

check-out:
	cd .. && $(COUTALL)

distribution: $(DISTDIR)/touch

$(DISTDIR)/touch:
ifdef OS
ifdef ARCH
	-$(MKDIR) $(DISTDIR) $(DISTDIR)/objects $(DISTDIR)/objects/$(ARCH) $(DISTDIR)/objects/$(ARCH)/$(OS) $(DISTDIR)/objects/$(ARCH)/$(OS)/DEPEND $(DISTDIR)/objects/$(ARCH)/$(OS)/Release
	-$(chmod_exec) $(DISTDIR)
	(cd rts && $(MAKE) -e ARCH=$(ARCH) OS=$(OS) DISTDIR=$(DISTDIR) distribution)
	(cd images && cd $(ARCH) && cd $(OS) && $(MAKE) DISTDIR=$(DISTDIR) OS=$(OS) ARCH=$(ARCH) distribution basis-files foreign-files)
ifeq "$(NTTYPE)" "TRUE"
else
	(cd emacs/etc && $(MAKE) ARCH=$(ARCH) OS=$(OS) DISTDIR=$(DISTDIR) distribution)
	(cd emacs/lisp && $(MAKE) DISTDIR=$(DISTDIR) distribution)
	(cd app-defaults && $(MAKE) DISTDIR=$(DISTDIR) distribution)
endif
	(cd .. && cd demo && $(MAKE) DISTDIR=$(DISTDIR) OS=$(OS) ARCH=$(ARCH) distribution)
	(cd scripts && $(MAKE) DISTDIR=$(DISTDIR) OS=$(OS) ARCH=$(ARCH) distribution)
	cd $(DISTDIR) && $(RM) pervasive/$(ARCH)/$(OS)
	-$(MKDIR) $(DISTDIR)/pervasive $(DISTDIR)/pervasive/$(ARCH) $(DISTDIR)/pervasive/$(ARCH)/$(OS) $(DISTDIR)/pervasive/$(ARCH)/$(OS)/DEPEND 
	-$(chmod_exec) $(DISTDIR)/pervasive $(DISTDIR)/pervasive/$(ARCH) $(DISTDIR)/pervasive/$(ARCH)/$(OS)
	for x in __pervasive_library __builtin_library; do $(CP) pervasive/$$x.mo $(DISTDIR)/pervasive/$(ARCH)/$(OS)/$$x.mo; $(CP) pervasive/DEPEND/$$x.sml $(DISTDIR)/pervasive/$(ARCH)/$(OS)/DEPEND/$$x.sml; done
	cd $(DISTDIR) && $(RM) basis foreign
ifeq "$(NTTYPE)" "TRUE"
	cd $(DISTDIR) && $(RM) winsys
	cd $(DISTDIR) && $(RM) win_nt/$(ARCH)/$(OS)
	cd $(DISTDIR) && $(RM) mswindows/$(ARCH)/$(OS)
else
	$(RM) $(DISTDIR)/motif/$(ARCH)/$(OS)
	$(RM) $(DISTDIR)/unix/$(ARCH)/$(OS)
	$(RM) $(DISTDIR)/motif/*.sml
endif
	cd $(DISTDIR) && $(RM) utils/$(ARCH)/$(OS)
	-$(MKDIR) $(DISTDIR)/basis $(DISTDIR)/basis/$(ARCH) $(DISTDIR)/basis/$(ARCH)/$(OS)
	-$(chmod_exec) $(DISTDIR)/basis $(DISTDIR)/basis/$(ARCH) $(DISTDIR)/basis/$(ARCH)/$(OS)
	-$(MKDIR) $(DISTDIR)/foreign $(DISTDIR)/examples/foreign
	-$(MKDIR) $(DISTDIR)/utils $(DISTDIR)/utils/$(ARCH) $(DISTDIR)/utils/$(ARCH)/$(OS)
	-$(chmod_exec) $(DISTDIR)/utils $(DISTDIR)/utils/$(ARCH) $(DISTDIR)/utils/$(ARCH)/$(OS)
	-$(chmod_exec) $(DISTDIR)/foreign $(DISTDIR)/examples/foreign
ifeq "$(NTTYPE)" "TRUE"
	-$(MKDIR) $(DISTDIR)/winsys $(DISTDIR)/winsys/$(ARCH) $(DISTDIR)/winsys/$(ARCH)/$(OS)
	-$(chmod_exec) $(DISTDIR)/winsys $(DISTDIR)/winsys/$(ARCH) $(DISTDIR)/winsys/$(ARCH)/$(OS)
else
	-$(MKDIR) $(DISTDIR)/motif $(DISTDIR)/motif/$(ARCH) $(DISTDIR)/motif/$(ARCH)/$(OS)
	-$(chmod_exec) $(DISTDIR)/motif $(DISTDIR)/motif/$(ARCH) $(DISTDIR)/motif/$(ARCH)/$(OS)
endif
	(cd scripts && $(CP) basis-inst.mlp $(DISTDIR)/basis/basis.mlp)
ifeq "$(NTTYPE)" "TRUE"
	for x in $(WINSML); do $(CP) mswindows/objects/$(ARCH_OS)/DEPEND/`basename $$x` $(DISTDIR)/objects/$(ARCH)/$(OS)/DEPEND/`basename $$x`; done
	for x in $(WINMO); do $(CP) mswindows/objects/$(ARCH_OS)/Release/`basename $$x` $(DISTDIR)/objects/$(ARCH)/$(OS)/Release/`basename $$x`; done
	for x in mswindows/windows_gui.sml; do ../tools/add_copyright.sh $$x > $(DISTDIR)/winsys/`basename $$x`; done
	for x in mswindows/windows_gui.sml; do $(TOUCH) -r $$x $(DISTDIR)/winsys/`basename $$x`; done
	$(CP) scripts/mswindows-gui.mlp $(DISTDIR)/winsys/gui.mlp
else
	for x in $(XMSML); do $(CP) motif/objects/$(ARCH_OS)/DEPEND/`basename $$x` $(DISTDIR)/objects/$(ARCH)/$(OS)/DEPEND/`basename $$x`; done
	for x in $(XMMO); do $(CP) motif/objects/$(ARCH_OS)/Release/`basename $$x` $(DISTDIR)/objects/$(ARCH)/$(OS)/Release/`basename $$x`; done
	for x in motif/xm.sml; do ../tools/add_copyright.sh $$x > $(DISTDIR)/motif/`basename $$x`; done
	for x in motif/xm.sml; do $(TOUCH) -r $$x $(DISTDIR)/motif/`basename $$x`; done
	$(CP) scripts/motif-gui.mlp $(DISTDIR)/motif/gui.mlp
endif
	perl -pe "s?../../../??g;print;" images/$(ARCH_OS)/basis-files > poo
	for x in `cat poo`; do $(CP) $$x $(DISTDIR)/objects/$(ARCH)/$(OS)/Release/`basename $$x`; done
	for x in basis/[a-z]*.sml; do ../tools/add_copyright.sh $$x > $(DISTDIR)/basis/`basename $$x`; done
	for x in basis/[a-z]*.sml; do $(TOUCH) -r $$x $(DISTDIR)/basis/`basename $$x`; done
	perl -pe "s?../../../../objects/$(ARCH_OS)/Release/??g;print;" images/$(ARCH_OS)/basis-files > poo
	perl -pe "s?\.mo?\.sml?g;print;" poo > poo1
	for x in `cat poo1`; do $(CP) ../objects/$(ARCH_OS)/DEPEND/$$x $(DISTDIR)/objects/$(ARCH)/$(OS)/DEPEND/$$x; done

	for x in $(UTILSML); do $(CP) utils/objects/$(ARCH_OS)/DEPEND/`basename $$x` $(DISTDIR)/objects/$(ARCH)/$(OS)/DEPEND/`basename $$x`; done
	for x in $(UTILSMO); do $(CP) utils/objects/$(ARCH_OS)/Release/`basename $$x` $(DISTDIR)/objects/$(ARCH)/$(OS)/Release/`basename $$x`; done
	for x in utils/mutex.sml; do ../tools/add_copyright.sh $$x > $(DISTDIR)/utils/`basename $$x`; done
	for x in utils/mutex.sml; do $(TOUCH) -r $$x $(DISTDIR)/utils/`basename $$x`; done

	for x in $(FOREIGN); do ../tools/add_copyright.sh $$x > $(DISTDIR)/foreign/`basename $$x`; done
	for x in $(FOREIGN); do $(TOUCH) -r $$x $(DISTDIR)/foreign/`basename $$x`; done
	$(CP) rts/src/mlw_ci.h $(DISTDIR)/foreign/mlw_ci.h

	perl -pe "s?../../../../objects/$(ARCH_OS)/Release/??g;print;" images/$(ARCH_OS)/foreign-files > poo
	perl -pe "s?\.mo?\.sml?g;print;" poo > poo1
	for x in `cat poo1`; do $(CP) ../objects/$(ARCH_OS)/DEPEND/$$x $(DISTDIR)/objects/$(ARCH)/$(OS)/DEPEND/$$x; done

	(cd ../demo/foreign && sh dist_foreign_files.sh $(DISTDIR)/examples/foreign $(OS) $(ARCH))
	(cd scripts && sh make_foreign_mlp.sh $(DISTDIR) $(ARCH_OS))
	perl -pe "s?../../../??g;print" images/$(ARCH)/$(OS)/foreign-files > poo
	for x in `cat poo`; do $(CP) $$x $(DISTDIR)/objects/$(ARCH)/$(OS)/Release/`basename $$x`; done

	-$(RM) poo
	-$(RM) poo1
ifeq "$(NTTYPE)" "TRUE"
	cp ../tools/setup.rul ../tools/setup.lst $(DISTDIR)
else
	-$(RM) $(DISTDIR)/MANIFEST
	(cd $(DISTDIR) && ls -lR > /tmp/MANIFEST && mv /tmp/MANIFEST $(DISTDIR) && $(chmod_read_only) $(DISTDIR)/MANIFEST)
endif
	$(chmod_exec) $(DISTDIR)/bin $(DISTDIR)/bin/$(ARCH) $(DISTDIR)/bin/$(ARCH)/$(OS)
	$(chmod_exec) $(DISTDIR)/images $(DISTDIR)/images/$(ARCH) $(DISTDIR)/images/$(ARCH)/$(OS)
	$(chmod_exec) $(DISTDIR)/scripts
	$(chmod_read_only) $(DISTDIR)/basis/*.sml 
	$(chmod_read_only) $(DISTDIR)/foreign/*.sml

	$(chmod_read_only) $(DISTDIR)/pervasive/$(ARCH)/$(OS)/*.mo
	$(chmod_read_only) $(DISTDIR)/utils/*.sml 
	$(chmod_read_only) $(DISTDIR)/images/$(ARCH)/$(OS)/*
	$(chmod_read_only) $(DISTDIR)/objects/$(ARCH)/$(OS)/Release/*.mo
ifeq "$(NTTYPE)" "TRUE"
	$(chmod_read_only) $(DISTDIR)/winsys/*.sml 
	$(chmod_exec) $(DISTDIR)/setup.rul $(DISTDIR)/setup.lst
else
	$(chmod_exec) $(DISTDIR)/env
	$(chmod_exec) $(DISTDIR)/man $(DISTDIR)/man/man1
	$(chmod_exec) $(DISTDIR)/lib $(DISTDIR)/lib/emacs $(DISTDIR)/lib/emacs $(DISTDIR)/lib/emacs/etc $(DISTDIR)/lib/emacs/lisp $(DISTDIR)/lib/emacs/etc/$(ARCH) $(DISTDIR)/lib/emacs/etc/$(ARCH)/$(OS) $(DISTDIR)/lib/emacs/etc/$(ARCH)/$(OS)/*
	$(chmod_exec) $(DISTDIR)/lib/X11 $(DISTDIR)/lib/X11/app-defaults $(DISTDIR)/lib/X11/bitmaps
	$(chmod_read_only) $(DISTDIR)/lib/X11/app-defaults/*  $(DISTDIR)/lib/X11/bitmaps/*
	$(chmod_read_only) $(DISTDIR)/motif/*.sml 
	$(chmod_read_only) $(DISTDIR)/lib/emacs/lisp/*
endif
else
	@echo Cannot make distribution, ARCH not set
	exit 1
endif
else
	@echo Cannot make distribution, OS not set
	exit 1
endif

force:
