# ==== BUILD MLWORKS IMAGES ====
#
# Instructions
# ------------
# This makefile builds images in the usual way, but has extra targets
# called *-files for producing files containing lists of .mo's for use
# with the runtime system `-from' option.  This makes debugging using
# adb possible since adb will not accept the massive command lines
# generated for the normal rules.
#
# To build images from a source tree other than `..' use:
#
#   make SRC='source directory name' target...
#
# To build the file list for the parser relative to /usr/sml, for
# example, use:
#
#   make SRC=/usr/sml parser-files
#
# $Id: Makefile,v 1.7 1998/02/06 14:16:38 johnh Exp $
#
#
#

ARCH_OS = SPARC/Solaris

include ../SunOS/Makefile
