#!/bin/sh
# (Copyright) Harlequin Ltd 1996 (All rights reserved)

remove_src_hdr=../../tools/remove_src_hdr.sh

case $#
in
   4) struct=$1
      sig_name=$2
      struct_name=$3
      filelist=$4
      ;;
   *)
cat - <<\%%%%
Usage : flatten <struct_file> <sig_name> <struct_name> <filelist>

This takes a structure file name <struct_file>, a signature name
<sig_name>, a structure name <struct_name> and a file name <filelist>
which contains a (non-empty) list of source files.  The source files
are used in sequence to produce a single source file containing a
single implementing structure in which all others are syntactically
embedded.  Each source file should contain a single structure at
top-level (i.e. no functors here).

The last file in the file list contains the structure that is opened to
provide the implementation.

Note that the header comment containing source code control
information will be stripped off.

The <struct> argument is used to construct the names for the resulting
structure, the signature file (which must exist) and the output
structure file (which mustn't).  If <struct> = "foo" then these
filenames are:

     - foo.sml    --- signature file

     - __foo.sml  --- structure file

The name of the signature contained inside the signature file is given
by <sig_name> and the name of the implementing structure is given by
<struct_name> - this is qualified by the given signature.

%%%%

     exit 0
     ;;
esac

# Lets get started ...

tmp=%tmp_file%.$$
tmp1=%tmp1_file%.$$
require=%require_file%.$$
header=%header_file%.$$
rm -f $tmp $tmp1 $require $header
> $require

trap 'rm -f $tmp $tmp1 $require $header; exit' 1 2 3 9 15

struct="`basename $struct .sml`"

sig_file=$struct.sml
output=__$struct.sml


if test -f $sig_file
then :
else echo Signature file $sig_file doesnt exist 
     exit 3
fi

if test -f $output
then echo File $output already exists.
     exit 3
fi

if test -f $filelist
then :
else echo File $filelist is not available.
     exit 3
fi

echo Making file $output ...

date=`date`
set `echo $date`
month=$2
day=$3
year=$6

cat - <<%%%% > $header
(*   ==== GENERATED ML SOURCE FILE : $output =====
 *
 *   Generated on $date
 *
 *   (C) The Harlequin Group, $year (All rights reserved)
 *)

%%%%

if test -f $sig_file
then echo "   Inspecting signature file $sig_file ..."
else echo File $i not found ...
     rm -f $tmp $tmp1 $require $header $output
     exit 1
fi

cat - <<%%%% >> $output
require "$struct";
structure $struct_name : $sig_name =
   struct
%%%%

files=`cat $filelist`

for i in $files
do
   if test -f $i
   then echo "   Adding $i ..."
   else echo File $i not found ...
	rm -f $tmp $tmp1 $require $header $output
	exit 1
   fi

   rm -f $tmp $tmp1

   ptmp1=%ptmp1%.$$
   rm -f $ptmp1

   cat $i | $remove_src_hdr | sed -e '/structure/s;:; : ;' > $ptmp1

   awk '
   $1 ~ /structure/ && $3 ~ /\:/ && $5 ~ /\=/ && $6 ~ /[A-Za-z0-9_]*/ {
       printf "a         structure %s = %s\n", $2, $6
       next
   }
   $1 ~ /structure/ && $3 ~ /\:/ && $5 ~ /\=/ {
       printf "astructure %s =\n", $2
       next
   }        
   $1 ~ /require/ && $2 ~ /\"\.\.\/.*/ {
       printf "b%s\n", $0
       next
   }
   $1 ~ /require/ && $2 ~ /\"\^\..*/ {
       printf "b%s\n", $0
       next
   }
   $1 ~ /require/ {
       next
   }
   $0 ~ /^[ ]*$/  {
       next
   }
   { printf "a%s\n", $0 }
   '  $ptmp1 > $tmp
   rm -f $ptmp1


   sed -n -e 's;^a;      ;p' $tmp > $tmp1
   sed -n -e 's;^b;;p' $tmp >> $require
   mv $tmp1 $tmp

   struct_name="`awk '$1 ~ /structure/ {print $2 ; exit}' $tmp`"

   echo     >> $output
   cat $tmp >> $output
done

cat - <<%%%% >> $output
       open $struct_name
    end;
%%%%
rm -f $tmp $tmp1

sed -e 's; [ ]*; ;g' $require | sort | uniq > $tmp
mv $tmp $require

cat $header $require $output > $tmp
rm -f $header $require $output
mv $tmp $output
