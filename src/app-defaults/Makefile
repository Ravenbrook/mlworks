#
#	==== Makefile for MLWorks X11 files ====
#
# Revision Log
# ------------
# $Log: Makefile,v $
# Revision 1.5  1996/06/03 15:15:12  jont
# Change minidobb.xbm to be mlworks.xbm
#
# Revision 1.4  1996/05/31  10:48:12  jont
# Add MLWorks-icon to list of files distributed
#
# Revision 1.3  1996/01/29  15:32:37  jont
# Add MLWorks-labels resource to list to be put in distribution
#
# Revision 1.2  1995/10/19  14:18:34  daveb
# Added font resource files to the distribution.
#
# Revision 1.1  1993/09/27  18:26:08  daveb
# Initial revision
#


RM	= /bin/rm -f
CP	= /bin/cp -p
MKDIR   = /bin/mkdir
DISTDIR	= /u/sml/distribution

distribution: resources bitmaps

resources: MLWorks-mono MLWorks-color MLWorks-normal-fonts MLWorks-proj-fonts MLWorks-demo-fonts MLWorks-labels
	$(RM) -r $(DISTDIR)/lib/X11/app-defaults
	-$(MKDIR) $(DISTDIR)/lib/X11 $(DISTDIR)/lib/X11/app-defaults
	sed -e 's!/u/sml/MLW/src/app-defaults/\(.*\.xbm\)!$$MLWORKSDIR/lib/X11/bitmaps/\1!g' < MLWorks-mono | \
	sed -e 's!/u/sml/MLW/src/app-defaults/!$$MLWORKSDIR/lib/X11/app-defaults/!g' > $(DISTDIR)/lib/X11/app-defaults/MLWorks-mono.in
	$(CP) MLWorks-color $(DISTDIR)/lib/X11/app-defaults
	$(CP) MLWorks-normal-fonts $(DISTDIR)/lib/X11/app-defaults
	$(CP) MLWorks-demo-fonts $(DISTDIR)/lib/X11/app-defaults
	$(CP) MLWorks-proj-fonts $(DISTDIR)/lib/X11/app-defaults
	$(CP) MLWorks-labels $(DISTDIR)/lib/X11/app-defaults

bitmaps: mlworks.xbm
	$(RM) -r $(DISTDIR)/lib/X11/bitmaps
	-$(MKDIR) $(DISTDIR)/lib/X11 $(DISTDIR)/lib/X11/bitmaps
	$(CP) $< $(DISTDIR)/lib/X11/bitmaps

