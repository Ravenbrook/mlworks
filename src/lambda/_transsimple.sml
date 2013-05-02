(*
 * $Log: _transsimple.sml,v $
 * Revision 1.23  1997/05/19 10:59:37  jont
 * [Bug #30090]
 * Translate output std_out to print
 *
 * Revision 1.22  1997/02/13  11:41:57  matthew
 * Fixing bungle with nulltype in last change
 *
 * Revision 1.21  1997/02/12  13:55:17  matthew
 * Removing trans_lamb
 *
 * Revision 1.20  1997/01/10  17:18:08  andreww
 * [Bug #1818]
 * Copying optimizations for bytearray builtins to make
 * optimizations for floatarray builtins.
 *
 * Revision 1.19  1997/01/06  16:39:33  jont
 * [Bug #1633]
 * Add copyright message
 *
 * Revision 1.18  1996/12/18  16:10:49  matthew
 * Removing BUILTINAPP
 *
 * Revision 1.17  1996/10/31  16:31:05  io
 * [Bug #1614]
 * remove ListPair
 *
 * Revision 1.16  1996/10/31  16:08:45  io
 * [Bug #1614]
 * basifying String
 *
 * Revision 1.15  1996/05/07  10:51:38  jont
 * Array moving to MLWorks.Array
 *
 * Revision 1.14  1996/04/30  16:34:08  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.13  1995/09/21  12:13:43  matthew
 * Possibly improving partitioning of mutually recursive function sets.
 *
 * Revision 1.12  1995/09/13  14:43:38  matthew
 * Reducing the size of shared closures.
 *
 * Revision 1.11  1995/09/11  10:52:41  daveb
 * Replaced use of utils.option with MLWorks.Option in lamdatypes.
 *
 * Revision 1.10  1995/09/01  15:00:32  jont
 * Improve bounds checking for array sub and update
 *
 * Revision 1.9  1995/05/10  14:23:42  matthew
 * Change <Builtin O> to <Builtin o>
 *
 * Revision 1.8  1995/04/28  14:23:53  matthew
 * Adding map f l => umap (f,l) transform
 *
 * Revision 1.7  1995/04/27  15:35:00  jont
 * Fix require statements and comments
 *
 * Revision 1.6  1995/02/28  13:10:08  matthew
 * Changes to RuntimeEnv.FunInfo
 *
 * Revision 1.5  1995/01/18  15:42:55  matthew
 * Added some extra transformations to cope with the situation where
 * no optimization is done.
 *
 * Revision 1.4  1995/01/10  10:54:20  matthew
 * Adding strings to VCC_TAG and IMM_TAG
 * Adding MLVALUE
 *
 * Revision 1.3  1994/10/12  10:59:58  matthew
 * Renamed simpletypes to simplelambdatypes
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
require "../utils/crash";
require "../main/pervasives";
require "simpleutils";
require "transsimple";

functor TransSimple ( structure Lists : LISTS
		      structure Crash : CRASH
                      structure SimpleUtils : SIMPLEUTILS
                      structure Pervasives : PERVASIVES

                      sharing type SimpleUtils.LambdaTypes.Primitive = Pervasives.pervasive
                     ) : TRANSSIMPLE =

  struct
    structure LambdaTypes = SimpleUtils.LambdaTypes

    structure Ident = LambdaTypes.Ident
    structure Location = Ident.Location

    structure Array = MLWorks.Internal.Array

    open LambdaTypes

    val do_diag = true
    val diag_level = 1

    fun diag (level,f) = 
      if do_diag andalso level < diag_level then print(f()) else ()

    (* The transformation back from program to expression *)

    fun make_app (e1,e2,ty) =
      APP (e1,([e2],[]),ty)

    fun make_closure_ty ty = NONE

    fun make_builtin_call (b,e,ty) =
      APP (BUILTIN b,([e],[]),ty)

    fun trans_back exp =
      case exp of
        VAR n => VAR n
      | FN stuff => trans_fun stuff
      | LET ((n,info,e1),e2) => LET ((n,info,trans_back e1),trans_back e2)
      | LETREC (fl,el,e) => LETREC (fl,map trans_back el,trans_back e)
      | APP (BUILTIN Pervasives.CALL_C,([e],[]),ty) =>
          APP (BUILTIN Pervasives.CALL_C,([trans_back e],[]),ty)
      | APP (BUILTIN b,([e],[]),ty) => make_builtin_call (b,trans_back e,ty)
      (* back end can only cope with applications of builtins to single arguments *)
      | APP (BUILTIN b,(el,[]),ty) => make_builtin_call (b,STRUCT (map trans_back el,TUPLE),ty)
      | APP (BUILTIN b, (el,_),ty) => Crash.impossible "fp regs in app builtin"
      | APP (f,(el,fpel),ty) => 
          APP (trans_back f,(map trans_back el, map trans_back fpel), ty)
      | SCON scon => SCON scon
      | MLVALUE mlvalue => MLVALUE mlvalue
      | INT i => INT i
      (* The poor wee mir translator can't cope with switches on literals *)
      | SWITCH (INT i,info,tel,opte) =>
          let
            fun find_case ([],NONE) = Crash.impossible "trans_simple: No application case in switch"
              | find_case ([],SOME e) = e
              | find_case ((IMM_TAG (_,j),e)::rest,opte) =
                if i = j then e else find_case (rest,opte)
              | find_case ((tag,e)::rest,opte) =
                find_case (rest,opte)
          in
            trans_back (find_case (tel,opte))
          end
      | SWITCH (e,info,tel,opte) => 
          let
            fun trans_choice (tag,e) =
              let 
                val tag' = 
                  case tag of
                    VCC_TAG i => VCC_TAG i
                  | IMM_TAG i => IMM_TAG i
                  | SCON_TAG scon => SCON_TAG scon
                  | EXP_TAG exp => EXP_TAG (trans_back exp)
              in
                (tag',trans_back e)
              end
            fun trans_opte NONE = NONE
              | trans_opte (SOME e) = SOME (trans_back e)
          in
            SWITCH (trans_back e,
                    info,
                    map trans_choice tel,
                    trans_opte opte)
          end
      | STRUCT (expl,ty) =>
          STRUCT (map trans_back expl, ty)
      | SELECT ({index,size,selecttype},exp) => 
          SELECT ({index = index,
                   size = size,
                   selecttype = selecttype},
                  trans_back exp)
      | RAISE exp => RAISE (trans_back exp)
      | HANDLE (exp1,exp2,s) => HANDLE (trans_back exp1,trans_back exp2,s)
      | BUILTIN b => BUILTIN b
    and trans_fun (args,body,status,name,ty,info) =
      FN (args,trans_back body,status, name,ty,info)
      
    fun make_functor (arg,name,body) = 
      FN (([arg],[]),body,FUNC, name,null_type_annotation,user_funinfo)
    
    fun stuff_body (args,body,status,name,ty,info) = body

    fun trans_decs ([],e) = trans_back e
      | trans_decs ((i,info,VAL (FN stuff)) :: decs,body) =
        trans_fndecs (decs,body,[(i,info,stuff)])
      | trans_decs ((v,info,(VAL e)) :: decs,body) =
        LET ((v,info,trans_back e),trans_decs (decs,body))
      | trans_decs ((v,info,FUNCTOR (x,name,prog)) :: rest, body) =
        LET ((v,info,make_functor (x,name,trans_decs prog)),
                         trans_decs (rest,body))

(* do_funs is the function that converts a list of declarations of functions into a *)
(* suitable LETREC form *)
(* Three versions are offered for your delectation *)
(*
    and do_funs (body,acc) =
      let
        val acc = rev acc
        val ids = map #1 acc
        val infos = map #2 acc
        val bodies = map (trans_fun o #3) acc
      in
        LETREC (Lists.zip (ids,infos),bodies,body)
      end
*)

(*
    (* This needs to partition the functions in acc into mutually recursive sets *)
    (* or if not, use the above *)
    (* or do something really clever *)
    and do_funs (body,funs) =
      let
        (* funs is (id,info,stuff) list and is in reverse order *)
        val ids = map #1 funs
        fun find_forward_references (ids,[],acc) = acc
          | find_forward_references (ids,((id,info,stuff) :: rest),acc) =
            find_forward_references (id::ids,rest,
                                     (id,info,stuff,
                                      SimpleUtils.freevars (stuff_body stuff,id::ids)) :: acc)
        val augfuns = find_forward_references ([],funs,[])
        (* Now augfuns is in the correct order *)
        (* Each function needs to be in the same recursive set as any function that refers to it *)
        (* and is earlier in the ordering *)
        datatype 'a fnset = NONREC of 'a | REC of 'a list
        (* set auxiliaries *)
        fun add (item,list) = if Lists.member (item,list) then list else item :: list
        fun remove (item,list) =
          let
            fun aux ([],acc) = acc
              | aux (a::b,acc) =
                if a = item then aux (b,acc)
                else aux (b,a::acc)
          in
            aux (list,[])
          end
        fun union (list1,list2) =
          Lists.reducel (fn (l,x) => add (x,l)) (list1,list2)
        fun split (needed,current_set,[],acc) =
          (case current_set of
             [] => acc
           | _ => REC (rev current_set) :: acc)
          | split ([],current_set,(id,info,stuff,frefs) :: rest,acc) =
            (case current_set of
               [] =>
                 (case frefs of
                    [] => split ([],[],rest,NONREC (id,info,stuff) :: acc)
                  | _ => split (remove (id,frefs),[(id,info,stuff)],rest,acc))
             | _ =>
                 (* No more ids required for current set, so add it to acc *)
                 split ([],[],(id,info,stuff,frefs) :: rest, REC (rev current_set) :: acc))
          | split (needed,current_set,(id,info,stuff,frefs) :: rest,acc) =
            split (union (remove (id,needed),frefs),(id,info,stuff) :: current_set,rest,acc)

        (* fnsets are now in order of definition *)
        val fnsets = rev (split ([],[],augfuns,[]))

        fun make_decs [] = body
          | make_decs (NONREC (id,info,stuff) :: rest) =
            LET ((id,info,trans_fun stuff),
                             make_decs rest)
          | make_decs (REC l :: rest) =
            let
              val ids = map #1 l
              val infos = map #2 l
              val bodies = map trans_fun (map #3 l)
            in
              LETREC (Lists.zip (ids,infos),bodies,make_decs rest)
            end
      in
        make_decs fnsets
      end
*)

    and do_funs (body,funs) =
      let
        (* funs is (id,info,stuff) list and is in reverse order *)
        val funs = rev funs
        val ids = map #1 funs
        val augfuns = map (fn (id,info,stuff) => (id,info,stuff,SimpleUtils.freevars (stuff_body stuff,ids))) funs
        fun partition sets =
          let
            (* sets is augfuns *)
            (* wish to partition into connected components *)
            val setarray = Array.arrayoflist sets
            val num_items = Array.length setarray
            (* This should be a binary search *)
            (* Returns the index of the item in the list *)
            fun find item =
              let
                fun aux n = 
                  if n >= num_items
                    then Crash.impossible "find item"
                  else if item = #1 (Array.sub (setarray,n))
                         then n
                       else aux (n+1)
              in
                aux 0
              end
            val leaders = Array.tabulate (num_items,fn n => n)
            fun leader i = Array.sub (leaders,i)
            val partitions = Array.tabulate (num_items,fn n => [n])
            fun partition i = Array.sub (partitions,i)
            (* leaders is the "representative" for each partition *)
            (* partitions contain the partition for each of the current leaders *)
            val canonical_sets =
              map (fn (item,a,b,itemlist) => (find item,map find itemlist)) sets
            (* merge two ordered sets, maintaining the order *)
            fun revapp (a::b) acc = revapp b (a::acc)
              | revapp [] acc = acc
            fun merge ([],rest,acc) = revapp acc rest
              | merge (rest,[],acc) = revapp acc rest
              | merge ((a::b),(c::d),acc) =
                if a < c then merge (b,c::d,a::acc)
                else merge (a::b,d,c::acc)
            fun doone (item1,itemlist) =
              app
              (fn item2 =>
               let
                 val l1 = leader item1
                 val l2 = leader item2
               in
                 if l1 = l2 then ()
                 else
                   let
                     val set = merge (partition l1, partition l2,[])
                   in
                     Array.update (partitions,l1,set);
                     app
                     (fn i => Array.update (leaders,i,l1))
                     set
                   end
               end)
              itemlist
            val set_them = app doone canonical_sets;
            val done = Array.array (num_items,false)
            fun foo (n,done,acc) =
              if n >= num_items then rev acc
              else
                let
                  val l = leader n
                in
                  if Lists.member (l,done)
                    then foo (n+1,done,acc)
                  else
                    foo (n+1,l::done,map (fn i => (Array.sub (setarray,i))) (partition l) :: acc)
                end
          in
            foo (0,[],[])
          end
        val partitions = partition augfuns
        datatype 'a fnset = NONREC of 'a | REC of 'a list
        val decsets = 
          map 
          (fn [(id,info,stuff,[])] => NONREC (id,info,stuff)
             | l => REC (map (fn (id,info,stuff,_) => (id,info,stuff)) l))
          partitions
        fun make_decs [] = body
          | make_decs (NONREC (id,info,stuff) :: rest) =
            LET ((id,info,trans_fun stuff),
                             make_decs rest)
          | make_decs (REC l :: rest) =
            let
              val ids = map #1 l
              val infos = map #2 l
              val bodies = map trans_fun (map #3 l)
            in
              LETREC (Lists.zip (ids,infos),bodies,make_decs rest)
            end
      in
        make_decs decsets
      end

    and trans_fndecs ([],body,acc) = do_funs (trans_back body,acc)
      | trans_fndecs ((v,info,VAL (FN stuff)) :: decs,body,acc) =
        trans_fndecs (decs,body,(v,info,stuff) :: acc)
      | trans_fndecs (decs,body,acc) =
        do_funs (trans_decs (decs,body),acc)

    (* And finally *)
    fun trans_program (PROGRAM p) = trans_decs p

  end
