#!/bin/sh
#
# Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
# All rights reserved.
# 
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
# 
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
# IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
# PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
# TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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


