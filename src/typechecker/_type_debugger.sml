(* _type_debugger.sml. Utilities for type checking information *)
(*
* $Log: _type_debugger.sml,v $
* Revision 1.18  1997/05/19 12:58:23  jont
* [Bug #30090]
* Translate output std_out to print
*
 * Revision 1.17  1996/10/29  14:04:53  io
 * [Bug #1614]
 * basifying String
 *
 * Revision 1.16  1996/09/25  17:39:51  andreww
 * [Bug #1592]
 * threading location into Absyn.LOCALexp.
 *
 * Revision 1.15  1996/09/03  17:44:53  andreww
 * [Bug #1577]
 * Adding typechecking rules for datatype replication.
 *
 * Revision 1.14  1996/08/05  16:35:00  andreww
 * [Bug #1521]
 * Propagating changes made to _types.sml
 *
 * Revision 1.13  1996/04/30  16:03:51  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.12  1996/03/28  15:07:44  matthew
 * Absyn changes
 *
 * Revision 1.11  1996/03/25  16:57:49  matthew
 * Change to VALdec
 *
 * Revision 1.10  1995/08/31  13:42:53  jont
 * Add location info to wild pats
 *
Revision 1.9  1994/09/14  12:28:26  matthew
Abstraction of debug information

Revision 1.8  1994/02/21  22:50:06  nosa
Type function, debugger structure, and structure recording for Modules Debugger.

Revision 1.7  1993/12/03  17:10:22  nickh
Remove TYNAME, fix substitution reference, remove old debugging code,
tidy up comments.

Revision 1.6  1993/11/25  09:36:57  matthew
Added absyn annotations

Revision 1.5  1993/08/12  11:43:04  nosa
Runtime-instance in VALpats and LAYEREDpats and Compilation-instance
in VALexps for polymorphic debugger.

Revision 1.4  1993/08/06  14:28:43  matthew
Added location information to matches

Revision 1.3  1993/07/02  16:50:00  daveb
Added field to some topdecs to indicate when signature matching is required
to match an exception against a value specification.

Revision 1.2  1993/05/20  12:46:37  matthew
Added code for abstractions.

Revision 1.1  1993/05/11  11:17:45  matthew
Initial revision

*
* Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
* All rights reserved.
* 
* Redistribution and use in source and binary forms, with or without
* modification, are permitted provided that the following conditions are
* met:
* 
* 1. Redistributions of source code must retain the above copyright
*    notice, this list of conditions and the following disclaimer.
* 
* 2. Redistributions in binary form must reproduce the above copyright
*    notice, this list of conditions and the following disclaimer in the
*    documentation and/or other materials provided with the distribution.
* 
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
* IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
* TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
* PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
* HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
* SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
* TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
* PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
* LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
* NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
* SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*)

require "../utils/lists";
require "../basics/absyn";
require "../basics/identprint";
require "types";

require "type_debugger";

functor TypeDebugger (structure Lists : LISTS
                      structure Types : TYPES
                      structure Absyn : ABSYN
                      structure IdentPrint : IDENTPRINT

                      sharing Types.Options = IdentPrint.Options
                      sharing IdentPrint.Ident = Absyn.Ident
                      sharing type Absyn.Type = Types.Datatypes.Type
                      ) : TYPE_DEBUGGER =
  struct
    structure Ident = Absyn.Ident
    structure Location = Ident.Location
    structure Options = IdentPrint.Options
    structure Absyn = Absyn

    fun gather_vartypes absyn_tree =
      let
        open Absyn
        fun do_id ((Ident.LONGVALID (_,var as Ident.VAR _),ty,loc),acc) =
          (var,ty,loc) :: acc
          | do_id (_,acc) = acc
        fun gather_pat (WILDpat _,acc) = acc
          | gather_pat (SCONpat _, acc) = acc
          | gather_pat (VALpat ((id,(ref ty,_)),loc), acc) =
            do_id ((id,ty,loc),acc)
          | gather_pat (RECORDpat (labpatlist,_,_),acc) =
            Lists.reducel
            (fn (acc,(lab,pat)) => gather_pat(pat,acc))
            (acc,labpatlist)
          | gather_pat (APPpat(id,pat,loc,_),acc) =
            gather_pat (pat,acc)
          | gather_pat (TYPEDpat (pat,ty,loc),acc) =
            gather_pat (pat,acc)
          | gather_pat (LAYEREDpat ((id,(ref ty,_)), pat), acc) =
            gather_pat (pat,(id,ty,Location.UNKNOWN) :: acc)
        fun gather_dec (VALdec (l1,l2,_,_),acc) =
          let
            fun do_one (acc,(pat,exp,_)) = gather_pat (pat,(gather_exp (exp,acc)))
          in
            Lists.reducel do_one (Lists.reducel do_one (acc,l1), l2)
          end
          | gather_dec (TYPEdec _,acc) = acc
          | gather_dec (DATATYPEdec _,acc) = acc
          | gather_dec (DATATYPErepl _,acc) = acc
          | gather_dec (ABSTYPEdec (_,_,dec),acc) = gather_dec(dec,acc)
          | gather_dec (EXCEPTIONdec _,acc) = acc
          | gather_dec (LOCALdec(dec,dec'),acc) =
            gather_dec (dec',gather_dec(dec,acc))
          | gather_dec (OPENdec _, acc) = acc
          | gather_dec (SEQUENCEdec declist,acc) =
            Lists.reducel (fn (acc,dec) => gather_dec(dec,acc)) (acc,declist)
        and gather_exp (SCONexp _,acc) = acc
          | gather_exp (VALexp _,acc) = acc
          | gather_exp (RECORDexp labexplist,acc) =
            Lists.reducel (fn (acc,(lab,exp)) => gather_exp (exp,acc)) (acc,labexplist)
          | gather_exp (LOCALexp (dec,exp,_),acc) =
            gather_exp (exp, gather_dec (dec,acc))
          | gather_exp (APPexp (exp,exp',_,_,_), acc) =
            gather_exp (exp', gather_exp (exp,acc))
          | gather_exp (TYPEDexp (exp,_,_),acc) = gather_exp (exp,acc)
          | gather_exp (HANDLEexp (exp,_,patexplist,_,_),acc) =
            Lists.reducel
            (fn (acc,(pat,exp,_)) => gather_exp(exp,gather_pat(pat,acc)))
            (gather_exp (exp,acc),patexplist)
          | gather_exp (RAISEexp (exp,_),acc) =
            gather_exp (exp,acc)
          | gather_exp (FNexp (patexplist,_,_,_),acc) =
            Lists.reducel
            (fn (acc,(pat,exp,_)) => gather_exp(exp,gather_pat(pat,acc)))
            (acc,patexplist)
          | gather_exp (DYNAMICexp (exp,_,_),acc) =
            gather_exp (exp,acc)
          | gather_exp (COERCEexp (exp,_,_,_),acc) =
            gather_exp (exp,acc)
          | gather_exp (MLVALUEexp _,acc) = acc
        fun gather_strexp (NEWstrexp strdec,acc) = gather_strdec (strdec,acc)
          | gather_strexp (OLDstrexp _,acc) = acc
          | gather_strexp (APPstrexp (_,strexp,_,_,_),acc) = gather_strexp (strexp,acc)
          | gather_strexp (LOCALstrexp(strdec,strexp),acc) =
            gather_strexp (strexp,gather_strdec (strdec,acc))
          | gather_strexp (CONSTRAINTstrexp (strexp,sigexp,abs,_,_),acc) =
            gather_strexp (strexp,acc)
        and gather_strdec (DECstrdec dec,acc) = gather_dec (dec,acc)
          | gather_strdec (STRUCTUREstrdec l,acc) =
            Lists.reducel
            (fn (acc,(_,_,strexp,_,_,_,_)) => gather_strexp (strexp,acc))
            (acc,l)
          | gather_strdec (ABSTRACTIONstrdec l,acc) =
            Lists.reducel
            (fn (acc,(_,_,strexp,_,_,_,_)) => gather_strexp (strexp,acc))
            (acc,l)
          | gather_strdec (LOCALstrdec (strdec,strdec'),acc) =
            gather_strdec (strdec',(gather_strdec (strdec,acc)))
          | gather_strdec (SEQUENCEstrdec l,acc) =
            Lists.reducel (fn (acc,strdec) => gather_strdec(strdec,acc)) (acc,l)
        fun gather_topdec (STRDECtopdec (strdec,_),acc) =
          gather_strdec (strdec,acc)
          | gather_topdec (FUNCTORtopdec (funbind_list,_),acc) =
            Lists.reducel
            (fn (acc,FUNBIND l) =>
             (Lists.reducel
              (fn (acc,(_,_,_,strexp,_,_,_,_,_,_)) =>
               gather_strexp(strexp,acc))
               (acc,l)))
            (acc,funbind_list)
          | gather_topdec (_,acc) = acc
      in
        rev (gather_topdec (absyn_tree,[]))
      end

    fun print_vartypes options l =
      let
        val Options.OPTIONS{print_options,...} = options
        val print_id = IdentPrint.printValId print_options
        val print_type = Types.print_type options
      in
        app
        (fn (id,ty,loc) =>
         print(concat[print_id id,
		      ": ",
		      print_type ty,
		      " [", Location.to_string loc,"]",
		      "\n"]))
        l
      end
  end

