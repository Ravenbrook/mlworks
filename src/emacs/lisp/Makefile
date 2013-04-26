#
#	==== Makefile for MLWorks ELisp code ====
#
# Revision Log
# ------------
# $Log: Makefile,v $
# Revision 1.4  1996/11/05 11:16:04  matthew
# Adding new files for new sml-mode
#
# Revision 1.3  1996/02/16  15:23:45  daveb
# Added command to remove mlworks-server.el before creating it anew.
#
# Revision 1.2  1996/02/09  16:46:59  daveb
# Added mlworks-server.el target, which passes the .in file through a sed
# script.  Made the distribution target copy the .in file instead of the .el
# file.
#
# Revision 1.1  1993/09/28  10:33:54  daveb
# Initial revision
#

RM	= /bin/rm -f
CP	= /bin/cp -p
SED	= /bin/sed
MKDIR   = /bin/mkdir
DISTDIR	= /usr/sml/distribution

mlworks-server.el: mlworks-server.el.in
	rm -f mlworks-server.el
	(LIBDIR=`pwd`/../..; export LIBDIR; $(SED) -e "s!\$$LIBDIR!$$LIBDIR!g" < mlworks-server.el.in > mlworks-server.el)

distribution: mlworks-server.el sml-mode.el
	$(RM) -r $(DISTDIR)/lib/emacs/lisp
	- $(MKDIR) $(DISTDIR)/lib $(DISTDIR)/lib/emacs $(DISTDIR)/lib/emacs/lisp
	$(CP) mlworks-server.el.in $(DISTDIR)/lib/emacs/lisp/mlworks-server.el.in
	$(CP) sml-mode.el $(DISTDIR)/lib/emacs/lisp/sml-mode.el.in
	$(CP) sml-mlworks.el $(DISTDIR)/lib/emacs/lisp/sml-mlworks.el.in
	$(CP) sml-font.el $(DISTDIR)/lib/emacs/lisp/sml-font.el.in
	$(CP) sml-hilite.el $(DISTDIR)/lib/emacs/lisp/sml-hilite.el.in
	$(CP) sml-menus.el $(DISTDIR)/lib/emacs/lisp/sml-menus.el.in
	$(CP) sml-mouse.el $(DISTDIR)/lib/emacs/lisp/sml-mouse.el.in
	$(CP) sml-proc.el $(DISTDIR)/lib/emacs/lisp/sml-proc.el.in
	$(CP) README $(DISTDIR)/lib/emacs/lisp/README.in
	$(CP) sml-mode.info $(DISTDIR)/lib/emacs/lisp/sml-mode.info.in

