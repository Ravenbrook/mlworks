(* "$Header: /Users/nb/info.ravenbrook.com/project/mlworks/import/2013-04-25/xanalys-tarball/MLW/src/corba/idl-compiler/RCS/_walker.sml,v 1.4 1999/03/10 15:48:10 clive Exp $" *)

require "absyn";
require "walker";

functor Walker (structure Absyn : ABSYN) : WALKER =

struct

  structure Absyn = Absyn

  datatype scope_discriminator = INTERFACE | MODULE | FORWARD | STRUCT | OPERATION | MEMBER | ENUM | ENUM_MEMBER 
				| EXCEPTION | ATTRIBUTE of bool | CONST | TYPEDEF

  datatype 'a environment_element = 
    non_scoped of { name : string, path : string list, disc : scope_discriminator, data : 'a }  
  | dataless_non_scoped of { name : string }
  | scoped     of { name : string, path :string list, disc : scope_discriminator, 
		    data : 'a, environment : 'a environment_element list }
 
  type 'a environment = 'a environment_element list
 
  type current_walker_state = { include_path : string list, current_pragmas : string list, depth : int }

  type ''a data_generator =
     (Absyn.definition * Absyn.type_description * current_walker_state * ''a environment * ''a environment * string list 
			* Absyn.const_exp_def list -> ''a)

  open Absyn

  exception LookupFailed of string list

  fun lookup_scoped_name (name_path path, env) =
    let

      fun find (name, []) = raise LookupFailed path
        | find (path as [name], (entry as non_scoped data)::t) =
		if name = #name data
		then entry
		else find (path, t)
        | find (path as [name], (entry as scoped data)::t) =
		if name = #name data
		then entry
		else find (path, t)
	| find (path as (name::rest_path),
		(scoped data)::t) = 
		if name = #name data
		then find (rest_path, #environment data)
		else find(path,t)
	| find (_,_) = raise LookupFailed path

    in
	find (path,env)
    end

  exception FailedToFindAccumulation

  fun capture_added_entries (old,new) =
  let
    fun accumulate (old, new as (h::t), acc) =
      if old=new
      then rev acc
      else accumulate (old,t,h::acc)
      | accumulate ([],[],acc) = acc
      | accumulate (_,[], acc) = raise FailedToFindAccumulation
  in
    accumulate (old, new, [])
  end 

  exception InheritingFromNonInterface

  fun accumulate_inherited_interfaces (paths, env) =
   let
    fun accumulate ([], accumulated_env) = accumulated_env
      | accumulate (h::t, accumulated_env) =
        let 
          val lookup = lookup_scoped_name (h, env)
	in
  	  case lookup of
	    scoped {disc=INTERFACE, environment=interface_env,...} => 
	       accumulate  (t, interface_env @ accumulated_env)
	  | _ => raise InheritingFromNonInterface 
        end
    in
 	accumulate (paths, env)
    end

 fun append_all ([]) = []
   | append_all (h::t) = h @ append_all (t)

 fun generate_member_environment (tree_node, the_type, current_state, names, env, id, data_generator, ty) = 
	map (fn name_details =>
             case name_details of
		simple_declarator_def name => 
		  non_scoped{ name=name, disc=ty, path = name :: id,
				data=data_generator (tree_node, the_type, current_state, [], env, name :: id, [])}
	      | array_declarator_def (name, dimensions) =>
		  non_scoped {name=name, disc=ty, path = name :: id,
				data=data_generator (tree_node, the_type, current_state, [], env, name :: id, dimensions)})
	   names

 fun generate_structure_members_environment (tree_node, current_state, members, env, id, data_generator, ty) =
  append_all
  (map
   (fn element =>
     case element of member_description {the_type, names} =>
       generate_member_environment(tree_node, the_type, current_state, names, env, id, data_generator,ty ))
   members)

 exception WalkerError of string

 fun walk_the_tree (defs, env, additional_info_maker) =
 let
  fun walk_the_tree_aux ([],current_state, env, id) = (env, current_state)
    
    | walk_the_tree_aux (tree_node :: rest_nodes, current_state, env, id) =
      case tree_node of

        operation_def {name,...} =>
  	  walk_the_tree_aux(
		rest_nodes,
		current_state,
		non_scoped {name=name, disc=OPERATION, path = name :: id,
			data=additional_info_maker (tree_node,type_void,current_state, [], env, name::id,[])} :: env,
		id)

      | module_def {module_name,definitions,...} =>
	(let
	  val old_defn = lookup_scoped_name (name_path [module_name], env)
        in
   	  case old_defn of
	    scoped module_env =>
		let
		  val walk_env = #environment module_env @ env
		  val (new_env, current_state) = walk_the_tree_aux (definitions, current_state, walk_env, module_name::id)
		  val captured_entries = capture_added_entries (walk_env, new_env)
		  val after_env = captured_entries @ #environment module_env
		in
		  walk_the_tree_aux(
			rest_nodes,
			current_state,
			scoped {name=module_name,
				disc=MODULE,
				path = module_name ::id,
				environment = after_env,
				data = additional_info_maker 
					(tree_node, type_void,current_state, env, captured_entries, module_name :: id,[])} :: env,
			id)
		end
	  | _ => raise LookupFailed ["non module"]
	end
	handle LookupFailed _ => 
	let 
	  val (new_env, current_state) = walk_the_tree_aux (definitions, current_state, env, module_name::id)
	  val captured_entries = capture_added_entries (env, new_env)
        in
	  walk_the_tree_aux(
            	rest_nodes,
	  	current_state,
	  	scoped
	  	{name=module_name, 
	   	disc = MODULE,
		path = module_name :: id,
	   	environment = captured_entries, 
	   	data = additional_info_maker(tree_node, type_void, current_state, captured_entries, env, module_name:: id, [])}
					 :: env,
	   id)
	end)

      | interface_def {interface_name,definitions,supers,...} =>
	let 
	  val old_env = accumulate_inherited_interfaces (supers, env)
	  val (new_env,current_state) = walk_the_tree_aux (definitions, current_state, old_env, interface_name::id)
	  val captured_entries = capture_added_entries (old_env, new_env)
       in
          walk_the_tree_aux(
		rest_nodes,
		current_state,
	 	scoped
	  	{name=interface_name,
	   	disc = INTERFACE, 
		path = interface_name::id,
	   	environment = captured_entries,
	   	data = additional_info_maker (tree_node, type_void, current_state, captured_entries, env, interface_name::id, [])}
					 :: env,
		id)
	end

      | pragma_placeholder pragma =>
	let
	in
	  walk_the_tree_aux(
		rest_nodes,
		{ include_path = #include_path current_state, 
		  current_pragmas = pragma :: #current_pragmas current_state,
		  depth = #depth current_state
		},
		env,
		id)
	end

      | forward_def interface_name =>
	walk_the_tree_aux(
		rest_nodes,
		current_state,
		scoped {
			name=interface_name,
			disc=FORWARD,
			path = interface_name :: id,
			environment = [],
			data = additional_info_maker (tree_node, type_void, current_state, [], env, interface_name :: id, [])}
					 :: env,
		id)

      | structure_def (type_struct{name,members}) =>
          walk_the_tree_aux(
		rest_nodes,
		current_state,
		scoped {
			name=name,
			disc=STRUCT,
			path = name :: id,
			environment=env,
			data = additional_info_maker (tree_node, type_void, current_state, [], env, name::id, [])} :: env,
		id)

      | structure_def _ => raise WalkerError "Non-structure in structure_def"

      | attribute_def {readonly, the_type, slots,...} =>
	walk_the_tree_aux(
		rest_nodes,
		current_state,
		generate_member_environment 
	           (tree_node, the_type, current_state, slots, env, id, additional_info_maker,ATTRIBUTE readonly) @ env,
		id)

      | const_def {the_type, name,...} =>
	walk_the_tree_aux(
		rest_nodes,
		current_state,
		generate_member_environment (tree_node, the_type, current_state,
						[simple_declarator_def name], env, id, additional_info_maker, CONST) 
			@ env,
		id)

      | enum_def (type_desc as (type_enum (name,elements))) =>
	  walk_the_tree_aux(
		rest_nodes,
		current_state,
		map (fn name => dataless_non_scoped {name=name })
                     elements 
		@
		(scoped {
			name=name,
			disc=ENUM,
			path = name :: id,
			environment=[],
			data = additional_info_maker (tree_node, type_void, current_state, [], env, name::id, [])} :: env),
		id)

      | enum_def _ => raise WalkerError "Non-enumeration in enum_def"

      | typedef_def {the_type, names} =>
	walk_the_tree_aux(
		rest_nodes,
		current_state,
		generate_member_environment 
			(tree_node, the_type, current_state, names, env, id, additional_info_maker,TYPEDEF) @ env,
		id)

      | exception_def {name,members} =>
          walk_the_tree_aux(
		rest_nodes,
		current_state,
		scoped {
			name=name,
			disc=EXCEPTION,
			path = name :: id,
			environment=env,
			data = additional_info_maker (tree_node, type_void, current_state, [], env, name::id, [])} :: env,
		id)

      | include_begin_placeholder file =>
	  walk_the_tree_aux(
		rest_nodes,
		{ 
		  include_path = file :: #include_path current_state, 
		  current_pragmas = #current_pragmas current_state,
		  depth = #depth current_state + 1
		},
		env,
		id)

      | include_end_placeholder _ =>
	  walk_the_tree_aux(
		rest_nodes,
		{ 
		  include_path = tl (#include_path current_state), 
		  current_pragmas = #current_pragmas current_state,
		  depth = #depth current_state - 1
		},
		env,
		id)

      val (env,_) = walk_the_tree_aux (defs, { include_path = [], current_pragmas = [], depth = 0 } ,[], [])
 in
    env
 end 

end;

