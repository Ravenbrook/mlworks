(*
Result: OK
 
 * $Log: ref2.sml,v $
 * Revision 1.4  1996/11/01 11:45:11  io
 * [Bug #1614]
 * [Bug #1614]
 * basifying MLWorks.String
 *
 * Revision 1.3  1996/05/01  17:40:50  jont
 * Fixing up after changes to toplevel visible string and io stuff
 *
 * Revision 1.2  1993/01/20  13:02:17  daveb
 * Added header.
 *
 * Copyright (c) 1992 Harlequin Ltd.
 *)


val t = ref [] : char list ref

fun g (x,y) = 
  if x = 0 then y 
  else 
    let
      val _ = t := explode y 
    in
      g(x-1,y) 
    end

val _ = g(10000, "abcdef");
