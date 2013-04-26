(* "$Header: /Users/nb/info.ravenbrook.com/project/mlworks/import/2013-04-25/xanalys-tarball/MLW/src/corba/idl-compiler/RCS/walker.sml,v 1.4 1999/03/10 15:49:32 clive Exp $" *)

require "absyn";

signature WALKER =
 
sig

  structure Absyn : ABSYN

  datatype scope_discriminator = INTERFACE | MODULE | FORWARD | STRUCT | OPERATION | MEMBER | ENUM | ENUM_MEMBER 
				| EXCEPTION | ATTRIBUTE of bool | CONST | TYPEDEF

  datatype 'a environment_element = 
    non_scoped of { name : string, path : string list, disc : scope_discriminator, data : 'a }  
  | dataless_non_scoped of { name : string }
  | scoped     of { name : string, path : string list, disc : scope_discriminator, 
			data : 'a, environment : 'a environment_element list }
 
  type ''a environment = ''a environment_element list

  type current_walker_state = { include_path : string list, current_pragmas : string list, depth : int }
 
  type ''a data_generator =
     (Absyn.definition              	(* The definition concerned *)
	* Absyn.type_description    	(* a type if relevant (attribute, tyepdef or const) *)
	* current_walker_state      	(* state of the walking at the moment (includes and pragmas) *)
	* ''a environment 		(* Things we're going to add to the environment *)
	* ''a environment 		(* Environment before this construct *)
	* string list 			(* path to this definition *)
	* Absyn.const_exp_def list	(* array values   *)
       -> ''a)

  val walk_the_tree :
    Absyn.definition list * 
    ''a environment * 
    ''a data_generator
   -> ''a environment

  exception LookupFailed of string list

  val lookup_scoped_name : Absyn.scoped_name * ''a environment -> ''a environment_element

end
