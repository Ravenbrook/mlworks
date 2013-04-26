(*
 *
 * $Log: __hashtable.sml,v $
 * Revision 1.1  1996/02/26 12:06:26  jont
 * new unit
 * Renamed from newhashtable
 *
 * Revision 1.2  1993/12/09  19:44:56  jont
 * Added copyright message
 *
 * Copyright (c) 1993 Harlequin Ltd.
 *)

require "__crash";
require "__lists";

require "_hashtable";

structure HashTable_ = 
  HashTable(
     structure Crash = Crash_
     structure Lists = Lists_)
