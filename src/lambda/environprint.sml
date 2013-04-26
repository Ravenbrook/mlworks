(* environprint.sml the signature *)
(*
$Log: environprint.sml,v $
Revision 1.10  1997/05/22 13:13:46  jont
[Bug #30090]
Replace MLWorks.IO with TextIO where applicable

 * Revision 1.9  1996/04/30  16:13:56  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.8  1993/03/04  12:38:25  matthew
 * Options & Info changes
 *
Revision 1.7  1993/02/01  16:42:31  matthew
Added extra sharing

Revision 1.6  1993/01/05  16:31:32  jont
 Added functions to print directly to a supplied stream

Revision 1.5  1992/11/26  20:35:04  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.4  1991/07/19  16:43:08  davida
New version using custom pretty-printer

Revision 1.3  91/07/12  16:58:30  jont
Added top level environment printing functions

Revision 1.2  91/06/11  16:54:48  jont
Abstracted out the types from the functions

Copyright (c) 1991 Harlequin Ltd.
*)

require "^.basis.__text_io";

require "environtypes";
require "../main/options";

signature ENVIRONPRINT = sig
  structure EnvironTypes : ENVIRONTYPES
  structure Options : OPTIONS

  val stringenv: Options.print_options -> EnvironTypes.Env -> string
  val stringtopenv: Options.print_options -> EnvironTypes.Top_Env -> string
  val printenv: Options.print_options -> EnvironTypes.Env -> TextIO.outstream -> unit
  val printtopenv: Options.print_options -> EnvironTypes.Top_Env -> TextIO.outstream -> unit
end
