#!/bin/sh
#
# Copyright 1999 The Harlequin Group Limited.  All rights reserved.
#
# Make distributed foreign project file from developer project file.
#
# Revision Log
# ------------
# $Log: make_foreign_mlp.sh,v $
# Revision 1.2  1999/03/17 17:31:08  johnh
# [Bug #190529]
# Create stub generator project for users too.
#
# Revision 1.1  1999/03/12  11:38:51  johnh
# new unit
# [Bug #190506]
# build foreign mlp for distribution from developer foreign mlp.
#
#

# $DISTDIR and $ARCH/$OS must be set on the command line to the shell script

DISTDIR=${1:-/u/sml/distribution}
ARCH_OS=${2:-SPARC/Solaris}

DISTRIB_DIR=`echo $DISTDIR | sed -e "s%//\(.\)%\1:%"`
FOREIGN_MLP=$DISTRIB_DIR/foreign/foreign.mlp
STUB_GEN_MLP=$DISTRIB_DIR/foreign/stub_gen.mlp
BASIS_MLP=$DISTRIB_DIR/basis/basis.mlp
OBJECTS=$DISTRIB_DIR/objects

echo "Making foreign projects: $FOREIGN_MLP and $STUB_GEN_MLP"

CHANGE_FOREIGN_MLP="(Shell.Project.openProject \"../foreign/foreign.mlp\"; \
		    app Shell.Project.removeConfiguration 
			(Shell.Project.showAllConfigurations()); \
		    Shell.Project.setSubprojects []; \
		    Shell.Project.setLocations {binariesLoc=\"\", \
					       objectsLoc=\"\",
					       libraryPath=[]}; \
		    Shell.Project.saveProjectAs \"$FOREIGN_MLP\"; \
		    Shell.Project.setSubprojects [\"../basis/basis.mlp\"]; \
		    Shell.Project.setLocations {binariesLoc=\"\", \
					        objectsLoc=\"../objects\", \
						libraryPath=[]}; \
		    Shell.Project.saveProject()) \
		    handle Shell.Project.ProjectError s => print s; \
		    (Shell.Project.openProject \"../foreign/stub_gen.mlp\"; \
		    app Shell.Project.removeConfiguration 
			(Shell.Project.showAllConfigurations()); \
		    Shell.Project.setSubprojects []; \
		    Shell.Project.setLocations {binariesLoc=\"\", \
					       objectsLoc=\"\",
					       libraryPath=[]}; \
		    Shell.Project.saveProjectAs \"$STUB_GEN_MLP\"; \
		    Shell.Project.setSubprojects [\"../basis/basis.mlp\", \"foreign.mlp\"]; \
		    Shell.Project.setLocations {binariesLoc=\"\", \
					       objectsLoc=\"../objects\",
					       libraryPath=[]}; \
		    Shell.Project.saveProject()) \
		    handle Shell.Project.ProjectError s => print s; "

echo $CHANGE_FOREIGN_MLP |
../rts/bin/$ARCH_OS/main -MLWpass a -load ../images/$ARCH_OS/guib.img a -silent -no-banner -no-init -tty


