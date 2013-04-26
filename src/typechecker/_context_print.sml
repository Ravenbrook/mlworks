(* _context_print.sml the functor *)
(*
$Log: _context_print.sml,v $
Revision 1.14  1999/02/02 16:01:45  mitchell
[Bug #190500]
Remove redundant require statements

 * Revision 1.13  1996/11/06  11:32:58  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.12  1996/10/29  12:13:12  io
 * [Bug #1614]
 * basifying String
 *
 * Revision 1.11  1996/09/25  17:31:17  andreww
 * [Bug #1592]
 * threading locations into Absyn.LOCALexp
 *
 * Revision 1.10  1996/04/30  15:49:41  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.9  1996/04/29  14:02:36  matthew
 * Removing MLWorks.Integer.
 *
 * Revision 1.8  1995/09/05  14:10:17  daveb
 * Added new types for different sizes of ints, words and reals.
 *
Revision 1.7  1995/08/31  13:38:32  jont
Add location info to wild pats

Revision 1.6  1995/05/11  13:39:42  matthew
Improving function printing

Revision 1.5  1993/11/25  10:34:12  matthew
General improvements
Print infix expressions & pats.
Print tuple expressions as tuples

Revision 1.4  1993/10/04  16:54:29  daveb
Merged in bug fix.

Revision 1.3  1993/08/12  11:41:13  nosa
Runtime-instance in VALpats and LAYEREDpats and Compilation-instance
in VALexps for polymorphic debugger.

Revision 1.2.1.2  1993/10/04  16:31:42  daveb
Now prints if, while, andalso and orelse as the underived forms.

Revision 1.2.1.1  1993/08/11  15:16:51  jont
Fork for bug fixing

Revision 1.2  1993/08/11  15:16:51  jont
Ensured all pattern types printable

Revision 1.1  1993/08/10  10:44:31  jont
Initial revision

Copyright (c) 1993 Harlequin Ltd.
*)

require "^.basis.__int";
require "^.basis.__string";
require "^.basics.absyn";
require "^.basics.identprint";
require "context_print";

functor Context_Print(
  structure Absyn : ABSYN
  structure IdentPrint : IDENTPRINT
  sharing Absyn.Ident = IdentPrint.Ident
    ) : CONTEXT_PRINT =
  struct
    structure Absyn = Absyn
    structure Ident = Absyn.Ident
    structure Symbol = Ident.Symbol
    structure Options = IdentPrint.Options

    fun get_data (Absyn.FNexp(_,_,data,_)) = data
    |   get_data _ = ""

    val is_if_exp = String.isPrefix "<if>"
    val is_case_exp = String.isPrefix "<case>"
    val is_andalso_exp = String.isPrefix "<andalso>"
    val is_orelse_exp = String.isPrefix "<orelse>"
    val is_while_exp = String.isPrefix "While statement"

    fun is_tuple [] = true
      | is_tuple [_] = false
      | is_tuple l =
        let 
          fun aux ([],n) = true
            | aux ((Ident.LAB s,_)::l,n) =
            (Int.toString n = Symbol.symbol_name s)
            andalso
            aux (l,n+1)
        in
          aux (l,1)
        end

    fun pat_needs_brackets (Absyn.WILDpat _) = false
      | pat_needs_brackets (Absyn.SCONpat _) = false
      | pat_needs_brackets (Absyn.VALpat _) = false
      | pat_needs_brackets (Absyn.RECORDpat _) = false
      | pat_needs_brackets _ = true

    fun lab_list_to_string [] = ["}"]
      | lab_list_to_string [(x, _)] = [IdentPrint.printLab x, "=...}"]
      | lab_list_to_string((x, _) :: xs) =
	IdentPrint.printLab x :: "=..., " :: lab_list_to_string xs

    fun simple_tuple_to_string [] = [")"]
      | simple_tuple_to_string [(x, _)] = ["...)"]
      | simple_tuple_to_string((x, _) :: xs) =
	"..., " :: simple_tuple_to_string xs

    fun simple_pat_to_string options (Absyn.WILDpat _) = "_"
      | simple_pat_to_string options (Absyn.SCONpat (scon, _)) =
        IdentPrint.printSCon scon
      | simple_pat_to_string options (Absyn.VALpat((lvalid, _), _)) =
	IdentPrint.printLongValId options lvalid
      | simple_pat_to_string options (Absyn.RECORDpat(list, _, _)) =
        if is_tuple list
          then
            concat ("(" :: simple_tuple_to_string list)
        else
          (case list of
             [] => "()"
           | _ => concat ("{" :: lab_list_to_string list))
      | simple_pat_to_string options (Absyn.APPpat((lvalid, ref ty), pat,_,is_infix)) =
        if is_infix
          then
            (case pat of
               Absyn.RECORDpat ([(_,p1),(_,p2)],_,_) =>
                 "... " ^ IdentPrint.printLongValId options lvalid ^ " ..."
             | _ => "<Strange infix pattern>")
        else
          IdentPrint.printLongValId options lvalid ^ " ..."
      | simple_pat_to_string options (Absyn.TYPEDpat(pat, _, _)) =
	"_ : type"
      | simple_pat_to_string options (Absyn.LAYEREDpat((valid, _), _)) =
	IdentPrint.printValId options valid ^ " as ..."

    fun lab_pat_list_to_string options [] = ["}"]
      | lab_pat_list_to_string options [(x, pat)] =
	[IdentPrint.printLab x, "=", simple_pat_to_string options pat, "}"]
      | lab_pat_list_to_string options ((x, pat) :: rest) =
	IdentPrint.printLab x :: "=" :: simple_pat_to_string options pat :: ", " ::
	lab_pat_list_to_string options rest

    fun tuple_pat_to_string options [] = [")"]
      | tuple_pat_to_string options [(x, pat)] =
	[simple_pat_to_string options pat, ")"]
      | tuple_pat_to_string options ((x, pat) :: rest) =
	simple_pat_to_string options pat :: ", " ::
	tuple_pat_to_string options rest

    fun pat_to_string options (Absyn.WILDpat _) = "_"
      | pat_to_string options (Absyn.SCONpat (scon, _)) =
	IdentPrint.printSCon scon
      | pat_to_string options (Absyn.VALpat((lvalid, _), _)) =
	IdentPrint.printLongValId options lvalid
      | pat_to_string options (Absyn.RECORDpat(list, _, _)) =
        if is_tuple list
          then
            concat ("(" :: tuple_pat_to_string options list)
        else
          (case list of
             [] => "()"
           | _ => concat ("{" :: lab_pat_list_to_string options list))
      | pat_to_string options (Absyn.APPpat((lvalid, ref ty), pat,_,is_infix)) =
        if is_infix
          then
            (case pat of
               Absyn.RECORDpat ([(_,p1),(_,p2)],_,_) =>
                 simple_pat_to_string options p1 ^ " " ^
                 IdentPrint.printLongValId options lvalid ^ " " ^
                 simple_pat_to_string options p2
             | _ => "<Strange infix pattern>")
        else
          IdentPrint.printLongValId options lvalid ^ 
          (if pat_needs_brackets pat
             then "(" ^ pat_to_string options pat ^ ")"
           else " " ^ pat_to_string options pat)
      | pat_to_string options (Absyn.TYPEDpat(pat, _, _)) =
	simple_pat_to_string options pat ^ " : type"
      | pat_to_string options  (Absyn.LAYEREDpat((valid, _), pat)) =
	IdentPrint.printValId options valid ^ " as " ^ simple_pat_to_string options pat

    fun needs_brackets (Absyn.SCONexp _) = false
      | needs_brackets (Absyn.VALexp _) = false
      | needs_brackets (Absyn.RECORDexp _) = false
      | needs_brackets _ = true;

    fun exp_to_string options (Absyn.SCONexp (scon, _)) = 
	IdentPrint.printSCon scon
      | exp_to_string options (Absyn.VALexp(lvalid, _, _,_)) =
	IdentPrint.printLongValId options lvalid
      | exp_to_string options (Absyn.RECORDexp list) =
        if is_tuple list
          then
            concat ("(" :: tuple_to_string options list)
        else
          (case list of
             [] => "()"
           | _ => concat ("{" :: lab_exp_list_to_string options list))
      | exp_to_string options (Absyn.LOCALexp(_, _,_)) = "let ... in ... end"
        (* This should use the infix field to control printing *)
      | exp_to_string options (Absyn.APPexp(e1, e2, _, _,is_infix)) =
        if is_infix then
          (case (e1,e2) of
             (Absyn.VALexp (lvalid,_,_,_),Absyn.RECORDexp [(_,a1),(_,a2)]) =>
               exp_to_string options a1 ^ " " ^ IdentPrint.printLongValId options lvalid ^ " " ^ exp_to_string options a2
           | _ => "<Strange infix expression>")
        else if is_if_exp (get_data e1) then
	  "if " ^ exp_to_string options e2 ^ " then ... else ..."
	else if is_case_exp (get_data e1) then
	  "case " ^ exp_to_string options e2 ^ " of ..."
	else if is_andalso_exp (get_data e1) then
	  exp_to_string options e2 ^ " andalso ..."
	else if is_orelse_exp (get_data e1) then
	  exp_to_string options e2 ^ " orelse ..."
	else
	  exp_to_string options e1 ^ 
          (if needs_brackets e2 
             then "(" ^ exp_to_string options e2 ^ ")" 
           else " " ^ exp_to_string options e2)
      | exp_to_string options (Absyn.TYPEDexp(e, _, _)) = exp_to_string options e ^ " : type"
      | exp_to_string options (Absyn.HANDLEexp(e, _, _, _, _)) =
	"(" ^ exp_to_string options e ^ ") handle ..." 
      | exp_to_string options (Absyn.RAISEexp _) = "raise ..."
      | exp_to_string options (Absyn.FNexp (pel,_,_,_)) = 
        (case pel of
           (p,e,l) :: _ => "fn " ^ pat_to_string options p ^ " => ..."
         | _ => "fn ... => ...")
      | exp_to_string options (Absyn.DYNAMICexp _) = "dynamic"
      | exp_to_string options (Absyn.COERCEexp _) = "coerce"
      | exp_to_string options (Absyn.MLVALUEexp _) = "(hidden)"

    and lab_exp_list_to_string options [] = ["}"]
      | lab_exp_list_to_string options [(x, y)] =
	IdentPrint.printLab x :: ["=", exp_to_string options y, "}"]
      | lab_exp_list_to_string options ((x, y) :: xs) =
	IdentPrint.printLab x :: "=" :: exp_to_string options y :: ", " ::
	lab_exp_list_to_string options xs

    and tuple_to_string options [] = [")"]
      | tuple_to_string options [(x, y)] =
	[exp_to_string options y, ")"]
      | tuple_to_string options ((x, y) :: xs) =
	exp_to_string options y :: ", " :: tuple_to_string options xs

    fun dec_to_string options (pat, exp) =
      "val " ^ simple_pat_to_string options pat ^ " = " ^ exp_to_string options exp

  end
