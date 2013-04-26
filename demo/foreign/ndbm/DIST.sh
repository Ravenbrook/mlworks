#! /bin/sh 
#
# Copy all the user visible files to a new directory
#
# Usage: DIST.sh dist-dir [ OS ARCH ]
#
# Example:
#
#  $ DIST.sh /u/sml/distributions/test/samples/foreign/ndbm
#
# Revision Log
# ------------
# $Log: DIST.sh,v $
# Revision 1.2  1997/07/02 13:52:43  stephenb
# [Bug #30029]
# Removed phones.sml from the list of files to distribute.
#
# Revision 1.1  1997/05/22  13:04:00  stephenb
# new unit
# [Bug #30121]
#

dist_dir=$1
OS=${2:-$OS}
ARCH=${3:-$ARCH}

rm -rf $dist_dir
mkdir $dist_dir

case "$OS" in
  SunOS) flags=SunOS/__open_flags.sml ;;
  *) flags=__open_flags.sml ;;
esac

../../../tools/remove_log.sh < Makefile.${OS} > $dist_dir/Makefile
cat README.txt > $dist_dir/README

for file in __ndbm.sml __ndbm_stub.sml ndbm.sml ndbm_stub.c ndbm_stub.c __phones.sml $flags
do
  ../../../tools/remove_log.sh < $file > $dist_dir/`basename $file`
done

cat phones.dat > $dist_dir/phones.dat
