(*
 *   Compute the portion of the global dependency graph (a DAG) which
 *   is induced by a single group or library.
 *
 *   Copyright (c) 1995 by AT&T Bell Laboratories
 *
 * author: Matthias Blume (blume@cs.princeton.edu)
 *)

require "import_export";
require "group_dag";
require "__ordered_set";
require "../basics/module_id";
require "../utils/__lists";

functor GroupDagFun (structure ImportExport: IMPORT_EXPORT
                     structure ModuleId : MODULE_ID): GROUP_DAG =
  struct

    structure ImportExport = ImportExport
    structure ModuleDec = ImportExport.ModuleDec
    structure ModuleName = ImportExport.ModuleName
    structure ModuleId = ModuleId
    structure Set = OrderedSet

    type sml_source = ModuleId.ModuleId

    exception MultipleDefinitions of string * string * string
    and Cycle of sml_source * (sml_source * ModuleName.t) list
    and IllegalToplevelOpen of string
    and GroupDagInternalError

    datatype 'ext_info dag =
	DAG of {
		seq_no: int,		(* to speed up merging of dag lists *)
		marked: bool ref,	(* a general purpose mark bit *)
		smlsource: sml_source,
		symmap: ModuleName.t -> ImportExport.env, (* meaning for exp. symbols *)
		intern: 'ext_info dag Set.set,
		extern: 'ext_info
	       }

    datatype 'ext_info state =
	UNKNOWN
      | LOCKED
      | KNOWN of 'ext_info dag

    and 'ext_info node =
	N of {
	      smlsource: sml_source,
	      dcl: ModuleDec.Dec,
	      exports: ModuleName.set,
	      state: 'ext_info state ref,
              is_target: bool
	     }

    and 'ext_info info =
	INFO of 'ext_info dag Set.set * 'ext_info

    fun analyze { union_dag,
		  smlsources = sl, enone, eglob, ecombine, seq_no } = let

	val inone = INFO (Set.empty, enone)

	fun icombine (INFO (l1, e1), INFO (l2, e2)) =
	    INFO (union_dag (l1, l2), ecombine (e1, e2))

	(* defsite_of: ModuleName.t * 'info node list -> 'info node option *)
	fun defsite_of (x, []) = NONE
	  | defsite_of (x, (hd as N { exports, ... }) :: tl) =
	    if ModuleName.memberOf exports x then
		SOME hd
	    else
		defsite_of (x, tl)

	(* parse sources, create a list of 'info nodes;
	 * make sure that no name has more than one definition *)
	fun s2n ((smlsource, dcl, is_target), r) = let
	    val node = 
		N {
		   smlsource = smlsource, dcl = dcl,
		   exports = ImportExport.exports (dcl, ModuleId.string smlsource)
		     handle ImportExport.IllegalToplevelOpen =>
                       raise IllegalToplevelOpen (ModuleId.string smlsource),
		   state = ref UNKNOWN,
                   is_target = is_target
		  }

	    fun add_node (n as N { exports, smlsource = s1, 
                                   is_target = is_t, ...}, r) = let
		val _ =
		    ModuleName.fold (fn (x, ()) =>
				     case defsite_of (x, r) of
					 NONE => ()
				       | SOME (N { smlsource = s2, 
                                                   is_target = is_t1, ... }) =>
                                           if is_t = is_t1
                                           then
					     raise MultipleDefinitions
						 (ModuleName.makestring x,
						  ModuleId.string s1,
						  ModuleId.string s2)
                                           else ())
		    () exports
	    in
		n :: r
	    end
              handle MultipleDefinitions(name, file1, file2) =>
                ( print ( "Multiple definition of " ^ name ^ " in files "
			^ file1 ^ " and " ^ file2 ^ "\n");
                  print ( "Ignoring file " ^ file1 ^ "\n");
                  r )
	in
	    add_node (node, r)
	end

	fun process_nodelist nodelist = let

            val nodelist =
              Lists_.qsort (fn (N {is_target,...}, _) => not is_target)
                           nodelist

	    exception Cyc of sml_source * (sml_source * ModuleName.t) list

	    fun process (N { smlsource, dcl, exports, state, is_target }) =
		case !state of
		    KNOWN dag => dag
		  | LOCKED => raise Cyc (smlsource, [])
		  | UNKNOWN => let
			val _ = state := LOCKED
			val (symmap, INFO (dagl, ei), _) =
			    imp state (dcl, ModuleId.string smlsource)
			val sno = !seq_no
			val _ = (seq_no := sno + 1)
			val dag = DAG { seq_no = sno,
				        smlsource = smlsource,
					marked = ref true,
					symmap = symmap,
					intern = dagl,
					extern = ei }
			val _ = state := KNOWN dag
		    in
			dag
		    end

	    (* iglob:
	     *  id -> ModuleName.t -> ImportExport.env * ('source, 'ext_info) info *)
	    and iglob s name = let
		fun use_eglob () = let
		    val (e, ei) = eglob name
		in
		    (e, INFO (Set.empty, ei))
		end
	    in
		case defsite_of (name, nodelist) of
		    NONE => use_eglob ()
		  | SOME (n as N { state, smlsource = src, ... }) =>
			if state = s then
			    use_eglob () (* hack to break length=1 cycles *)
			else let
			    val (dag as DAG { symmap, ... }) =
				process n
				  handle
				  Cyc (src', []) =>
				      raise Cyc (src', [(src, name)])
				| Cyc (src', l) =>
				      if ModuleId.eq (src', src) then
					  raise Cycle (src, l)
				      else
					  raise Cyc (src', (src, name) :: l)
			in
			    (symmap name, INFO (Set.singleton dag, enone))
			end
	    end

	    and imp s (dcl, sn) =
		ImportExport.imports (dcl, inone, iglob s, icombine, sn)

	    fun mn_map nl = let
		fun gen (N { exports, state = ref (KNOWN dag), ... }, r) =
		    (exports, dag) :: r
		  | gen _ = raise GroupDagInternalError
	    in
		foldl gen [] nl
	    end

	    fun touch (n as N { smlsource, ... }) =
		ignore (process n)
		handle Cyc (_, l) => raise Cycle (smlsource, l)

	in
	    app touch nodelist;
	    mn_map nodelist
	end
    in
	process_nodelist (foldr s2n [] sl)
    end
      handle Cycle (p as (source, list)) =>
        ( print("Cycle detected in " ^ (ModuleId.string source) ^ "\n");
          app (fn (file, name) =>
                 print( "  " ^ (ModuleId.string file) ^ 
                        " contains " 
                      ^ (ModuleName.makestring name) ^ "\n")) list;
          raise (Cycle p) )
end








