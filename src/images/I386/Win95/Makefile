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
# $Id: Makefile,v 1.1 1995/10/20 16:33:42 jont Exp $
#
#
#

include ../NT/Makefile
