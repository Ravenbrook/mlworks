(* _identprint.sml the functor *)
(*
$Log: _identprint.sml,v $
Revision 1.20  1996/10/09 11:52:06  io
moving String from toplevel

 * Revision 1.19  1996/06/04  11:00:40  jont
 * Add unbound flexible structure and tycon error messages
 *
 * Revision 1.18  1996/04/30  15:06:53  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.17  1995/09/12  12:24:45  daveb
 * Added "word literal" case to printTyvar.
 *
Revision 1.16  1995/07/24  15:52:03  jont
Add WORD SCon

Revision 1.15  1995/07/19  10:20:54  jont
Add ident.CHAR to printing of SCons

Revision 1.14  1995/02/17  11:42:34  daveb
Changed printing of overloading literal tyvars.

Revision 1.13  1995/02/06  15:53:40  matthew
Adding unbound value message functions

Revision 1.12  1994/02/21  17:07:24  nosa
TYCON' for type function functions in lambda code for Modules Debugger.

Revision 1.11  1994/02/14  16:18:13  nickh
Moved convert_string to MLWorks.String.ml_string.

Revision 1.10  1993/11/26  15:10:39  matthew
Changed printSCon of string to escape characters rather than just
printing the string.  This should really use a library function convert_string

Revision 1.9  1993/03/03  18:29:03  matthew
Options & Info changes

Revision 1.8  1993/02/01  14:50:20  matthew
Added sharing constraint.

Revision 1.7  1992/12/17  16:36:41  matthew
Changed int and real scons to carry a location around

Revision 1.6  1992/11/25  18:53:16  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.5  1992/09/16  08:36:23  daveb
Renamed include_class to show_id_class and added it to the signature.

Revision 1.4  1992/01/22  19:30:14  jont
Added require "ident" which was missing

Revision 1.3  1991/11/21  15:56:50  jont
Added copyright message

Revision 1.2  91/07/23  15:16:12  davida
Altered to print class of ValIds.

Revision 1.1  91/06/07  10:55:34  colin
Initial revision

Copyright (c) 1991 Harlequin Ltd.
*)
require "../main/options";
require "ident";
require "identprint";

functor IdentPrint (
  structure Ident : IDENT
  structure Options  : OPTIONS
                    ) : IDENTPRINT =
  struct
    structure Ident = Ident
    structure Options = Options

    val name = Ident.Symbol.symbol_name

    fun appclass show_id_class c s =
      if show_id_class then (name s) ^ " <" ^ c ^ ">" else (name s)
			   
    fun printValId' show_id_class (Ident.VAR sym) =
	  appclass show_id_class "VAR" sym
      | printValId' show_id_class (Ident.CON sym) =
	  appclass show_id_class "CON" sym
      | printValId' show_id_class (Ident.EXCON sym) =
	  appclass show_id_class "EXCON" sym
      | printValId' show_id_class (Ident.TYCON' sym) =
	  appclass show_id_class "TYCON'" sym

    fun debug_printValId id = printValId' true id

    fun printValId (Options.PRINTOPTIONS options) id =
	  printValId' (#show_id_class options) id

    fun printTyVar (Ident.TYVAR(sym,_,_)) =
      case name sym
      of "int literal" => "int"
      |  "word literal" => "word"
      |  "real literal" => "real"
      |  "wordint" => "int_or_word"
      |  "realint" => "real_or_int"
      |  "num" => "num"
      |  "numtext" => "text_or_num"
      |  str => str

    fun printTyCon (Ident.TYCON sym) = name sym
    fun printLab   (Ident.LAB   sym) = name sym
    fun printStrId (Ident.STRID sym) = name sym
    fun printSigId (Ident.SIGID sym) = name sym
    fun printFunId (Ident.FUNID sym) = name sym

    local 
      val follow = 
	Ident.followPath (fn (strid,string) =>
			  string ^ (printStrId strid) ^ ".")
    in
      fun printPath path = follow (path,"")
    end

    fun printLongValId options (Ident.LONGVALID (path,valid)) =
      printPath path ^ printValId options valid

    fun printLongTyCon (Ident.LONGTYCON (path,tycon)) =
      printPath path ^ printTyCon tycon
 
   fun printLongStrId (Ident.LONGSTRID (path,strid)) =
      printPath path ^ printStrId strid

   (* This should get maximums string size from options *)
   fun printSCon (Ident.INT (x,_)) = x
     | printSCon (Ident.REAL (x,_)) = x
     | printSCon (Ident.STRING x) =
       "\"" ^ MLWorks.String.ml_string(x,20) ^ "\""
     | printSCon (Ident.CHAR x) =
       "#\"" ^ MLWorks.String.ml_string(x,20) ^ "\""
     | printSCon(Ident.WORD (x, _)) = x

   fun valid_unbound_strid_message (strid,lvalid,print_options) =
      concat ["Unbound structure ", printStrId strid, " in ",
               printLongValId print_options lvalid]

   fun tycon_unbound_strid_message (strid,ltycon) =
      concat ["Unbound structure ", printStrId strid, " in ",
               printLongTyCon ltycon]

   fun tycon_unbound_flex_strid_message (strid,ltycon) =
      concat ["Unbound flexible structure ", printStrId strid, " in ",
               printLongTyCon ltycon]

   fun strid_unbound_strid_message (strid,lstrid,print_options) =
     concat (["Unbound structure ",printStrId strid] @
              (case lstrid of 
                 Ident.LONGSTRID (Ident.NOPATH,_) => []
               | _ => [" in ", printLongStrId lstrid]))

   fun unbound_longvalid_message (valid,lvalid,class,print_options) =
     let
       val message = ["Unbound ", class, " ", printValId print_options valid]
     in
       case lvalid of
         Ident.LONGVALID (Ident.NOPATH,_) =>
           concat message
       | _ => concat (message @ [" in ", printLongValId print_options lvalid])
     end

   fun unbound_lt_message message =
     fn (tycon, ltycon) =>
     let
       val message = [message, printTyCon tycon]
     in
       case ltycon of
         Ident.LONGTYCON (Ident.NOPATH,_) =>
           concat message
       | _ => concat (message @ [" in ", printLongTyCon ltycon])
     end

   val unbound_longtycon_message = unbound_lt_message "Unbound type constructor "

   val unbound_flex_longtycon_message = unbound_lt_message "Unbound flexible type constructor "
  end
