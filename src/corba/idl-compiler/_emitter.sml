(* "$Header: /Users/nb/info.ravenbrook.com/project/mlworks/import/2013-04-25/xanalys-tarball/MLW/src/corba/idl-compiler/RCS/_emitter.sml,v 1.2 1999/03/10 15:47:16 clive Exp $" *)

require "absyn";
require "walker";

require "$.basis.__text_io";

require "emitter";

functor Emitter (structure Walker : WALKER) : EMITTER =
  struct

    structure Walker = Walker
    structure Absyn = Walker.Absyn

    datatype emit_type = SIGNATURE 

    fun concatenate_all ([]) = ""
      | concatenate_all (h::t) = h ^ concatenate_all (t)

    open Absyn

    fun translate_type (type_void,_) = "Orb.Corba.void"
      | translate_type (type_signed_long,_) = "Orb.Corba.signed_long"
      | translate_type (type_any,_) = "Orb.Corba.Any"
      | translate_type (type_typecode,_) = "Orb.Corba.TypeCode"

    exception Impossible 
    exception EmitError of string

    fun path_to_environment (path,env) = 
      let
      	val found = Walker.lookup_scoped_name (path, env)
		handle Walker.LookupFailed _ => raise EmitError "Failed to find during lookup"
      in
        case found of 
	  Walker.non_scoped data => raise EmitError "Non-environment found"
	| Walker.scoped data => (#environment data)
	| Walker.dataless_non_scoped _ => raise EmitError "Found dataless element where path expected"
      end

    fun path_to_string (path, env) =
      let
      	val found = Walker.lookup_scoped_name (path, env)
		handle Walker.LookupFailed _ => raise EmitError "Failed to find during lookup"
      in
        case found of 
	  Walker.scoped data => concatenate_all(#path data)
	| Walker.non_scoped data => concatenate_all(#path data)
	| Walker.dataless_non_scoped _ => raise EmitError "Found dataless element where path expected"
      end

    fun generate_emitter emit_type =
    let

     fun emit (enum_def def, _, state, added, env, path, _) =
      (case def of
        type_enum (name, member_list) =>
	  let
	    fun make_members [] = raise Impossible
	      | make_members ([h]) = h
	      | make_members (h::t) = 
                   (h ^ " | " ^ make_members t)
          in
	    case emit_type of
	      SIGNATURE =>
		["datatype " ^ name ^ " = ",
		 "   " ^ make_members member_list,
		 "structure " ^ name ^ "' :",
		 "  sig",
		 "    val insert :" ^ name ^ " -> " ^ translate_type (type_any,env),
		 "    val extract :" ^ translate_type (type_any,env) ^ " -> " ^ name,
		 "    val tc : " ^ translate_type (type_typecode, env),
		 "  end"]
	  end
      | _ => raise EmitError "Non-enumeration inside enum_def")

     |   emit (interface_def {interface_name,supers,...}, _, state, added, env, path, _) =
	  let
	    fun generate_to_from ([],acc) = acc
	      | generate_to_from (h::t,acc) = 
		let
		  val super_name = path_to_string (h,env)
		in
		  ["    val to_" ^ super_name ^ " : " ^ interface_name ^ " -> "  ^ super_name,
	 	   "    val from_" ^ super_name ^ " : " ^ super_name ^ " -> " ^ interface_name]
		end
	    fun generate_operations_from_env (Walker.non_scoped {disc,data=[inputs,outputs],name,...} :: t,acc) =
		let
		  val recursive = generate_operations_from_env (t,acc)
		in
		  if disc = Walker.OPERATION
		  then 
		    ("    val " ^ name ^ " : " ^ inputs ^ " -> " ^ interface_name ^ " -> " ^ outputs) :: recursive
		  else
		    recursive
		end
	      | generate_operations_from_env (_ :: t,acc) = generate_operations_from_env (t,acc)
	      | generate_operations_from_env ([], []) = []
	      | generate_operations_from_env ([], h::t) = generate_operations_from_env (h,t)

	    fun generate_attributes_from_env (Walker.non_scoped {disc,data,name,...} :: t,acc) =
		let
		  val recursive = generate_attributes_from_env (t,acc)
		in
		  case disc of 
			Walker.ATTRIBUTE readonly => 
		    (map (fn attr_name  =>
		         ("    val " ^ name ^ " : unit -> " ^ interface_name ^ " -> " ^ attr_name)) data)
			 @
		    (if readonly 
			then []
			else (map (fn attr_name  =>
		         ("    val set'" ^ name ^ " : " ^ attr_name ^ " -> " ^ interface_name ^ " ->  unit")) data))
			 @
			recursive
		  | _ =>  recursive
		end
	      | generate_attributes_from_env (_ :: t,acc) = generate_attributes_from_env (t,acc)
	      | generate_attributes_from_env ([], []) = []
	      | generate_attributes_from_env ([], h::t) = generate_attributes_from_env (h,t)
	     
	  in
		["type " ^ interface_name,
		 "structure " ^ interface_name ^ "' :",
		 "  sig",
		 "    val insert :" ^ interface_name ^ " -> " ^ translate_type (type_any,env),
		 "    val extract :" ^ translate_type (type_any,env) ^ " -> " ^ interface_name,
		 "    val tc : " ^ translate_type (type_typecode,env),
		 "    val to_Object : " ^ interface_name ^ " -> Orb.Corba.Object ",
		 "    val from_Object : Orb.Corba.Object -> " ^ interface_name]
		@
		generate_to_from (supers, nil)
		@
		["  end"]
		@
	        ["structure " ^ interface_name ^ "'stubs :",
		"  sig"]
		@
		generate_operations_from_env ([],added :: (map (fn x => path_to_environment(x,env)) supers))
		@
		generate_attributes_from_env ([],added :: (map (fn x => path_to_environment(x,env)) supers))
		@
		["  end"]
	  end

     |   emit (operation_def {result_type, name, parameters,...}, _, state, added, env, path, _) =
	   let
	     fun prune_parameters ([], acc, input) = acc
	       | prune_parameters (param_decl_def {attribute,the_type,...} :: t, acc, input) =
		   case attribute of
			param_inout => prune_parameters(t,translate_type (the_type,env) ::acc,input)
		      | param_in => prune_parameters(t, if input then translate_type (the_type,env) ::acc else acc, input)
		      | param_out => prune_parameters(t, if input then acc else translate_type (the_type,env) ::acc, input)
	      fun merge_to_tuple [] = "()"
	        | merge_to_tuple [h] = h
		| merge_to_tuple (h::t) = h ^ " * " ^ merge_to_tuple(t)
	   in
		[ merge_to_tuple (prune_parameters (parameters,[],true)),
		  let
		    val params = prune_parameters (parameters,[],false)
		  in
		    merge_to_tuple (if result_type = Absyn.type_void 
					then params 
					else translate_type (result_type,env) :: params)
		  end]
	   end

     |   emit (attribute_def {readonly, the_type, slots}, _, state, added, env, current_name :: path, _) =
	   let
	     fun findit ((item as Absyn.simple_declarator_def name)::rest) = if name = current_name then item else findit rest
               | findit ((item as Absyn.array_declarator_def (name,_))::rest) = if name = current_name then item else findit rest
	       | findit [] = raise EmitError "Attribute not found in list"

	     val attr = findit slots	       
	   in
	      [case attr of 
		Absyn.simple_declarator_def name => translate_type(the_type, env)
	      | Absyn.array_declarator_def (name,dims) =>
			translate_type (Absyn.type_array(the_type,dims),env)]
	   end

    in
	emit
    end

  val generate_signatures = 
	  fn definitions =>
	    let 
	       val env = Walker.walk_the_tree(definitions, [], generate_emitter (SIGNATURE)) 
	    in
		map (fn Walker.dataless_non_scoped _ => []
		  	|  Walker.non_scoped {data,...} => data
		  	|  Walker.scoped {data,...} => data)
		(rev env)
	    end

end
