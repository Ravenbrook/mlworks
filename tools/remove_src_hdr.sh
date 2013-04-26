#!/bin/sh
#
# $Log: remove_src_hdr.sh,v $
# Revision 1.1  1996/06/14 11:13:37  jont
# new unit
#
#
# Copyright (C) Harlequin Ltd 1996 (All rights reserved)

awk 'BEGIN {comment = "first"}
     $1 ~ /\(\*/  {
	if (comment == "first") {
	    comment = "yes"
	    next
	}
     }
     $1 ~ /\*\)/  {
	if (comment == "yes") {
	   comment = "no"
	   next
	}
     }
     comment == "first" { comment = "no" }
     comment != "yes" { print $0 }'
