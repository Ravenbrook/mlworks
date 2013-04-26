(*
 *
 * $Log: __inthashtable.sml,v $
 * Revision 1.1  1994/09/23 14:48:24  matthew
 * new file
 *

 * Copyright (c) 1994 Harlequin Ltd.
 *)

require "__lists";
require "_inthashtable";

structure IntHashTable_ = 
  IntHashTable(structure Lists = Lists_)
