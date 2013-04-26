(*  ==== INITIAL BASIS : OPTION signature ====
 *
 *  Copyright (C) 1997 Harlequin Group Limited.  All rights reserved.
 *
 *  Description
 *  -----------
 *  This is part of the extended Initial Basis.
 *
 *  Revision Log
 *  ------------
 *  $Log: option.sml,v $
 *  Revision 1.2  1997/07/21 09:36:03  brucem
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *
 *)

signature OPTION = 
  sig

    datatype 'a option = NONE | SOME of 'a

    exception Option

    val isSome : 'a option -> bool

    val valOf : 'a option -> 'a
    val getOpt : 'a option * 'a -> 'a

    val filter : ('a -> bool) -> 'a -> 'a option

    val map : ('a -> 'b) -> 'a option -> 'b option
    val join : 'a option option -> 'a option
    val mapPartial : ('a -> 'b option) -> ('a option -> 'b option)

    val compose : (('b -> 'c) * ('a -> 'b option)) -> ('a -> 'c option)
    val composePartial :
       (('b -> 'c option) * ('a -> 'b option)) -> ('a -> 'c option)

  end
