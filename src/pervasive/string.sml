(*
 * The strings library.
 *
 * Copyright (c) 1992 Harlequin Ltd.
 *
 * $Log: string.sml,v $
 * Revision 1.5  1996/05/21 12:02:43  matthew
 * Adding maxLen
 *
 * Revision 1.4  1996/04/30  12:14:13  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.3  1995/03/20  10:45:18  matthew
 * Adding implode_char function
 *
 *  Revision 1.2  1994/02/08  10:55:06  nickh
 *  Added ml_string().
 *
 *  Revision 1.1  1992/08/07  10:42:29  davidt
 *  Initial revision
 *
 *
 *)

signature STRING = 
  sig 
    exception Substring
    exception Chr
    exception Ord
    val maxLen : int
    val explode : string -> string list
    val implode : string list -> string
    val chr : int -> string
    val ord : string -> int
    val substring : string * int * int -> string
    val <  : string * string -> bool
    val >  : string * string -> bool
    val <= : string * string -> bool
    val >= : string * string -> bool
    val ordof : string * int -> int

    val ml_string : string * int -> string

    val implode_char : int list -> string

  end;
