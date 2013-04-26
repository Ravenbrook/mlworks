(* "$Header: /Users/nb/info.ravenbrook.com/project/mlworks/import/2013-04-25/xanalys-tarball/MLW/src/corba/idl-compiler/RCS/__absyn.sml,v 1.4 1999/03/10 15:46:19 clive Exp $" *)

require "absyn.sml";

structure Absyn :ABSYN =

struct

type module_name = string;
type interface_name = string;
type abstractp = bool;

datatype definition =
  module_def of {module_name : module_name, definitions : definition list} |
  interface_def of {interface_name : interface_name, supers : scoped_name list,
		    abstractp : abstractp, definitions : definition list} |
  forward_def of interface_name |
  structure_def of type_description |
  union_def of type_description |
  enum_def of type_description |
  typedef_def of { the_type : type_description, names : declarator_def list} |
  const_def of {the_type : type_description, name : string, value : const_exp_def } |
  exception_def of {name:string, members : member_def list} |
  operation_def of {oneway : bool, result_type : type_description,
			name : string, parameters : parameter_declaration_def list,
			raises : raises_def, context : context_def} |
  attribute_def of {readonly : bool, the_type : type_description, slots : declarator_def list} |
  value_def of {custom:bool, name : string, inherits_from:scoped_name list, supports: scoped_name list, 
		safe : bool, elements : value_element_def list } |
  value_abs_def of { name : string, inherits_from:scoped_name list, supports: scoped_name list, 
			safe : bool,definitions : definition list } |
  value_forward_def of {name:string,abstract:bool} |
  value_box_def of {name: string, the_type : type_description} |
  pragma_placeholder of string |
  include_begin_placeholder of string |
  include_end_placeholder of string

and scoped_name =
  name_path of string list 

and type_description =
  type_void | 
  type_named of scoped_name |
  type_signed_long |
  type_signed_short |
  type_unsigned_long |
  type_unsigned_short |
  type_char |
  type_boolean | 
  type_octet |
  type_any |
  type_object |
  type_typecode |
  type_float |
  type_double |
  type_struct of {name:string, members:member_def list} |
  type_union of {name:string, switch_type:type_description, cases:union_case_def list} |
  type_enum of string * string list |
  type_sequence_unbounded of type_description |
  type_sequence_bounded of {the_type:type_description, bound:const_exp_def} |
  type_string_unbounded |
  type_string_bounded of const_exp_def |
  type_value |
  type_array of type_description * const_exp_def list

and declarator_def =
  simple_declarator_def of string |
  array_declarator_def of string * const_exp_def list 

and member_def =
  member_description of {the_type : type_description, names : declarator_def list}

and union_case_def =
  case_description of case_label_def list * case_element_spec

and case_element_spec =
  case_element of type_description * declarator_def

and case_label_def =
  default | constant of const_exp_def 

and const_exp_def =
  vbar of const_exp_def * const_exp_def |
  hat of const_exp_def * const_exp_def |
  ampersand of const_exp_def * const_exp_def |
  lshift of const_exp_def * const_exp_def |
  rshift of const_exp_def * const_exp_def |
  plus of const_exp_def * const_exp_def |
  minus of const_exp_def * const_exp_def |
  star of const_exp_def * const_exp_def |
  slash of const_exp_def * const_exp_def |
  percent of const_exp_def * const_exp_def |
  unary_minus of const_exp_def |
  unary_plus of const_exp_def |
  twiddle of const_exp_def |
  const_val_name of scoped_name |
  const_val_exp of const_exp_def |
  const_val_int of string | 
  const_val_char of string |
  const_val_fp of string |
  const_val_boolean of bool |
  const_val_string_concat of string list

and parameter_attribute_def =
  param_in | param_out | param_inout

and parameter_declaration_def =
  param_decl_def of {attribute:parameter_attribute_def,the_type:type_description,name:declarator_def}

and raises_def =
  no_raises | raises of scoped_name list

and context_def =
  no_context | context of string list 

and value_element_def =
  value_element_export of definition |
  value_element_state_member of {public:bool, the_type : type_description, names : declarator_def list} |
  value_element_init_list of (type_description * declarator_def) list

withtype interface_header_type = (string * scoped_name list * abstractp)

and value_info = { inherits_from:scoped_name list, supports: scoped_name list, safe : bool }

end
