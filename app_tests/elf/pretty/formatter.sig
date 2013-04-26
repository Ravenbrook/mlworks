(*
 *
 * $Log: formatter.sig,v $
 * Revision 1.2  1998/06/03 11:50:01  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
(*
% ForML Version 0.6 - 25 January 1993 - er@cs.cmu.edu
%*********************************************************************
{\bf File {\tt formatter.sig} with signature {\tt FORMATTER}.}
%*********************************************************************
*)
signature FORMATTER =
   sig
(*
\subsection{Default values}
These may may be changed by the user.
*)
      val Indent : int ref
      val Blanks : int ref
      val Skip   : int ref

      val Pagewidth     : int ref

      (* flag specifying whether bailouts should occur when page too narrow *)
      val Bailout       : bool ref
      val BailoutIndent : int ref
      val BailoutSpot   : int ref
(*
\subsection{Formats}
*)
      (* The Format datatype *)
      type format


      (* return the minimum/maximum width of a format *)
      val  Width: format -> (int * int)

      (* routines to create a format *)
      (* Note: the xxxx0 functions take extra arguments *)
      val  Break: format
      val  Break0: int -> int -> format     (* blanks, indent *)
      val  String: string -> format
      val  String0: int -> string -> format (* output width *)
      val  Space: format
      val  Spaces: int -> format
      val  Newline: unit -> format
      val  Newlines: int -> format
      val  Newpage: unit -> format
      val  Vbox: format list -> format
      val  Vbox0: int -> int -> format list -> format  (* indent, skip *)
      val  Hbox: format list -> format
      val  Hbox0: int -> format list -> format         (* blanks *)
      val  HVbox: format list -> format
      val  HVbox0: int -> int -> int -> format list -> format  (* blanks, indent, skip *)
      val  HOVbox: format list -> format
      val  HOVbox0: int -> int -> int -> format list -> format (* blanks, indent, skip *)
(*
\subsection{Output routines}
*)
      val  makestring_fmt:        format -> string
      val  print_fmt:             format -> unit

      type fmtstream
      val  open_fmt:              outstream -> fmtstream
      val  close_fmt:             fmtstream -> outstream
      val  output_fmt:            (fmtstream * format) -> unit
      val  file_open_fmt:         string -> ( (unit -> unit) * fmtstream )
      val  with_open_fmt:         string -> (fmtstream -> 'a) -> 'a
   end
