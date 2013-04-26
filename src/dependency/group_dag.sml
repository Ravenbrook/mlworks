(*
 *   Compute the portion of the global dependency graph (a DAG) which
 *   is induced by a single group or library.
 *
 *   Copyright (c) 1995 by AT&T Bell Laboratories
 *
 * author: Matthias Blume (blume@cs.princeton.edu)
 *)

require "__ordered_set";
require "module_dec";
require "module_name";
require "import_export";
require "../basics/module_id";

signature GROUP_DAG = sig

    structure ModuleName: MODULE_NAME
    structure ModuleDec : MODULE_DEC
    structure ImportExport: IMPORT_EXPORT
    structure ModuleId: MODULE_ID;

    sharing ModuleDec = ImportExport.ModuleDec
        and ModuleName = ImportExport.ModuleName = ModuleDec.ModuleName

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
		intern: 'ext_info dag OrderedSet.set,
		extern: 'ext_info
	       }


    (* given:
     *   - a list of Sml sources
     *   - empty external information
     *   - a lookup function for external names (returning and env and info)
     *   - a function to combine pieces of info
     *   - a list of module names, which are used to filter the
     *     export list ([] means no filtering)
     * compute:
     *   - list of names exported by this set of sources (not including the
     *     things re-exported from sub-entities) together with the dag
     *     nodes corresponding to the defining source of each name
     *)

    val analyze:
	{
	 union_dag: 'info dag OrderedSet.set * 'info dag OrderedSet.set 
                    -> 'info dag OrderedSet.set,
	 smlsources: (sml_source * ModuleDec.Dec * bool) list,
	 enone: 'info,
	 eglob: ModuleName.t -> ImportExport.env * 'info,
	 ecombine: 'info * 'info -> 'info,
	 seq_no: int ref
	}
	->
	(ModuleName.set * 'info dag) list

end

