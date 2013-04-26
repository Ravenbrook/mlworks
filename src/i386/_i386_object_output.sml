(* I386_Object_Output the functor *)
(*
 * Functions to output code as genuine (.o) object files, either in assembler
 * format, or binary
 *
 * Copyright (c) 1998, Harlequin Group plc
 * All rights reserved
 *
 * $Log: _i386_object_output.sml,v $
 * Revision 1.10  1998/11/02 14:37:37  jont
 * [Bug #70204]
 * Make function to return module$closure$setup
 *
 * Revision 1.9  1998/11/02  11:12:01  jont
 * [Bug #70235]
 * Export module$closure$setup
 *
 * Revision 1.8  1998/10/28  18:11:17  jont
 * [Bug #70230]
 * Fix duplicate names problem
 *
 * Revision 1.7  1998/10/22  12:58:08  jont
 * [Bug #70218]
 * Remove need for mnemonic assembler input
 *
 * Revision 1.6  1998/10/21  16:35:04  jont
 * [Bug #70202]
 * Add entry point for determining offsets of externals in setup closure
 *
 * Revision 1.5  1998/10/20  17:01:37  jont
 * [Bug #70201]
 * Modify to use declare_root and retract_root for values in setup closure
 *
 * Revision 1.4  1998/10/16  10:06:16  jont
 * [Bug #70199]
 * Add function to return the address of the setup function closure
 *
 * Revision 1.3  1998/09/16  17:24:02  jont
 * [Bug #70133]
 * Change basis/__os to system/__os to allow correct bootstrapping
 *
 * Revision 1.2  1998/08/25  12:09:17  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)

require "../basis/__text_io";
require "../system/__os";
require "../basis/__io";
require "../basis/__int";
require "../basis/__string";
require "../basis/__word32";
require "../basis/__real";
require "../system/__time";
require "../utils/crash";
require "../utils/lists";
require "../basis/list";
require "../main/info";
require "../main/code_module";
require "../main/project";
require "../basics/module_id";
require "../rts/gen/tags.sml";
require "i386_assembly";
require "../main/object_output";

functor I386_Object_Output
  (structure Crash : CRASH
   structure List : LIST
   structure Lists : LISTS
   structure Info : INFO
   structure Code_Module : CODE_MODULE
   structure Project : PROJECT
   structure ModuleId : MODULE_ID
   structure Tags: TAGS
   structure I386_Assembly : I386_ASSEMBLY
   sharing type ModuleId.ModuleId = Project.ModuleId
     ) : OBJECT_OUTPUT =
  struct
    structure Path = OS.Path
    datatype OUTPUT_TYPE = ASM | BINARY

    type Opcode = I386_Assembly.opcode

    type Module = Code_Module.Module

    type ModuleId = ModuleId.ModuleId

    type Project = Project.Project

    val real_divisor = Real.fromInt(1000000)

    fun time_to_ints time =
      let
	val real_time = Time.toReal time
	val high = Real.realFloor(real_time / real_divisor)
      in
	(Real.floor high, Real.floor(real_time - high * real_divisor))
      end

    fun int_to_bytes(acc, i, n) = 
      if n = 0 then acc
      else
	int_to_bytes
	(MLWorks.Internal.Bits.andb(255, i) :: acc, MLWorks.Internal.Bits.rshift(i, 8), n-1)

    val int_to_bytes =
      fn i => int_to_bytes([], i, 4)

    fun index(Code_Module.REAL(i, _)) = i
      | index(Code_Module.STRING(i, _)) = i
      | index(Code_Module.WORDSET(Code_Module.WORD_SET{b = list, ...})) =
      (case list of
	 {a_clos, ...} :: _ => a_clos
       | _ => Crash.impossible"i386_object_output: index: empty WORDSET")
      | index(Code_Module.EXTERNAL(i, _)) = i
      | index _ = Crash.impossible"i386_object_output: index: illegal module element"


    fun sort_module elements =
      Lists.msort
      (fn (elt, elt') => index elt < index elt')
      elements

    fun munge_module_name name =
      if size name < 1 (* Should never happen *)
      orelse String.sub(name, 0) <> #" " then name
      else String.substring(name, 1, size name - 1)

    fun output_line stream str =
      (TextIO.output(stream, str); TextIO.output(stream, "\n"))

    fun compute_element_size(Code_Module.REAL _) = 1
      | compute_element_size(Code_Module.STRING _) = 1
      | compute_element_size(Code_Module.WORDSET(Code_Module.WORD_SET{a_names, ...})) =
      List.length a_names
      | compute_element_size(Code_Module.EXTERNAL _) = 1
      | compute_element_size _ =
      Crash.impossible"i386_object_output: compute_element_size: illegal module element"

    fun compute_module_size elements =
      List.foldl (fn ((element), x) => x + compute_element_size element) 0 elements

    val pair_ptr = Int.toString Tags.PAIRPTR

    val pointer = Int.toString Tags.POINTER

    val plus_pair_ptr = "+" ^ pair_ptr

    val plus_pointer = "+" ^ pointer

    fun make_name str1 str2 = str1 ^ "$" ^ str2

    fun make_ancillary_name name = make_name name "ancillary"

    fun generate_code_names (module_name, index) =
      let
	val mod_name = make_name module_name (Int.toString index)
	fun generate_code_names(Code_Module.REAL _) = [make_name mod_name "real"]
	  | generate_code_names(Code_Module.STRING _) = [make_name mod_name "string"]
	  | generate_code_names(Code_Module.WORDSET(Code_Module.WORD_SET{a_names, ...})) =
	  map
	  (fn (_, s) => make_name ((make_name mod_name) "code") s)
	  (#1(Lists.number_from_by_one(a_names, 0, Int.toString)))
	  | generate_code_names(Code_Module.EXTERNAL _) = [make_name mod_name "external"]
	  | generate_code_names _ = Crash.impossible"generate_code_names"
      in
	generate_code_names
      end

    fun generate_code_names_list(module_name, elements) =
      let
	fun make_names(index, res, []) = rev res
	  | make_names(index, res, element :: elements) =
	  make_names(index+1, generate_code_names (module_name, index) element :: res,
		     elements)
      in
	make_names(0, [], elements)
      end

    fun make_string_header x =
      Int.toString(MLWorks.Internal.Bits.lshift(1 + size x, 6) + Tags.STRING)

    fun make_real_header() =
      Int.toString(12*64 + Tags.BYTEARRAY)

    fun round_to n x =
      let
	val y = n-1
      in
	MLWorks.Internal.Bits.andb((x + y), MLWorks.Internal.Bits.notb y)
      end

    val round_to_4 = round_to 4

    fun make_code_header x =
      Int.toString(MLWorks.Internal.Bits.lshift(round_to_4 x, 4) + Tags.CODE)

    fun make_backpointer x =
      Int.toString(MLWorks.Internal.Bits.lshift(x, 6) + Tags.BACKPTR)

    fun make_record_header x =
      Int.toString(MLWorks.Internal.Bits.lshift(x, 6) + Tags.RECORD)

    fun make_word(n, chr_list, word : Word32.word) =
      if n = 0 then (chr_list, word)
      else
	case chr_list of
	  [] => Crash.impossible"i386_object_output: make_word"
	| x :: xs =>
	    make_word(n-1, xs, Word32.orb(Word32.<<(word, 0w8), Word32.fromInt(ord x)))

    fun make_real_strings x =
      let
	val chr_list = String.explode x
	val (chr_list, str2) = make_word(4, chr_list, 0w0)
	val (_, str1) = make_word(4, chr_list, 0w0)
      in
	("0x" ^ Word32.toString str1, "0x" ^ Word32.toString str2)
      end

    fun make_closure_name module_name = make_name module_name "closure"

    fun make_declare_name name = make_name name "declare"

    fun make_setup_name name = make_name name "setup"

    fun make_setup_closure_name module_name =
      make_setup_name (make_closure_name module_name)

    fun make_result_name module_name = make_name module_name "result"

    fun make_table_name module_name = make_name module_name "table"

    fun make_time_name module_name = make_name module_name "time"

    fun do_asm_data(stream, module_name, data_file, code_names, elements, module_string) =
      let
	val output_data = output_line stream
	val closure_name = make_closure_name module_name
	val closure_size = compute_module_size elements
	val closure_header = make_record_header closure_size
	val labels_and_values = Lists.zip(elements, code_names)
	val result_name = make_result_name module_name
	val setup_name = make_setup_name module_name
	val setup_profiles = make_name setup_name "profiles"
	val declare_name = make_declare_name closure_name
	val declare_result_name = make_result_name declare_name
	fun do_profile_data((Code_Module.WORDSET
			     (Code_Module.WORD_SET{a_names, b, ...})),
			    names as set_name :: _) =
	  let
	    val record_size = List.length names
	    val record_header = make_record_header record_size
	    val profile_name = make_name set_name "profile"
	  in
	    output_data"\t.align\t8";
	    output_data("\t.globl\t" ^ profile_name);
	    output_data(profile_name ^ ":");
	    output_data("\t.long\t" ^ record_header);
	    app
	    (fn _ => output_data"\t.long\t0")
	    names
	  end
	  | do_profile_data _ = ()
      in
	output_data "\t.data";
	output_data("\t.globl\t" ^ closure_name);
	output_data("\t.globl\t" ^ result_name);
	output_data("\t.global\t" ^ declare_result_name);
	output_data"\t.align\t4";
	output_data(result_name ^ ":\t.long\t0\t/* This must be a global root */");
	output_data(declare_result_name ^ ":\t.long\t0\t");
	app
	(fn ((Code_Module.WORDSET(Code_Module.WORD_SET{a_names, ...})), names) =>
	 app
	 (fn (comment, name) => output_data("\t.globl\t" ^ name ^ "\t/*" ^ comment ^ "*/"))
	 (Lists.zip(a_names, names))
         | _ => ())
	labels_and_values;
	output_data("\t.globl\t" ^ setup_profiles);
	output_data"\t.align\t8";
	output_data(setup_profiles ^ ":");
	output_data("\t.long\t" ^ make_record_header 1);
	output_data"\t.long\t0";
	output_data"\t.align\t8";
	output_data(closure_name ^ ":");
	output_data("\t.long\t" ^ closure_header);
	app
	(fn ((Code_Module.EXTERNAL _), _) =>
	 output_data"\t.long\t0" (* Deal specially with the externals *)
	  | (_, names) =>
	    app
	    (fn name =>
	     (output_data("\t.globl\t" ^ name);
	      output_data("\t.long\t" ^ name ^ plus_pointer)))
	    names)
	labels_and_values;
	app do_profile_data labels_and_values
      end handle IO.Io{cause, function, name} =>
	(TextIO.closeOut stream;
	 Info.default_error' (Info.FATAL, Info.Location.FILE module_name, "Cannot write to " ^ data_file ^ " (error " ^ name ^ " from function " ^ function ^ ")"))

    val round_to_8 = round_to 8

    fun make_ancill(saves, non_gcs, leaf, intercept, stack_param, code_no) =
      let
	val saves_shift = 0w19
	val non_gc_shift = 0w24
	val leaf_shift = 0w18
	val intercept_shift = 0w10
	val stack_param_shift = 0w21
	val intercept_mask = 0wxff
      in
	Word32.toString
	(Word32.orb
	 (Word32.fromInt code_no,
	  Word32.orb
	  (Word32.<<(Word32.fromInt saves, saves_shift),
	   Word32.orb
	   (Word32.<<(Word32.fromInt(non_gcs div 4), non_gc_shift),
	    Word32.orb
	    (Word32.<<(Word32.andb(Word32.fromInt intercept, intercept_mask), intercept_shift),
	     Word32.orb
	     (Word32.<<(Word32.fromInt stack_param, stack_param_shift),
	      (if leaf then Word32.<<(0w1, leaf_shift) else 0w0)
	      ))))))
      end

    fun do_asm_text(stream, module_name, text_file, code_names, elements, module_string, time) =
      let
	val output_text = output_line stream
	val setup_name = make_setup_name module_name
	val setup_names = make_name setup_name "names"
	val setup_profiles = make_name setup_name "profiles"
	fun do_ancillary_data((Code_Module.WORDSET
			       (Code_Module.WORD_SET{a_names, b, ...})),
			      names as set_name :: _) =
	  let
	    val record_size = List.length names
	    val record_header = make_record_header record_size
	    val profile_name = make_name set_name "profile"
	    val strings_name = make_name set_name "strings"
	    val ancillary_name = make_ancillary_name set_name
	  in
	    output_text"\t.align\t8";
	    output_text(ancillary_name ^ ":");
	    output_text("\t.long\t" ^ strings_name ^ plus_pointer);
	    output_text("\t.globl\t" ^ profile_name);
	    output_text("\t.long\t" ^ profile_name ^ plus_pointer);
	    output_text"\t.align\t8";
	    output_text(strings_name ^ ":");
	    output_text("\t.long\t" ^ record_header);
	    app
	    (fn name => output_text("\t.long\t" ^ make_name name "string" ^ plus_pointer))
	    names;
	    app
	    (fn (name, label) =>
	     (output_text"\t.align\t8";
	      output_text(make_name label "string" ^ ":");
	      output_text("\t.long\t" ^ make_string_header name);
	      output_text("\t.asciz\t\"" ^ String.toCString name ^ "\"")))
	    (Lists.zip(a_names, names))
	  end
	  | do_ancillary_data _ = ()

	val table_name = make_table_name module_name
	val time_name = make_time_name module_name
	val labels_and_values = Lists.zip(elements, code_names)
	val closure_name = make_closure_name module_name
	fun compute_total_code_size list =
	  List.foldl
	  (fn ({a_clos, b_spills, c_saves, d_code}, x) => x+8+size d_code)
	  4
	  list
	fun print_code_bytes code_string =
	  let
	    val code_list = explode code_string
	  in
	    app
	    (fn ch => output_text("\t.byte\t" ^ Int.toString(ord ch)))
	    code_list
	  end

	fun do_codeset(words as Code_Module.WORD_SET
		       {a_names, b, c_leafs, d_intercept, e_stack_parameters},
		       names as set_name :: _, code_start) =
	  let
	    val total_code_size = compute_total_code_size b
	    val offset = ref 8
	    fun do_vectors(name :: names,
			   {a_clos, b_spills, c_saves, d_code} :: bs,
			   leaf :: leafs,
			   intercept :: intercepts,
			   param :: params,
			   code_start,
			   code_no)
	      =
	      let
		val code_size = size d_code
	      in
		output_text"\t.align\t8";
		output_text(name ^ ":");
		output_text("\t.long\t" ^ make_backpointer(!offset));
		output_text("\t.long\t0x" ^ make_ancill(c_saves, b_spills, leaf, intercept, param, code_no));
		print_code_bytes d_code;
		offset := !offset + code_size + 8;
		do_vectors(names, bs, leafs, intercepts, params,
			   code_start + code_size + 8, code_no+1)
	      end
	      | do_vectors([], [], [], [], [], _, _) = ()
	      | do_vectors _ = Crash.impossible"i386_object_output: do_vectors: mismatch"
	  in
	    output_text"\t.align\t8";
	    output_text("\t.long\t" ^ make_code_header total_code_size);
	    output_text("\t.long\t" ^ make_ancillary_name set_name ^ plus_pair_ptr);
	    do_vectors(names, b, c_leafs, d_intercept, e_stack_parameters,
		       code_start+8, 0);
	    code_start + total_code_size - 4 (* Don't count ancill pointer *)
	  end
	  | do_codeset _ = Crash.impossible"i386_object_output: do_codeset: empty codeset"
	fun do_require(offset, name) =
	  let
	    val target_name = make_setup_name name
	  in
	    output_text("\t.globl\t" ^ target_name);
	    output_text("\tcall\t" ^ target_name);
	    output_text("\tmov\t%ebx," ^ closure_name ^ "+" ^ Int.toString(4+4*offset))
	  end
	fun do_requires() =
	  app
	  (fn (Code_Module.EXTERNAL x) => do_require x
	   | _ => ())
	  elements
	val externals_table_name = make_name module_name "externals"
	fun do_externals_table_name(_, name) =
	  let
	    val name_id = make_name name "id"
	  in
	    output_text"\t.align\t4";
	    output_text(name_id ^ ":");
	    output_text("\t.asciz\t\"" ^ name ^ "\"")
	  end
	fun do_externals_table_element(offset, name) =
	  let
	    val name_id = make_name name "id"
	  in
	    output_text("\t.long\t" ^ name_id);
	    output_text("\t.long\t" ^ Int.toString(4+4*offset))
	  end
	fun do_externals_table() =
	  let
	    val externals_table = make_name externals_table_name "table"
	  in
	    output_text"\t.align\t4";
	    app
	    (fn (Code_Module.EXTERNAL x) => do_externals_table_name x
	     | _ => ())
	    elements;
	    output_text"\t.align\t4";
	    output_text"\t.align\t8";
	    output_text(externals_table ^ ":");
	    app
	    (fn (Code_Module.EXTERNAL x) => do_externals_table_element x
	     | _ => ())
	    elements;
	    output_text"\t.long\t0";
	    output_text("\t.globl\t" ^ externals_table_name);
	    output_text(externals_table_name ^ ":");
	    output_text("\tlea\t" ^ externals_table ^ ",%eax");
	    output_text"\tret"
	  end
	fun do_code_add name =
	  (output_text("\tlea\t" ^ name ^ plus_pointer ^ ",%ebx");
	   output_text("\tcall\tml_loader_code_add"))
	fun do_code_adds() =
	  app
	  (fn ((Code_Module.WORDSET _), names) =>
	   app do_code_add names
	   | _ => ())
	  labels_and_values
	val get_closure_name = make_name "get" closure_name
	val result_name = make_result_name module_name
	val setup_name = make_setup_name module_name
	val setup_closure = make_setup_closure_name module_name
	val setup_closure_get = make_name setup_closure "get"
	val setup_ancillary = make_name setup_name "ancillary"
	val setup_closure_name = make_name setup_closure "name"
	val declare_name = make_declare_name closure_name
	val declare_result_name = make_result_name declare_name
	fun setup_length _ =
	  let
	    val initial_length = 12 (* ancillary, backptr, descriptor *) +
	      6 (* mov *) +
	      3 (* cmpl *) +
	      2 (* jz *) +
	      1 (* ret *) +
	      2 (* mov *) +
	      2 (* mov *) +
	      6 (* lea *) +
	      1 (* push *) +
	      4 (* lea *) +
	      1 (* push *) +
	      2 (* mov *) +
	      6 (* lea *) +
	      2 (* mov *) +
	      3 (* mov *) +
	      3 (* add *) +
	      2 (* call *) +
	      6 (* mov *) +
	      6 (* lea *) +
	      2 (* xor *) +
	      5 (* call *) +
	      6 (* mov *) +
	      1 (* pop *) +
	      1 (* pop *) +
	      1 (* ret *)
	  in
	    List.foldl
	    (fn ((Code_Module.EXTERNAL _), x) => x + 10 + 11 + 11 (* call, mov lea, call twice *)
	     | ((Code_Module.WORDSET(Code_Module.WORD_SET{a_names, ...})), x) =>
	     x + List.length a_names * 11 (* lea, call *)
	     | (_, x) => x)
	    initial_length
	    elements	    
	  end
	(* Do not change the setup sequence without changing the above function *)
	fun do_setup() =
	  let
	    val label_name = make_name setup_name "0"
	    val (time_hi, time_lo) = time_to_ints time
	  in
	    output_text("\t.globl\t" ^ setup_name);
	    output_text("\t.globl\t" ^ result_name);
	    output_text("\t.globl\t" ^ closure_name);
	    output_text("\t.globl\t" ^ setup_closure);
	    output_text("\t.globl\tml_declare_global");
	    output_text("\t.globl\tml_mt_update");
	    output_text("\t.globl\tml_loader_code_add");
	    output_text("\t.globl\tml_declare_root");
	    output_text("\t.globl\tml_retract_root");
	    output_text("\t.globl\t" ^ setup_profiles);
	    output_text"\t.align\t8";
	    output_text(setup_closure ^ ":");
	    output_text("\t.long\t" ^ make_record_header 1);
	    output_text("\t.long\t" ^ setup_name ^ "-3");
	    output_text"\t.align\t8";
	    output_text(setup_ancillary ^ ":");
	    output_text("\t.long\t" ^ setup_names ^ plus_pointer);
	    output_text("\t.long\t" ^ setup_profiles ^ plus_pointer);
	    output_text"\t.align\t8";
	    output_text(setup_names ^ ":");
	    output_text("\t.long\t" ^ make_record_header 1);
	    output_text("\t.long\t" ^ setup_closure_name ^ plus_pointer);
	    output_text"\t.align\t8";
	    output_text(setup_closure_name ^ ":");
	    output_text("\t.long\t" ^ make_string_header setup_name);
	    output_text("\t.asciz\t\"" ^ String.toCString setup_name ^ "\"");
	    output_text"\t.align\t8";
	    output_text("\t.long\t" ^ make_code_header(setup_length ()));
	    output_text("\t.long\t" ^ setup_ancillary ^ plus_pair_ptr);
	    output_text"\t.long\t0x222"; (* Back pointer *)
	    output_text("\t.long\t0x" ^ make_ancill(0, 0, false, ~1, 0, 0));
	    output_text(setup_name ^ ":");
	    output_text("\tmov\t" ^ result_name ^ ",%ebx");
	    output_text("\tcmpl\t$0,%ebx\t/* Already initialised? */");
	    output_text("\tjz\t" ^ label_name ^ "\t/* Branch if not */");
	    output_text("\tret\t/* Return previous result */");
	    output_text(label_name ^ ":");
(*
	    output_text"\tmov\t%ebx,%edx\t/* Save real arg */";
	    output_text"\tmov\t%edx,%ebx\t/* Restore real arg */";
*)
	    output_text("\tlea\t" ^ setup_closure ^ "+5,%ebp\t");
	    output_text"\tpush\t%edi";
	    output_text"\tlea\t8(%esp),%ecx";
	    output_text"\tpush\t%ecx";
	    output_text"\tmov\t%ebp,%edi\t/* set up my closure */";
	    (* Now do the declares for all the places where we store other modules' results *)
	    app
	    (fn (Code_Module.EXTERNAL(offset, _)) =>
	     (output_text("\tlea\t" ^ closure_name ^ "+" ^ Int.toString(4+4*offset) ^ ",%ebx");
	      output_text"\tcall\tml_declare_root\t/* Any mlvalue stored outside heap must be a root */")
	     | _ => ())
	    elements;
	    do_requires();
	    do_code_adds();
	    output_text("\tlea\t" ^ closure_name ^ "+5,%ebp\t/* real setup closure in %ebp*/");
	    output_text"\tmov\t%ebp,%ebx\t/* closure is arg as well */";
	    output_text"\tmov\t-1(%ebp),%ecx\t/* Get code pointer */";
	    output_text"\tadd\t$3,%ecx";
	    output_text"\tcall\t%ecx\t/* Call real setup */";
	    output_text("\tmov\t%ebx," ^ result_name ^ "\t/* Save result */");
	    output_text("\tlea\t" ^ table_name ^ plus_pointer ^ ",%eax\t/* The name of the module */");
	    output_text("\tlea\t" ^ time_name ^ plus_pair_ptr ^ ",%edx");
	    output_text("\tcall\tml_mt_update\t/* Add this module to the module table */");
	    app
	    (fn (Code_Module.EXTERNAL(offset, _)) =>
	     (output_text("\tlea\t" ^ closure_name ^ "+" ^ Int.toString(4+4*offset) ^ ",%ebx");
	      output_text"\tcall\tml_retract_root\t/* Any mlvalue stored outside heap must be a root */")
	     | _ => ())
	    elements;
	    output_text("\tmov\t" ^ result_name ^ ",%ebx\t/* Get result back */");
	    output_text"\tpop\t%ecx\t/* throw away fp */";
	    output_text"\tpop\t%edi\t/* Caller's closure back */";
	    output_text"\tret";
	    output_text"\t.align\t8";
	    output_text(table_name ^ ":");
	    output_text("\t.long\t" ^ make_string_header module_string);
	    output_text("\t.asciz\t\"" ^ module_string ^ "\"");
	    output_text"\t.align\t8";
	    output_text(time_name ^ ":");
	    app
	    (fn s => output_text("\t.byte\t" ^ Int.toString s))
	    (int_to_bytes time_hi);
	    app
	    (fn s => output_text("\t.byte\t" ^ Int.toString s))
	    (int_to_bytes time_lo)
	  end
	fun do_export() =
	  (output_text"\t.section\t.drectve";
	   output_text("\t.asciz\t\"-export:" ^ get_closure_name ^ "\"");
	   output_text("\t.asciz\t\"-export:" ^ externals_table_name ^ "\"");
	   output_text("\t.asciz\t\"-export:" ^ setup_name ^"\"");
	   output_text("\t.asciz\t\"-export:" ^ setup_closure_get ^"\"");
	   output_text("\t.asciz\t\"-export:" ^ declare_name ^"\""))
	(* A function to do the dll initialisation code *)
	fun do_init() =
	  let
	    val label = make_name declare_name "0"
	  in
	    output_text("\t.global\t" ^ declare_result_name);
	    output_text("\t.global\t" ^ declare_name);
	    output_text(declare_name ^ ":");
	    output_text("\tcmpl\t$0," ^ declare_result_name);
	    output_text("\tjne\t" ^ label);
	    output_text"\tpush\t%ebp";
	    output_text"\tmov\t%esp,%ebp";
	    (* Do the declare for this module's result *)
	    output_text("\tlea\t" ^ result_name ^ ",%ebx");
	    output_text("\tlea\t" ^ setup_closure_name ^ plus_pointer ^ ",%eax");
	    output_text"\tcall\tml_declare_global\t/* Result of running initialisation is a global root */";
	    (* Now do the declares for all the modules we call *)
	    app
	    (fn (Code_Module.EXTERNAL(_, name)) =>
	     let
	       val target_name = make_declare_name(make_closure_name name)
	     in
	       output_text("\t.globl\t" ^ target_name);
	       output_text("\tcall\t" ^ target_name)
	     end
	     | _ => ())
	    elements;
	    (* Now indicate that we've done it *)
	    output_text("\tmovl\t$1," ^ declare_result_name);
	    output_text"\tleave";
	    output_text(label ^ ":");
	    output_text"\tret"
	  end
	fun do_get_closure_name() =
	  (output_text("\t.globl\t" ^ get_closure_name);
	   output_text(get_closure_name ^  ":");
	   output_text("\tlea\t" ^ closure_name ^ ",%eax");
	   output_text"\tret")
	fun do_get_setup_closure_name() =
	  (output_text("\t.globl\t" ^ setup_closure_get);
	   output_text(setup_closure_get ^  ":");
	   output_text("\tlea\t" ^ setup_closure ^ plus_pointer ^ ",%eax");
	   output_text"\tret")
      in
	output_text"\t.text";
	do_setup();
	do_get_closure_name();
	do_get_setup_closure_name();
	do_externals_table();
	app
	(fn ((Code_Module.WORDSET(Code_Module.WORD_SET{a_names, ...})),
	     names as name :: _) =>
	 app
	 (fn (comment, name) => output_text("\t.globl\t" ^ name ^ "\t/*" ^ comment ^ "*/"))
	 (Lists.zip(a_names, names))
         | _ => ())
	labels_and_values;
	ignore
	(List.foldl
	 (fn (((Code_Module.WORDSET set), names), n) =>
	  do_codeset(set, names, n)
          | (_, n) => n)
	 0
	 labels_and_values);
	app do_ancillary_data labels_and_values;
	app
	(fn((Code_Module.REAL(_, x)), labels) =>
	 let
	   val (str1, str2) = make_real_strings x
	 in
	   output_text"\t.align\t8";
	   app
	   (fn label =>
	    (output_text("\t.globl\t" ^ label);
	     output_text(label ^ ":")))
	   labels;
	   output_text("\t.long\t" ^ make_real_header());
	   output_text"\t.long\t0";
	   output_text("\t.long\t" ^ str1);
	   output_text("\t.long\t" ^ str2)
	 end
         | ((Code_Module.STRING(_, x)), labels) =>
	 (output_text"\t.align\t8";
	  app
	  (fn label =>
	   (output_text("\t.globl\t" ^ label);
	    output_text(label ^ ":"))) labels;
	  output_text("\t.long\t" ^ make_string_header x);
	  output_text("\t.asciz\t\"" ^ String.toCString x ^"\""))
	 | ((Code_Module.WORDSET _, _)) => ()
	 | ((Code_Module.EXTERNAL _, _)) => ()
	 | _ => Crash.impossible"i386_object_output: do_asm_data: illegal module element")
	labels_and_values;
	do_init();
	do_export()
      end handle IO.Io{cause, function, name} =>
	(TextIO.closeOut stream;
	 Info.default_error' (Info.FATAL, Info.Location.FILE module_name, "Cannot write to " ^ text_file ^ " (error " ^ name ^ " from function " ^ function ^ ")"))

    fun output_asm_code (module_id, mo_name, project) (Code_Module.MODULE module) =
      let
	val module = sort_module module
	val module_string = ModuleId.string module_id
	val module_name = munge_module_name module_string
	val {dir = object_dir, ...} = Path.splitDirFile mo_name
	val data_file = Path.joinDirFile{dir=object_dir, file=module_name ^ "_data.S"}
	val text_file = Path.joinDirFile{dir=object_dir, file=module_name ^ "_text.S"}
	val code_names = generate_code_names_list(module_name, module)
	val source_time =
	  case Project.get_source_info(project, module_id) of
	    SOME(_, time) => time
	  | NONE => Time.zeroTime
      in
	let
	  val data_stream = TextIO.openOut data_file
	in
	  let
	    val text_stream = TextIO.openOut text_file
	    val _ = do_asm_data
	      (data_stream, module_name, data_file, code_names, module, module_string)
	    val _ = do_asm_text
	      (text_stream, module_name, text_file, code_names, module, module_string, source_time)
	  in
	    TextIO.closeOut data_stream;
	    TextIO.closeOut text_stream
	  end handle IO.Io{cause, function, name} =>
	    (TextIO.closeOut data_stream;
	     Info.default_error' (Info.FATAL, Info.Location.FILE module_name, "Cannot open " ^ text_file ^ " (error " ^ name ^ " from function " ^ function ^ ")"))
	end handle IO.Io{cause, function, name} =>
	  Info.default_error' (Info.FATAL, Info.Location.FILE module_name, "Cannot open " ^ data_file ^ " (error " ^ name ^ " from function " ^ function ^ ")")
      end

    fun output_object_code (ASM, module_id, mo_name, project) code =
      output_asm_code (module_id, mo_name, project) code
      | output_object_code (BINARY, module_id, mo_name, project) _ =
      Crash.unimplemented("output_object_code: " ^ ModuleId.string module_id)

  end
