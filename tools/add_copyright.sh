#!/bin/sh
#
# $Log: add_copyright.sh,v $
# Revision 1.4  1997/06/13 13:59:27  daveb
# [Bug #30152]
# Corrected copyright message.
#
# Revision 1.3  1997/04/04  09:46:13  andreww
# [Bug #2021]
# Automatically determine the year field in the copyright string.
#
# Revision 1.2  1996/06/14  12:08:47  jont
# More work on getting this right for NT
#
# Revision 1.1  1996/06/06  11:37:28  jont
# new unit
# For the distribution mechanism only, to add copyright headers to distributed source
#
#
# Copyright (c) 1996 Harlequin Ltd
#
YEAR=`date | sed 's/.* //'`
if [ "$OS" = "Windows_NT" -o "$OS" = "NT" -o "$OS" = "Win95" ]
then
  PATH="$PATH;C:/usr/local/bin";export PATH
else
  SML=/u/sml/MLW; export SML
  PATH=$SML/tools:$PATH; export PATH
fi
if [ $# -ne 1 ]
then
  echo $#
  exit 1
fi
echo "(* $1"
echo " * Copyright (C)" $YEAR "The Harlequin Group Limited.  All rights reserved."
echo " *)"
foo="`dirname $0`"
export foo
if [ "$foo" = "" ]
then
  remove_src_hdr.sh < $1
else
  $foo/remove_src_hdr.sh < $1
fi

