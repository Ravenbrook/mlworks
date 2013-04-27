(* topdecprint.sml the functor *)
(*
$Log: _topdecprint.sml,v $
Revision 1.43  1998/03/03 09:58:39  mitchell
[Bug #70074]
Add depth limit support for signature printing

 * Revision 1.42  1996/11/22  12:06:43  matthew
 * Removing reference to MLWorks.Option
 *
 * Revision 1.41  1996/10/31  15:53:30  io
 * [Bug #1614]
 * removing toplevel String.
 *
 * Revision 1.40  1996/10/29  14:00:17  andreww
 * [Bug #1708]
 * changing syntax of datatype replication.
 *
 * Revision 1.39  1996/10/11  09:29:35  andreww
 * [Bug #1320]
 * Reverse engineering the derived form for type abbreviation.
 * Makes printed signatures much nicer.
 *
 * Revision 1.38  1996/10/04  11:12:27  matthew
 * [Bug #1622]
 * Change to signature absyn
 *
 * Revision 1.37  1996/09/18  13:08:47  andreww
 * [Bug #1577]
 * Adding extra clause for the new abstract syntax for
 * datatype replication in signatures.
 *
 * Revision 1.36  1996/08/05  18:07:39  andreww
 * [Bug #1521]
 * Propagating changes made to typechecker/_types.sml (essentially
 * just passing options rather than print_options).
 *
 * Revision 1.35  1996/04/30  16:43:32  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.34  1996/04/02  16:33:34  matthew
 * Changes to WHEREsigexp
 *
 * Revision 1.33  1996/03/26  16:42:45  matthew
 * Language changes
 *
 * Revision 1.32  1996/01/16  12:47:52  daveb
 * Added location information to Absyn.SIGNATUREtopdec.
 *
Revision 1.31  1995/12/27  12:54:26  jont
Removing Option in favour of MLWorks.Option

Revision 1.30  1995/11/22  09:12:47  daveb
Changed Absyn.REQUIREtopdec to take a string instead of a module_id.

Revision 1.29  1994/02/05  18:10:06  nosa
Debugger structure, and structure recording for Modules Debugger.

Revision 1.28  1993/08/12  16:32:25  daveb
Change to print moduleids.

Revision 1.27  1993/07/08  14:25:29  nosa
structure Option.

Revision 1.26  1993/07/02  17:17:38  daveb
Added field to some topdecs to indicate when signature matching is required
to match an exception against a value specification.

Revision 1.25  1993/05/20  12:43:44  matthew
Added code for abstractions.

Revision 1.24  1993/03/09  12:45:59  matthew
Options & Info changes
Absyn changes

Revision 1.23  1993/02/08  15:39:00  matthew
Removed ref nameset in Absyn.FunBind

Revision 1.22  1992/12/14  18:47:04  jont
Improved format of printing for exception sepcifications in signatures

Revision 1.21  1992/12/10  16:34:43  jont
Modified printing of signatures to look pretty and aligned

Revision 1.20  1992/12/08  19:17:59  jont
Removed a number of duplicated signatures and structures

Revision 1.19  1992/12/02  14:00:04  matthew
Fixed bug in signature printing

Revision 1.18  1992/11/27  10:49:23  daveb
Changes to make show_id_class and show_eq_info part of Info structure
instead of references.

Revision 1.17  1992/10/14  12:06:34  richard
Added location information to the `require' topdec.

Revision 1.16  1992/09/24  11:43:17  richard
Added print_sigexp using Pretty.reduce.

Revision 1.15  1992/09/17  11:16:04  daveb
Fixed bug in printing of datatype specs.

Revision 1.14  1992/09/16  08:40:20  daveb
Improved printing of datatypes and substructures.

Revision 1.13  1992/09/08  18:35:03  matthew
Changes to absyn

Revision 1.12  1992/05/19  15:52:44  clive
Added marks to some of the abstract syntax

Revision 1.11  1992/04/13  14:26:55  clive
First version of the profiler

Revision 1.10  1992/02/14  19:21:26  jont
Removed use of pervasive fold (now done by implode). Removed use of
word require from a pattern (it's a reserved word). Tidied up slightly.

Revision 1.9  1991/12/19  16:50:15  jont
Added printing of REQUIREtopdec

Revision 1.8  91/11/22  17:41:08  jont
Removed opens

Revision 1.7  91/07/23  11:38:54  davida
Altered type-arg printing to conform with tidied version in Absynprint.

Revision 1.6  91/07/23  11:33:54  davida
Added missing require (not my fault, honest!).

Revision 1.5  91/07/23  10:54:43  davida
Added pretty-printing for signature expressions, provisionally.

Revision 1.4  91/07/12  13:25:35  jont
Added some spaces to improve output

Revision 1.3  91/07/11  14:47:03  jont
Minor mods

Revision 1.2  91/07/10  12:51:59  jont
Fixed errors

Revision 1.1  91/07/10  09:33:00  jont
Initial revision

Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright
   notice, this list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

require "../basics/absynprint";
require "../basics/identprint";
require "topdecprint";
require "pretty";

functor TopdecPrint (
  structure Pretty : PRETTY
  structure AbsynPrint : ABSYNPRINT
  structure IdentPrint : IDENTPRINT

  sharing AbsynPrint.Absyn.Ident = IdentPrint.Ident
  sharing AbsynPrint.Options = IdentPrint.Options
  sharing type AbsynPrint.Absyn.options = IdentPrint.Options.options
  sharing type AbsynPrint.Absyn.Type = AbsynPrint.Absyn.Datatypes.Type
) : TOPDECPRINT =
struct

    structure Absyn = AbsynPrint.Absyn;
    structure P     = Pretty;
    structure Options  = IdentPrint.Options
    structure Datatypes = Absyn.Datatypes

    fun print_options (Options.OPTIONS{print_options=p,...}) = p


    (* Pretty Printing of signature specifications:  An Early Attempt!     *)
    (* Ideally, we should have a pretty-printer that provides consistent   *)
    (* breaks which would replace much of the use of newlines (P.nl) here. *)
    (* Also, routines in AbsynPrint should use the pretty printer too, so  *)
    (* that types can be printed nicely.			      	   *)

    fun sigexp_to_prettyT options depth =
      let
	fun sigexp_to_T options (Absyn.OLDsigexp(sigid,_,_)) =
	  P.str (IdentPrint.printSigId sigid)
	  | sigexp_to_T options (Absyn.NEWsigexp(topspec, _)) =
	    if depth > 0
	      then P.blk(0,[P.str "sig",
			    P.blk(2,(fn []=>[] | x => P.nl :: x)
				  (specs_to_prettyT [topspec])),
			    P.nl,
			    P.str "end"])
	    else P.str "sig ... end"
          | sigexp_to_T options (Absyn.WHEREsigexp (sigexp,wherestuff)) =
            P.blk (0, [sigexp_to_T options sigexp,
                       P.str " where "] @ 
                       (where_to_T true (rev wherestuff)))

        and where_to_T _ [] = []           (* never called *)
          | where_to_T is_first ((tyvars,tycon,ty,_)::rest) =
             P.blk(if is_first then 0 else 10,    (* magic number is
                                                     to align "and" with
                                                     "type" *)
                  (if is_first then [P.str "type "]
                   else [P.nl,P.str " and "]) @
                     (plongtypename (tyvars,tycon)) @
                     [P.str " = ",
                      P.str (AbsynPrint.unparseTy 
                                (print_options options) ty)])
              :: (where_to_T false rest)


	and valspec(valid,ty,tyvars) =
	  [P.str "val ",
	   P.str (IdentPrint.printValId (print_options options) valid),
	   P.str " :",
	   P.brk 1,
	   P.blk(4,[P.str (AbsynPrint.unparseTy (print_options options) ty)])]

	and ptypename(tyvars, tycon) =
	  (case tyvars of
	     [] => []
	   | [tv] => [P.str (IdentPrint.printTyVar tv)]
	   | _ => (P.lst ("(",[P.str ",", P.brk 1],")")
		   (map (P.str o IdentPrint.printTyVar) tyvars))) @
	     [P.brk (if tyvars=[] then 0 else 1),
	      P.str (IdentPrint.printTyCon tycon)]

	and plongtypename(tyvars, longtycon) =
	  (case tyvars of
	     [] => []
	   | [tv] => [P.str (IdentPrint.printTyVar tv)]
	   | _ => (P.lst ("(",[P.str ",", P.brk 1],")")
		   (map (P.str o IdentPrint.printTyVar) tyvars))) @
	     [P.brk (if tyvars=[] then 0 else 1),
	      P.str (IdentPrint.printLongTyCon longtycon)]

	and typespec ts = (P.str "type ") :: (ptypename ts)

	and eqtypespec ts = (P.str "eqtype ") :: (ptypename ts)

	and datatypespec(tyvars,tycon,valtys) =
	  let
	    val tycon_str = ptypename (tyvars,tycon)

            fun string_ty NONE = []
              | string_ty (SOME ty) =
                [P.blk(4, [P.str" of ",
                           P.str (AbsynPrint.unparseTy 
                                  (print_options options) ty)])]
            

            fun valty (valid,tyopt,_) =
	      P.blk(2,
		    P.nl ::
		    P.str (IdentPrint.printValId 
                           (print_options options) valid) ::
		    string_ty tyopt)
              
            fun do_contypes[] = []
              | do_contypes[x] = [valty x]
              | do_contypes(x :: xs) =
                P.blk(0, [valty x, P.str" |"]) :: do_contypes xs



	  in (P.str "datatype ") :: tycon_str
	    @ (P.str" =" :: do_contypes valtys)
	  end

        and datareplspec (location,tycon,longtycon,associatedConstructors) =
          let
            val tycon_str = P.str (IdentPrint.printTyCon tycon)
            val longtycon_str = P.str (IdentPrint.printLongTyCon longtycon)
            
                 (* the following simply strips the "-> tyvars tycon"
                    suffix of constructor types and then prints the
                    result *)

            fun string_ty (Datatypes.FUNTYPE(args,_)) =
              Absyn.print_type options args
              | string_ty ty = Absyn.print_type options ty


            fun valty (valid,tyopt,_) =
	      P.blk(2,
		    P.nl ::
		    P.str (IdentPrint.printValId 
                           (print_options options) valid) ::
                    (case tyopt
                       of NONE => []
                        | SOME ty => [P.blk(4, [P.str" of ",
                           P.str (string_ty ty)])]))
              

            fun do_contypes [] = []
              | do_contypes [x] = [valty x]
              | do_contypes(x :: xs) =
                P.blk(0, [valty x, P.str" |"]) :: do_contypes xs

                (* following function attempts to extract all the
                   free tyvars in the replicated datatype. *)

                
            exception noTyvars

            fun tyvars ((_,SOME(Datatypes.FUNTYPE(_,res)),_)::_) =
                            P.str(Absyn.print_type options res)
              | tyvars ((_,NONE,_)::rest) = tyvars rest
              | tyvars _ = raise noTyvars

            val default_str = case (!associatedConstructors)
                                of NONE => longtycon_str
                                 | SOME v => (tyvars v
                                              handle noTyvars => longtycon_str)

          in
           (P.str "datatype "):: [tycon_str] @ 
           (P.str " = datatype ":: [default_str]) @
           (P.str " = " ::
           (do_contypes (case (!associatedConstructors)
                           of NONE => [] (* this case is impossible:
                                            a replicated datatype must
                                            have some associated constructors*)
                            | (SOME v) => v)))
          end

	and exceptionspec(valid, typopt,_) =
	  case typopt of
	    NONE =>
	      [P.str "exception ",
	       P.str (IdentPrint.printValId (print_options options) valid)]
	  | SOME typ =>
	      [P.str "exception ",
	       P.str (IdentPrint.printValId (print_options options) valid),
	       P.str " of",
	       P.brk 1,
	       P.blk(0,[P.str(AbsynPrint.unparseTy 
                              (print_options options) typ)])]

	and structurespec(strid, sigexp) =
	  let val new_depth = depth - 1 
           in [P.str "structure ",
    	       P.str (IdentPrint.printStrId strid),
	       P.str " :",
               if new_depth > 0 then P.nl else P.brk 1,
               P.blk(2, [sigexp_to_prettyT options new_depth sigexp])]
           end

        and sharingspec(Absyn.STRUCTUREshareq strids) =
	  (P.str "sharing ") ::
	  (P.lst ("", [P.brk 1, P.str "= "],"")
	   (map (P.str o IdentPrint.printLongStrId) strids))

	  | sharingspec(Absyn.TYPEshareq tycons) =
	    (P.str "sharing type ") ::
	    (P.lst ("", [P.brk 1, P.str "= "],"")
	     (map (P.str o IdentPrint.printLongTyCon) tycons))

        and localspec(spec1,spec2) =
	  [P.blk (0, [P.str "local",
		      P.blk(2, [P.nl] @
			    (specs_to_prettyT [spec1])),
		      P.nl,
		      P.str "in",
		      P.blk (1, [P.nl] @
			     (specs_to_prettyT [spec2])),
		      P.nl,
		      P.str "end"])]

        and openspec(strids) =
	  (P.str "open ") ::
	  (P.lst ("",[P.brk 1],"")
	   (map (P.str o IdentPrint.printLongStrId) strids))

             (* the following function attempts to reverse engineer
                the derived forms of type abbreviations.  See the
                function do_type_spec in parser/_actionfunctions.sml
                and appendix A (fig 19) of the revised definition *)

	and includespec(Absyn.WHEREsigexp
                        (Absyn.NEWsigexp(Absyn.TYPEspec [ts],_),
                         [(_,_,ty,_)])) =
             P.str "type " :: (ptypename ts) @
             [P.str " = ",
              P.str (AbsynPrint.unparseTy (print_options options) ty)]
                         
          | includespec(Absyn.WHEREsigexp
                        (Absyn.NEWsigexp(Absyn.EQTYPEspec [ts],_),
                         [(_,_,ty,_)])) =
             P.str "eqtype ":: (ptypename ts) @
             [P.str " = ",
              P.str (AbsynPrint.unparseTy (print_options options) ty)]
                         
          | includespec(sigexp) =
           (P.str "include ") :: [sigexp_to_T options sigexp]

	and specs_to_prettyT speclist =
	  let
	    fun addnls [] = []
	      | addnls ([]::ts) = addnls ts
	      | addnls [t] = [P.blk(0,t)]
	      | addnls (t::ts) = (P.blk(0,t)) :: (P.nl) :: (addnls ts)
		
	    fun specs_to_pTl [] = []
	      | specs_to_pTl (spec::rest) =
		let
		  val lines =  case spec of
		    (Absyn.VALspec (sl,_)) => map valspec sl
		  | (Absyn.TYPEspec sl) => map typespec sl
		  | (Absyn.EQTYPEspec sl) => map eqtypespec sl
		  | (Absyn.DATATYPEspec sl) => map datatypespec sl
                  | (Absyn.DATATYPEreplSpec s) => [datareplspec s]
		  | (Absyn.EXCEPTIONspec sl) => map exceptionspec sl
		  | (Absyn.STRUCTUREspec sl) => map structurespec sl
		  | (Absyn.SHARINGspec (spec,sl)) => specs_to_pTl [spec] @ map (sharingspec o #1) sl
		  | (Absyn.LOCALspec specpair) => [localspec specpair]
		  | (Absyn.OPENspec (strs,_)) => [openspec strs]
		  | (Absyn.INCLUDEspec (sigs,_)) => [includespec sigs]
		  | (Absyn.SEQUENCEspec sl) => [specs_to_prettyT sl]
		in
		  lines @ (specs_to_pTl rest)
		end
	  in
	    addnls (specs_to_pTl speclist)
	  end

      in
	sigexp_to_T options
      end

    fun sigexp_to_string options sigexp = 
        let val Options.PRINTOPTIONS{maximum_sig_depth,...} = print_options options 
         in P.string_of_T (sigexp_to_prettyT options maximum_sig_depth sigexp) end

    fun print_sigexp options f (result, indent, sigexp) =
        let val Options.PRINTOPTIONS{maximum_sig_depth,...} = print_options options
         in P.reduce f (result, indent, sigexp_to_prettyT options maximum_sig_depth sigexp) end

    fun strexp_to_string options strexp = 
      case strexp of
        Absyn.NEWstrexp strdec => " struct " ^ strdec_to_string options strdec ^ " end"
      | Absyn.OLDstrexp (longstrid,_,_) => IdentPrint.printLongStrId longstrid
      | Absyn.APPstrexp(funid, strexp, _, _, _) => IdentPrint.printFunId funid ^ "(" ^
          (strexp_to_string options strexp) ^ ")"
      | Absyn.LOCALstrexp(strdec, strexp) => (strdec_to_string options strdec) ^
          (strexp_to_string options strexp)
      | Absyn.CONSTRAINTstrexp (strexp,sigexp,abs,_,_) =>
          strexp_to_string options strexp ^ 
          (if abs then " :> " else " : ") ^
          sigexp_to_string options sigexp

    and strdec_to_string options strdec = case strdec of
      Absyn.DECstrdec ord_dec => AbsynPrint.printDec options ord_dec
    | Absyn.STRUCTUREstrdec struc_dec_list =>
      let
        fun struc_dec_list_to_string [] = ""
          | struc_dec_list_to_string((strid, sigexp_opt, strexp, _, _, _, _) :: tl) =
            "(structure " ^ (IdentPrint.printStrId strid) ^ " : " ^
            (case sigexp_opt of
               NONE => ""
             | SOME (sigexp,abs) => "\n" ^ sigexp_to_string options sigexp) ^ "\n = " ^
               (strexp_to_string options strexp) ^ ")" ^ struc_dec_list_to_string(tl)
      in
        struc_dec_list_to_string struc_dec_list
      end
    | Absyn.ABSTRACTIONstrdec struc_dec_list =>
      let
        fun struc_dec_list_to_string [] = ""
          | struc_dec_list_to_string((strid, sigexp_opt, strexp, _, _, _, _) :: tl) =
            "(abstraction " ^ (IdentPrint.printStrId strid) ^ " : " ^
            (case sigexp_opt of
               NONE => ""
             | SOME (sigexp,e) => "\n" ^ sigexp_to_string options sigexp) ^ "\n = " ^
               (strexp_to_string options strexp) ^ ")" ^ struc_dec_list_to_string(tl)
      in
        struc_dec_list_to_string struc_dec_list
      end
    | Absyn.LOCALstrdec(strdec1, strdec2) =>
        "LOCAL " ^ strdec_to_string options strdec1 ^ "IN " ^ strdec_to_string options (strdec2) ^
        "END"
    | Absyn.SEQUENCEstrdec strdec_list =>
        let
          fun strdec_list_to_string [] = ""
            | strdec_list_to_string(hd :: tl) = strdec_to_string options (hd) ^
              strdec_list_to_string tl
        in
          strdec_list_to_string strdec_list
        end
    fun topdec_to_string options (Absyn.STRDECtopdec (strdec,_)) =
                                           strdec_to_string options strdec
      | topdec_to_string options (Absyn.SIGNATUREtopdec (sigbind_list, _)) =
        let
          val Options.PRINTOPTIONS{maximum_sig_depth,...} = print_options options
          fun print_sig_bind(Absyn.SIGBIND sigblist) =
            let
              fun doublelist (id,bind,_) =
                P.string_of_T
                (P.blk(0,[P.str "signature ",
                          P.str (IdentPrint.printSigId id),
                          P.str " = ",
                          P.nl,
			  P.blk(2, [sigexp_to_prettyT options maximum_sig_depth bind])]))
            in
              concat(map doublelist sigblist)
            end
        in
          concat(map print_sig_bind sigbind_list)
        end

      | topdec_to_string options (Absyn.FUNCTORtopdec (funbind_list,_)) =
        let
          fun print_fun_list [] = "()"
            | print_fun_list((Absyn.FUNBIND head) :: tail) =
              let
                fun print_funbind [] = ";"
                  | print_funbind
		      ((funid, strid, sigexp, strexp, sig_opt, _, _, _, _, _) ::
		 	 rest) =
                    "functor " ^ IdentPrint.printFunId funid ^
                    "(" ^ IdentPrint.printStrId strid ^ ": sig)" ^
                    (case sig_opt of NONE => "" | _ => ": sig") ^ "=" ^
                       (strexp_to_string options strexp) ^
                       (print_funbind rest)
              in
                (print_funbind head) ^ (print_fun_list tail)
              end
        in
          print_fun_list funbind_list
        end
      | topdec_to_string options (Absyn.REQUIREtopdec (x, _)) =
        "require \"" ^ x ^ "\""
  end


