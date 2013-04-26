(* _print.sml the functor *)
(*
$Log: _print.sml,v $
Revision 1.7  1998/02/05 15:25:51  jont
[Bug #30090]
Change to use pervasive print
Later will be removed entirely

 * Revision 1.6  1996/04/30  14:07:42  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.5  1992/08/10  15:34:00  davidt
 * Changed MLworks structure to MLWorks
 *
Revision 1.4  1992/08/07  15:05:38  davidt
Now uses MLworks structure instead of NewJersey structure.

Revision 1.3  1991/11/21  17:02:14  jont
Added copyright message

Revision 1.2  91/10/10  14:19:28  davidt
Changed the print function so that it flushes its output after
every call. This uses NewJersey.flush_out which isn't standard
but is present in the ML Library.

Revision 1.1  91/06/07  15:57:25  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)
require "print";

functor Print () : PRINT = 
  struct
    val print = print
  end
