(*
 * Copyright (C) 1999.  Harlequin Group plc.  All rights reserved.
 * 
 * Stub Generator for FI.
 *
 * Revision Log
 * ------------
 * $log$
 *
 *)

(* 
 * Things to do:
 *
 * - allow bit-fields in structs
 * - implement function pointers
 * - change handling of coercion and set up type coercion table
 *)

require "mlworks_c_interface";

require "^.basis.__list";
require "^.basis.__int";
require "^.basis.__word";
require "^.basis.__text_io";
require "^.basis.__string";
require "^.basis.__os";

require "^.utils.__lists";

require "__stub_gen_input";
require "stub_gen";

functor StubGen (
  structure MLWorksCInterface: MLWORKS_C_INTERFACE
): STUB_GEN = 

struct

  structure SGInput = StubGenInput
  structure Lists = Lists_
  structure C' = MLWorksCInterface

  open SGInput

  exception StubGeneration of string
  fun error s = (TextIO.output (TextIO.stdOut, s^ "\n"); raise StubGeneration s)

  fun warning s = print ("WARNING: " ^ s ^ "\n") 

  val i2s = Int.toString

  (* pretty print erroneous type *)

  fun validSubset (CfunctionT f) = false 
    | validSubset CvoidT = false
    | validSubset (CptrT p) = (validPtr p)
    | validSubset (CarrayT (size, t)) = validArrType t
    | validSubset (CconstT t) = validConst t
    | validSubset other_type = true

  and validPtr (CfunctionT t) = error "function pointers not yet supported" (* validFun t *)
    | validPtr CvoidT = true
    | validPtr CaddrT = false
    | validPtr other_type = validSubset other_type

  and validArrType t = validSubset t

  and validResultType (Normal CvoidT) = true
    | validResultType (Normal t) = validSubset t
    | validResultType (Exception (t, condStr, raiseStr)) = validSubset t

  and validFun ([], result) = validResultType result
    | validFun (args, result) = 
      let
        fun validArgType (CdefaultAT otherTypes) = validSubset otherTypes
	  | validArgType (CptrAT (ptr, annotation)) = validPtr ptr
      in
	foldl (fn (a, b) => a andalso b) (validResultType result) (map validArgType args)
      end

  and validConst (CconstT t) = 
	(warning "redundant const specification in type";
	 validConst t)
    | validConst other_type = validSubset other_type

  fun validType (CptrT t) = validPtr t
    | validType (CarrayT (intOpt, t)) = validArrType t
    | validType (CstructT t) = true
    | validType (CunionT t) = true
    | validType (CfunctionT (args, result)) = validFun (args, result)
    | validType (CconstT t) = validConst t
    | validType _ = true

  fun validDecl (CexnD d) = true
    | validDecl (CstructD (name, memList)) = 
	Lists.forall (fn (n, t) => validSubset t) memList
    | validDecl (CunionD (name, memList)) = 
	Lists.forall (fn (n, t) => validSubset t) memList
    | validDecl (Cdecl (n, t)) = validType t
    | validDecl (MLcoerceD t) = error "Coercions not yet implemented"

  (* STRUCT_INFO stores details of the struct members:-
   *	name, C type, C type string, byte size *)
  (* FN_INFO stores the C types (eg. c_int) corresponding to the in and out arguments *)
  datatype auxDeclInfo = 
      STRUCT_INFO of 
	{members: (string * ctype * string * int) list,
	 dependents: string list}
    | FN_INFO of string list * string list
    | NO_INFO

  datatype declInfo = 
    DECL_INFO of 
       {declaration: cdecl,
	auxInfo: auxDeclInfo}
(* Implement coercion by adding extra declaration info here to indicate
 * the ML type after coercion.  The extra info could be a string option or
 * a (string list * string list) option depending on how the ML type is specified.
 * Probably the 'string option' type is best since the latter is only useful for 
 * functions and we want to be able to express top level values as well. 
 *)

  fun getStructInfo (STRUCT_INFO s) = s
    | getStructInfo _ = error "No struct info exists in DECL_INFO"

  fun getFnInfo (FN_INFO f) = f
    | getFnInfo _ = error "No function info exists in DECL_INFO"

  val getStructMembers = #members o getStructInfo
  val getStructDependents = #dependents o getStructInfo

  val typeList : (string * string) list ref = ref []

  fun getResultCtype (Normal t) = t
    | getResultCtype (Exception (t, conditionStr, raiseStr)) = t  

  fun arg2ctype (CdefaultAT t) = t
    | arg2ctype (CptrAT (t, argUse)) = t

  fun addGetMLtype just_get t = 
    let 
      fun addType (tname, tassign) = 
	if just_get orelse (List.exists (fn (n, a) => n=tname) (!typeList)) then tname
	else
	  (typeList := (tname, tassign) :: (!typeList);
	   tname)

      fun appendType (tname, tassign) = 
	if just_get orelse (List.exists (fn (n, a) => n=tname) (!typeList)) then tname
	else
	  (typeList := (!typeList) @ [(tname, tassign)];
	   tname)

      fun getArgMLtype CvoidT = 
	    (ignore(addType ("c_void", "type c_void = C'.void"));
	     "c_void")
        | getArgMLtype CaddrT = 
	    (ignore(getArgMLtype CvoidT);
	     ignore(addType ("'a c_ptr", "type 'a c_ptr = 'a C'.ptr"));
	     "c_void c_ptr")
        | getArgMLtype (CcharT us) = 
	    if (us = UNSIGNED) then 
	      addType ("c_uchar", "type c_uchar = C'.Uchar.word")
	    else
	      addType ("c_char", "type c_char = C'.Char.char")
        | getArgMLtype (CintT (us, typeOfInt)) = 
	    (case (us, typeOfInt) of 
	        (UNSIGNED, SHORT) => addType ("c_ushort", "type c_ushort = C'.Ushort.word")
	      | (UNSIGNED, INT)   => addType ("c_uint",   "type c_uint = C'.Uint.word")
	      | (UNSIGNED, LONG)  => addType ("c_ulong",  "type c_ulong = C'.Ulong.word")
	      | (SIGNED, SHORT)   => addType ("c_short",  "type c_short = C'.Short.int")
	      | (SIGNED, INT)     => addType ("c_int",    "type c_int = C'.Int.int")
	      | (SIGNED, LONG)    => addType ("c_long",   "type c_long = C'.Long.int")
	      | (_, BITS n) => error "Sorry, bitfields not yet implemented")
	    (* bit-fields will need to be handled by this at some point *)
        | getArgMLtype CdoubleT =
	    addType ("c_double", "type c_double = C'.Double.real")
        | getArgMLtype CfloatT = 
	    addType ("c_float", "type c_float = C'.Double.real")
        | getArgMLtype (CstructT sName) = 
		(* datatype structEg = structEg_S of C'.void c_ptr *)
	    appendType (sName, "datatype " ^ sName ^ " = " ^ sName ^ "_S of C'.void c_ptr")
        | getArgMLtype (CunionT uName) = 
	    appendType (uName, "datatype " ^ uName ^ " = " ^ uName ^ "_U of C'.void c_ptr")
        | getArgMLtype (CptrT t) = 
	    let val arg_t = getArgMLtype t
	    in
	      ignore(addType ("'a c_ptr", "type 'a c_ptr = 'a C'.ptr"));
	      arg_t ^ " c_ptr"
	    end
        | getArgMLtype (CfunctionT (args, result)) = 
	    (app (ignore o getArgMLtype o arg2ctype) args;
	     ignore (getArgMLtype (getResultCtype result));
	     ignore (getArgMLtype CvoidT);
	     "c_void")
        | getArgMLtype (CconstT t) = getArgMLtype t
        | getArgMLtype (CarrayT (intOpt, t)) = getArgMLtype (CptrT t)
    in
      getArgMLtype t
    end

  val addMLtype = addGetMLtype false
  val getMLtype = addGetMLtype true

  fun getFunctionType (args, result) = 
    let
      fun getArgsType [] = []
	| getArgsType ((CptrAT (t, inOut)) :: rest) = 
	    (case inOut of 
		OUT => getArgsType rest
	      | _ => (addMLtype t) :: getArgsType rest)
	| getArgsType ((CdefaultAT t)::rest) = 
	    if (t <> CvoidT) then 
	      (addMLtype t) :: getArgsType rest
	    else
	      getArgsType rest

      fun getOuts [] = [] 
	| getOuts ((CptrAT (t, OUT)):: rest) =    t :: getOuts(rest)
	| getOuts ((CptrAT (t, IN_OUT)):: rest) = t :: getOuts(rest)
	| getOuts (whateverElse :: rest) = getOuts(rest)

      val newOuts = 
	let val cRes = getResultCtype (result)
	in
	  if (cRes = CvoidT) then map addMLtype (getOuts args)
	  else (addMLtype (cRes)) :: (map addMLtype (getOuts args))
	end

    in
      SOME (getArgsType args, newOuts)
    end

  fun getDependents [] = []
    | getDependents ((name, CstructT s, tStr, size)::rest) = s :: getDependents rest
    | getDependents ((name, CunionT u, tStr, size)::rest) = u :: getDependents rest
    | getDependents (a::rest) = getDependents rest

  fun typeError (CstructD (s, m)) = error ("Invalid type found in a member of struct " ^ s)
    | typeError (CunionD (u, m)) = error ("Invalid type found in a member of union " ^ u)
    | typeError (Cdecl (n, t)) = error ("Invalid type for " ^ n)
    | typeError (CexnD _) = error "Invalid type found in exception declaration"
    | typeError (MLcoerceD (mld, mldStr)) = typeError mld

  (* second arg contains function type, third arg contains struct/union member types *)
  fun mkDeclInfo (d, fType, mTypes) =
     if validDecl d then 
       DECL_INFO {declaration = d,
		  auxInfo = 
		    case fType of 
		      SOME funType => FN_INFO (funType)
		    | NONE => 
			(case mTypes of 
			     SOME structTypes => 
				STRUCT_INFO {members = structTypes,
					     dependents = getDependents structTypes}
			   | NONE => NO_INFO)}
    else
      typeError d

  fun returnDecl (decl, (found, otherDecls)) = (found, decl::otherDecls)
  fun findStruct [] s = (NONE, [])
    | findStruct ((d as DECL_INFO {declaration, auxInfo})::rest) s = 
        (case declaration of 
	   CstructD (name, m) => if (s = name) then (SOME d, rest) 
				 else returnDecl (d, findStruct rest s)
	 | _ => returnDecl (d, findStruct rest s))
  fun findUnion [] s = (NONE, [])
    | findUnion ((d as DECL_INFO {declaration, auxInfo})::rest) s = 
	(case declaration of 
	   CunionD (name, m) => if (s = name) then (SOME d, rest) 
				 else returnDecl (d, findUnion rest s)
	 | _ => returnDecl (d, findUnion rest s))

  fun sizeOfC _ CvoidT = 0
    | sizeOfC _ CaddrT = 4
    | sizeOfC _ (CptrT t) = 4
    | sizeOfC _ (CintT (us, SHORT)) = 1
    | sizeOfC _ (CintT (us, INT)) = 4
    | sizeOfC _ (CintT (us, LONG)) = 4
    | sizeOfC _ (CintT (us, BITS n)) = (n mod 8) + 1   (* bitfields *)
    | sizeOfC _ (CcharT us) = 1
    | sizeOfC _ CdoubleT = 8
    | sizeOfC _ CfloatT = 8
    | sizeOfC decls (CarrayT (intOpt, t)) = 
        (case intOpt of
           NONE => sizeOfC decls t
         | SOME i => i * (sizeOfC decls t))
    | sizeOfC decls (CstructT sName) = 
        findStructUnion decls (sName, findStruct, (op +))
    | sizeOfC decls (CunionT uName) = 
        findStructUnion decls (uName, findUnion, fn (a, b) => if a>b then a else b)
    | sizeOfC _ (CfunctionT (args, result)) = 
        error "ML stubs: can't compute size of function"
    | sizeOfC ds (CconstT t) = sizeOfC ds t

  and findStructUnion (knownDs, unknownDs) (suName, findDecl, gatherFn) = 
    let
      val (declKnown, otherKnowns) = findDecl knownDs suName
    in
      case declKnown of 
         SOME (DECL_INFO {declaration, auxInfo}) => 
	   foldl gatherFn 0 (map (fn (_,_,_,s) => s) (getStructMembers auxInfo))
       | NONE => 
	   let val (declUnknown, otherUnknowns) = findDecl unknownDs suName
	   in
	     case declUnknown of 
	        SOME (DECL_INFO {declaration, auxInfo}) =>
		  let
		    fun getMsize (mName, ct, ctStr, _) = 
			sizeOfC (otherKnowns, otherUnknowns) ct
		  in
		    foldl gatherFn 0 (map getMsize (getStructMembers auxInfo))
		  end
	      | NONE => (* should not happen *)
		  error ("Struct/Union " ^suName^ " not found during sizeOfC")
	   end
    end (* findStructUnion *)

  fun getSizes [] visited = visited
    | getSizes ((d as DECL_INFO {declaration, auxInfo})::dRest) visited = 
      (case declaration of 
	   Cdecl _ => getSizes dRest (d::visited)
         | CexnD _ => getSizes dRest (d::visited)
	 | MLcoerceD (d, ds) => 
	     error "Coercions not implemented yet"
         | CstructD (sName, members) => 
	     let 
	       fun updateSizeInfo (mName, mCtype, mCtypeStr, oldSize) = 
		     (mName, mCtype, mCtypeStr, sizeOfC (visited, dRest) mCtype)
	       val newAuxInfo = 
		 STRUCT_INFO {members = map updateSizeInfo (getStructMembers auxInfo),
			      dependents = getStructDependents auxInfo}
	     in
	       getSizes dRest ((DECL_INFO {declaration=declaration, 
			       		   auxInfo=newAuxInfo})::visited)
	     end
         | CunionD (sName, members) => 
	     let 
	       fun updateSizeInfo (mName, mCtype, mCtypeStr, oldSize) = 
		     (mName, mCtype, mCtypeStr, sizeOfC (visited, dRest) mCtype)
	       val newAuxInfo = 
		 STRUCT_INFO {members = map updateSizeInfo (getStructMembers auxInfo),
			      dependents = getStructDependents auxInfo}
	     in
	       getSizes dRest ((DECL_INFO {declaration=declaration, 
					   auxInfo=newAuxInfo})::visited)
	     end)

  fun noEditHeader (out : string -> unit) = 
    (out "(*  This file is auto-generated by the FI stub generator  ";
     out " *  DO NOT EDIT THIS FILE";
     out " *)\n")

  fun generateMLstubs
	(sigStream, structStream, sizeOfC) 
	(DECL_INFO {declaration, auxInfo}) = 
    let
      fun outSig s = TextIO.output (sigStream, "  " ^ s ^ "\n")
      fun outStr s = TextIO.output (structStream, "  " ^ s ^ "\n")

      fun outSigStructUnion isUnion (sName, mList) = 
	let
	  fun outSigMemAddr (mName, cType, mType, size) = 
	    outSig ("val "^sName^"'"^mName^"'addr : "^sName^" -> " ^mType^ " c_ptr")
	  fun outSigMemVals (mName, cType, mType, size) = 
	    outSig ("val "^sName^"'"^mName^" : "^sName^" -> " ^mType)
	in
	  outSig "";
	  outSig ("val " ^sName^ "'size' : word");
	  outSig ("val " ^sName^ "'addr' : " ^sName^ " -> " ^sName^ " c_ptr");
	  outSig ("structure " ^sName^ "'CPtr : MLWORKS_C_POINTER");
	  if not(isUnion) then 
	    (outSig "";
	     outSig ("(* addresses of " ^sName^ " members *)");
	     app outSigMemAddr (getStructMembers auxInfo))
	  else ();
	  outSig "";
	  outSig ("(* values of " ^sName^ " members *)");
	  app outSigMemVals (getStructMembers auxInfo)
	end

      fun getDerefFun (CintT (us, width)) = 
	  (case (us, width) of 
	     (UNSIGNED, SHORT) => "C'.UshortPtr.!"
	   | (UNSIGNED, INT)   => "C'.UintPtr.!"
	   | (UNSIGNED, LONG)  => "C'.UlongPtr.!"
	   | (SIGNED, SHORT)   => "C'.ShortPtr.!"
	   | (SIGNED, INT)     => "C'.IntPtr.!"
	   | (SIGNED, LONG)    => "C'.LongPtr.!"
	   | (_, BITS n) => error "Sorry, bitfields not yet implemented")
	| getDerefFun CaddrT = "C'.PtrPtr.!"
	| getDerefFun CvoidT = error "No dereference function for CvoidT"
	| getDerefFun (CcharT us) = 
	    if (us = UNSIGNED) then "C'.UcharPtr.!" else "C'.CharPtr.!"
	| getDerefFun CdoubleT = "C'.DoublePtr.!"
	| getDerefFun CfloatT = "C'.DoublePtr.!"
	| getDerefFun (CptrT t) = "C'.PtrPtr.!"
	| getDerefFun (CstructT s) = s ^ "'CPtr.!"
	| getDerefFun (CunionT u) = u ^ "'CPtr.!"
	| getDerefFun (CarrayT a) = "C'.PtrPtr.!"
	| getDerefFun (CfunctionT f) = error "No dereference function for CfunctionT"
	| getDerefFun (CconstT t) = getDerefFun t

      fun outStrStruct (sName, mList) = 
	let
	  fun outStrMemAddr (mName, mType, accSizeStr) = 
	    (outStr ("val "^sName^"'"^mName^"'addr : "^sName^" -> " ^mType^ " c_ptr = ");
	     outStr ("  C'.fromVoidPtr o scale'' 0w" ^accSizeStr^ " o " ^sName^ "'toRep'"))

	  fun outStrMemVals (mName, mCtype, mType, size) = 
	    (outStr ("val "^sName^"'"^mName^" : "^sName^" -> " ^mType^ " = ");
	     outStr ("  " ^getDerefFun(mCtype) ^" o " ^sName^ "'" ^mName^ "'addr"))

	  fun strAddrs [] n = []
	    | strAddrs ((mName, cType, mType, size)::rest) n = 
		(outStrMemAddr (mName, mType, i2s n);
		 strAddrs rest (n+size))
	  val sInfo = getStructMembers auxInfo

	  val accSizeStr = i2s (foldl (op +) 0 (map (#4) sInfo))
	in
	  outStr "";
	  outStr ("fun " ^sName^ "'toRep' (" ^sName^ "_S addr) = addr");
	  outStr ("val " ^sName^ "'size' : Word.word = 0w" ^accSizeStr);
	  outStr ("val " ^sName^ "'addr' : " ^sName^ " -> " ^sName^ " c_ptr = ");
	  outStr ("  C'.fromVoidPtr o " ^sName^ "'toRep'");
	  outStr ("structure " ^sName^ "'CPtr = MLWorksCPointer(");
	  outStr ("  type value = " ^sName);
	  outStr ("  val size = " ^sName^ "'size'");
	  outStr ("  val addr = " ^sName^ "'addr');");
	  outStr "";
	  outStr ("(* addresses of " ^sName^ " members *)");
	  ignore (strAddrs sInfo 0);
	  outStr "";
	  outStr ("(* values of " ^sName^ " members *)");
	  app outStrMemVals sInfo
	end

      fun outStrUnion (uName, mList) = 
	let
	  fun outStrMemVals (mName, mCtype, mType, size) = 
	    (outStr ("val " ^uName^ "'" ^mName^ " : " ^uName^ " -> " ^mType^ " = ");
	     outStr ("  " ^getDerefFun(mCtype) ^" o C'.fromVoidPtr o "^uName^ "'toRep'"))
	  fun max (a,b) = if a>b then a else b
	  val sInfo = getStructMembers auxInfo
	  val maxSizeStr = i2s (foldl max 0 (map (#4) sInfo)) 
	in
	  outStr "";
	  outStr ("fun " ^uName^ "'toRep' (" ^uName^ "_U addr) = addr");
	  outStr ("val " ^uName^ "'size' : Word.word = 0w" ^maxSizeStr);
	  outStr ("val " ^uName^ "'addr' : " ^uName^ " -> " ^uName^ " c_ptr = ");
	  outStr ("  C'.fromVoidPtr o " ^uName^ "'toRep'");
	  outStr ("structure " ^uName^ "'Cptr = MLWorksCPointer(");
	  outStr ("  type value = " ^uName);
	  outStr ("  val size = " ^uName^ "'size'");
	  outStr ("  val addr = " ^uName^ "'addr');");
	  outStr "";
	  outStr ("(* values of " ^uName^ " members *)");
	  app outStrMemVals sInfo
	end

      fun outTopLevel (name, ct, const) = 
	(outSig ""; outStr "";
	 outSig ("val " ^name^ " : " ^ ct);
	 outStr ("val MLW_GET_" ^name^ " : unit -> " ^ct^ " = ");
	 outStr ("  MLWorksDynamicLibrary.bind \"MLW_GET_" ^name^ "\"");
	 outStr ("val " ^name^ " : " ^ct^ " = MLW_GET_" ^name^ "()"))

      fun replaceD (s, argName) = 
	String.translate (fn c => if c=(#"$") then argName else String.str c) s 

      fun outDecl (Cdecl (functName, CfunctionT (args, result))) = 
	  let 
	    fun getFstr [] = "unit"
	      | getFstr [oneArg] = oneArg
	      | getFstr (a::rest) = a ^ " * " ^ getFstr(rest)

	    fun getFnStr (ins, outs) = getFstr(ins) ^ " -> " ^ getFstr(outs)

	    val (fnIns, fnOuts) = getFnInfo auxInfo
	    val rawFunctStr = getFnStr (fnIns, fnOuts)

	    fun doOuts () = 
	      case result of 
	          (Normal t) => 
		       (outSig ("val " ^functName^ " : " ^rawFunctStr);
			outStr ("val " ^functName^ " : " ^rawFunctStr^ " = ");
			outStr ("  MLWorksDynamicLibrary.bind \"" ^functName^ "\""))
		| (Exception (t, condStr, raiseStr)) =>
		    let 
		      val fName = functName^ "_raw" 
		      val fStr = getFnStr (fnIns, tl fnOuts)
		      val resVar = functName^ "_result"
		      val argsVar = functName^ "_args"
		      fun getUniqueArgs [] n = ""
			| getUniqueArgs [oneArg] n = "out" ^ i2s n
			| getUniqueArgs (arg::rest) n = 
				"out" ^ (i2s n) ^ ", " ^ getUniqueArgs rest (n+1)
		      val resStr = 
			case fnOuts of
			    [] => error "No return value to test for success"
			  | [oneResult] => resVar
			  | (a::rest) => "(" ^resVar^ ", " ^ getUniqueArgs rest 1 ^ ")"
		    in
		      outSig ("val " ^functName^ " : " ^fStr);
		      outStr ("local");
		      outStr ("  val " ^fName^ " : " ^rawFunctStr^ " = ");
		      outStr ("    MLWorksDynamicLibrary.bind \"" ^functName^ "\"");
		      outStr ("in");
		      outStr ("  fun " ^functName^ " " ^argsVar^ " = ");
		      outStr ("    let val " ^resStr^ " = " ^fName^ "(" ^argsVar^ ")");
		      outStr ("    in");
		      outStr ("      if (" ^ replaceD(condStr, resVar) ^ ") then");
		      outStr ("        raise (" ^ replaceD(raiseStr, resVar) ^ ")");
		      outStr ("      else (" ^ getUniqueArgs (tl fnOuts) 1 ^ ")");
		      outStr ("    end");
		      outStr ("end")
		    end
	  in
	    outSig ""; outStr "";
	    doOuts ()
	  end

	| outDecl (Cdecl (intName, CintT (us, typeOfInt))) = 
	    outTopLevel (intName, getMLtype (CintT (us, typeOfInt)), false)
	| outDecl (Cdecl (charName, CcharT us)) = 
	    outTopLevel (charName, getMLtype (CcharT us), false)
	| outDecl (Cdecl (doubleName, CdoubleT)) = 
	    outTopLevel (doubleName, getMLtype (CdoubleT), false)
	| outDecl (Cdecl (floatName, CfloatT)) =
	    outTopLevel (floatName, getMLtype (CfloatT), false)
	| outDecl (Cdecl (ptrName, CptrT t)) = 
	    outTopLevel (ptrName, getMLtype (CptrT t), false)
	| outDecl (Cdecl (structName, CstructT sName)) = (* used to declare different types *)
	    outTopLevel (structName, sName, false)
	| outDecl (Cdecl (unionName, CunionT uName)) =
	    outTopLevel (unionName, uName, false)
	| outDecl (Cdecl (arrayName, CarrayT (intOpt, t))) = 
	    outTopLevel (arrayName, getMLtype (CarrayT (intOpt, t)), false)	    
	| outDecl (Cdecl (constName, CconstT t)) = 
	    outDecl (Cdecl (constName, t))
	| outDecl (Cdecl (name, t)) = 
	    error ("Cannot have top level declaration: " ^name)

	| outDecl (CstructD s) = (outSigStructUnion false s; outStrStruct s)
	| outDecl (CunionD u) = (outSigStructUnion true u; outStrUnion u)
	| outDecl (CexnD exnStr) = 
	  let val eStr = "exception " ^exnStr
	  in
	    outSig ""; outStr "";
	    outSig eStr; outStr eStr
	  end
	| outDecl (MLcoerceD (d, ds)) = error "coercions not implemented yet"

    in
      outDecl declaration
    end

  fun outMLstubs (mlName, decls, stage) = 
    let
      val stageStr = "." ^ i2s stage
      val mlSig = TextIO.openOut (mlName ^ stageStr ^ ".sml")
      val mlStruct = TextIO.openOut ("__" ^mlName^ stageStr^ ".sml")

      fun outSig s = TextIO.output (mlSig, s ^ "\n")
      fun outStr s = TextIO.output (mlStruct, s ^ "\n")

      fun sigHeader () = 
	(outSig ("require \"$.foreign.mlworks_c_pointer\";");
	 outSig ("require \"$.foreign.mlworks_c_interface\";");
	 outSig ("\nsignature " ^mlName^ "_SIG = ");
	 outSig "sig";
	 outSig "  structure C' : MLWORKS_C_INTERFACE")

      fun structHeader () = 
	(outStr "require \"$.basis.__word\";";
	 outStr "require \"$.foreign.__mlworks_dynamic_library\";";
	 outStr "require \"$.foreign.__mlworks_c_interface\";";
	 outStr "require \"$.foreign._mlworks_c_pointer\";";
	 outStr ("require \"" ^mlName^ "\";");
	 outStr ("require \"__" ^mlName^ "_stub\";");
	 outStr "";
	 outStr ("structure " ^mlName^ " : " ^mlName^ "_SIG = ");
	 outStr "struct";
	 outStr "  structure C' = MLWorksCInterface;\n")

      fun outTypes [] = ()
	| outTypes ((t, assignT)::ts) = 
	    (if t = "c_double" then outSig ("  type " ^t)  (* not an equality type *)
	     else outSig ("  eqtype " ^t);
	     outStr ("  " ^assignT);
	     outTypes ts)

    in
      app noEditHeader [outSig, outStr];
      sigHeader();
      structHeader();
      outTypes (!typeList);
      outSig "\n  val closeLibrary : unit -> unit";
      outStr "\n  fun closeLibrary() = ";
      outStr ("    MLWorksDynamicLibrary.closeLibrary(" ^mlName^ "Lib, NONE)");
      outStr "\n  fun scale'' offset addr = C'.next (addr, offset)";
      app (generateMLstubs (mlSig, mlStruct, sizeOfC)) decls;
      outSig "end";
      outStr "end";
      TextIO.closeOut mlSig;
      TextIO.closeOut mlStruct
    end

  fun getOutConv (tag1, tag2') = 
    let val tag2 = if tag2' = "" then tag1 else tag2'
    in "mlw_ci_" ^ tag1 ^ "_from_" ^tag2
    end

  fun getInConv (tag1, tag2') = 
    let val tag2 = if tag2' = "" then tag1 else tag2'
    in "mlw_ci_" ^ tag1 ^ "_from_" ^tag2
    end

  fun getConv (tag1, tag2') = 
    let 
      val tag2 = if tag2' = "" then tag1 else tag2'
      val pre = "mlw_ci_" ^ tag1
    in 
      (pre^ "_to_" ^tag2, pre^ "_from_" ^tag2)
    end


  fun generateCstub 
	stream 
	(DECL_INFO {declaration = Cdecl (functName, CfunctionT (args, result)), ...}) = 
    let
      fun out s = TextIO.output (stream, s ^ "\n")

	(* get_result_info only interested in C type not in whether the return 
	 * value is used to test for success.  Success testing is done in ML. *)
      val get_result_info = getResultCtype
      val isResult = (getResultCtype(result) <> CvoidT)

      fun getFstr f = 
	"mlw_ci_register_function(\"" ^ f ^ "\", mlw_stub_" ^ f ^ ");"

      fun getCargs [] n = ""
	| getCargs [CptrAT (t, io)] n = 
	    (case t of 
		CarrayT(_) => "cArg" ^ i2s n
	      | _ 	   => "&cArg" ^ i2s n)
	| getCargs [CdefaultAT t] n = "cArg" ^ i2s n
	| getCargs (arg::rest) n = 
	    (getCargs [arg] n) ^ ", " ^ (getCargs rest (n+1))

      fun countInsOuts [] n = n
	| countInsOuts ((CptrAT (t, io))::rest) (ic, oc, ioc) = 
	   (case io of 
		IN     => countInsOuts rest (ic+1, oc, ioc)
	      | OUT    => countInsOuts rest (ic, oc+1, ioc)
	      | IN_OUT => countInsOuts rest (ic, oc, ioc+1))
	| countInsOuts (a::rest) (ic, oc, ioc) = (* default of IN *)
	    countInsOuts rest (ic+1, oc, ioc)

      val (nIns, nOuts, nInsOuts) = countInsOuts args (0, 0, 0)

      datatype cparam = 
	C_PARAM of {argName: string,
		    argType: string, 
		    inConv: string,
		    outConv: string,
		    declarations: string list,
		    copyCode: string list}

      fun mkSimpArg (typeStr, (inConv, outConv), numStr) = 
	C_PARAM {argName= "cArg" ^ numStr, 
	 	 argType=typeStr, 
	 	 inConv = inConv, outConv = outConv,
	 	 declarations=[], copyCode=[]}

      fun newTypeConv (C_PARAM {argName, argType, inConv, outConv, 
				declarations, copyCode}, t, (inC, outC)) = 
	  C_PARAM {argName=argName, argType=t, inConv=inC, outConv=outC, 
	   	   declarations=declarations, copyCode=copyCode}

      fun get_arg_c (argNo, cType, isReturn) = 
	case cType of 
	   CvoidT => mkSimpArg ("void", ("", ""), argNo)
	 | CaddrT => mkSimpArg ("void *", getConv("void_ptr", "voidp"), argNo)
	 | CintT (us, typeOfInt) => 
	    (case (us, typeOfInt) of
	       (UNSIGNED, SHORT) =>  
		  mkSimpArg ("unsigned short", getConv("ushort", ""), argNo)
	     | (UNSIGNED, INT) => 
		  mkSimpArg ("unsigned int", getConv("uint", ""), argNo)
	     | (UNSIGNED, LONG) => 
		  mkSimpArg ("unsigned long", getConv("ulong", ""), argNo)
	     | (SIGNED, SHORT) =>  mkSimpArg ("short", getConv("short", ""), argNo)
	     | (SIGNED, INT) => mkSimpArg ("int", getConv("int", ""), argNo)
	     | (SIGNED, LONG) => mkSimpArg ("long", getConv("long", ""), argNo)
	     | (_, BITS n) => error "Sorry, bitfields not yet implemented")
	 | CdoubleT => mkSimpArg ("double", getConv("real", "double"), argNo)
	 | CfloatT => 
	    mkSimpArg ("float", getConv("real", "double"), argNo)
	 | CcharT us => 
	    if (us = UNSIGNED) then 
	      mkSimpArg ("unsigned char", getConv("uchar", ""), argNo)
	    else 
	      mkSimpArg ("char", getConv("char", ""), argNo)
	 | CptrT t =>
	    (case t of 
		CstructT sName => 
		  let val C_PARAM {argType,inConv,outConv,...} = 
			get_arg_c(argNo, t, isReturn)
		  in mkSimpArg (argType, (inConv, outConv), argNo)
		  end
	      | CcharT SIGNED => 
		  mkSimpArg ("char *", getConv("char_ptr", "charp"), argNo)
	      | CcharT UNSIGNED => 
		  mkSimpArg ("unsigned char *", getConv("char_ptr", "charp"), argNo)
	      | _ => 
		let 
		  val ptrArg = get_arg_c (argNo, t, isReturn)
		  val (C_PARAM {argType, ...}) = ptrArg
	    	in
		  newTypeConv (ptrArg, argType ^ " *", getConv("void_ptr", "voidp"))
	    	end)
	 | CarrayT (intOpt, t) => get_arg_c (argNo, CptrT t, isReturn)  

	  (* Need to be able to tell whether the arg is a ptr or not *)
	 | CstructT sName => 
	     let
	       val argVar = "cArg" ^ argNo
	       val structVar = sName ^ argNo
	       val argType = sName ^ " *"
	       val cpCode = 
		 if isReturn then 
		   ["  if (("^structVar^" = malloc(sizeof("^sName^"))) == ("^argType^")0)",
		    "    mlw_ci_raise_syserr(errno);",
		    "  memcpy(" ^structVar^ ", &result, sizeof(" ^sName^ "));"]
		 else 
		   ["  memcpy(&" ^argVar^ ", " ^structVar^ ", sizeof(" ^sName^ "));"]
	       val declarations = 
		 if isReturn then 
		   ["  " ^sName ^ " result;",
		    "  " ^argType^ " " ^structVar^ ";"]
		 else
		   ["  " ^sName^ " " ^argVar^ ";"]

	       val (inConv, outConv) = getConv("void_ptr", "voidp")
	     in
	       C_PARAM
		{argName = structVar,
		 argType = argType,
		 inConv = inConv,
		 outConv = outConv,
		 declarations = declarations,
		 copyCode = cpCode}
	     end

	 | CunionT uName => get_arg_c (argNo, CstructT uName, isReturn)
	 | CconstT t => 
	    let 
	      val constArg = get_arg_c (argNo, t, isReturn)
	      val (C_PARAM {argType, inConv, outConv, ...}) = constArg
	    in 
	      newTypeConv (constArg, "const " ^ argType, (inConv, outConv))
	    end
	 | CfunctionT _ => 
	     error "Cannot handle functions within functions"

      val returnInfo = 
	if isResult then 
	  let
	    val C_PARAM {argType, argName, declarations, copyCode, inConv, outConv} = 
		get_arg_c ("Res", get_result_info result, true)
	    val decls = 
		  if (declarations = []) then (* means return value not declared *)
	            ["  " ^argType^ " result;"]
		  else declarations
	    val name = if (declarations = []) then "result" else argName
	  in
	    SOME (C_PARAM {argType=argType, argName=name, declarations=decls, 
		  copyCode=copyCode, inConv=inConv, outConv=outConv})
	  end
	else NONE

      fun get_arg_info (CptrAT (t, io), n, (nIn,nOut)) = 
	  let 
	    val C_PARAM {argName, argType, inConv, outConv, declarations, 
	 	         copyCode} = get_arg_c (i2s n, t, false)
	    val mlArgField = 
	      if ((nIns + nInsOuts) = 1) then "arg"
	      else "mlw_arg(arg, " ^ i2s nIn ^ ")"
	    val inDecl = "  " ^argType^ " " ^argName^ " = (" ^argType^ ")" ^inConv^ 
			  "(" ^ mlArgField ^ ");"
	    val mlArg = "mlArg" ^ i2s n
	  in 
	    case io of 
	       IN  => (* should not call get_arg_info recursively as inDecl is different *)
		 (inDecl::declarations, copyCode, [], [])
	     | OUT => 
		let 
		  val (argTypeD, valueOf) = 
		    (case t of
		        CstructT sName => (sName, "")
		      | CunionT uName => (uName, "")
		      | CarrayT (SOME i, aType) => 
			  (String.substring(argType, 0, String.size(argType) - 2), "")
		      | _ => (argType, "*"))
		  val argName = "cArg" ^ i2s n
		  val ptrArgName = argName ^ "ptr"
		  val (argDecl, mallocStr, memcpyStr) = 
		    (case t of 
			CarrayT (SOME i, aType) => 
			  let val allocSize = "sizeof(" ^argTypeD^ ") * " ^ i2s i
			  in
			    ("  "^argTypeD^" "^argName^"["^ i2s i ^ "];", 
			     "malloc(" ^allocSize^ ")",
			     "  memcpy(" ^ptrArgName^ ", " ^argName^ ", " ^allocSize^ ");")
			  end
		      | _ => ("  "^argTypeD^ " " ^argName^ ";", 
			      "malloc(sizeof(" ^argTypeD^ "))",
			      "  memcpy("^ptrArgName^", &"^argName^", sizeof("^argTypeD^"));"))
		in
		  (["  mlw_val "^mlArg^";", 
		     argDecl,
		     "  "^argTypeD^ " *" ^ptrArgName^ ";"],
		   [],
		   ["  if (("^ptrArgName^ " = " ^mallocStr^ ") == ("^argTypeD^" *)0)",
		     "    mlw_ci_raise_syserr(errno);",
		     memcpyStr,
		     "  " ^mlArg^ " = " ^outConv^ "(" ^valueOf^ptrArgName^ ");",
		     "  declare_gc_root(" ^mlArg^ ");"],
		   ["  retract_gc_root(" ^mlArg^ ");",
		     "  mlw_val_rec_field(returnRec, " ^ i2s nOut ^ ") = " ^mlArg^ ";"])
		end
	     | IN_OUT =>
		(("  mlw_val " ^mlArg^ ";") :: inDecl :: declarations,
		 copyCode,
					(* should deref here? *)
		 ["  " ^mlArg^ " = " ^outConv^ "(" ^argName^ ");",
		    "  declare_gc_root(" ^mlArg^ ");"],
		 ["  retract_gc_root(" ^mlArg^ ");",
		    "  mlw_val_rec_field(returnRec, " ^ i2s nOut ^ ") = " ^mlArg^ ";"])
	  end

	| get_arg_info (CdefaultAT t, n, (nIn,nOut)) = 
	  let 
	    val C_PARAM {argName, argType, inConv, outConv, declarations, 
	 	         copyCode} = get_arg_c (i2s n, t, false)
	    val mlArgField = 
	      if ((nIns + nInsOuts) = 1) then "arg"
	      else "mlw_arg(arg, " ^ i2s nIn ^ ")"
	    val inDecl = "  " ^argType^ " " ^argName^ " = (" ^argType^ ")" ^inConv^ 
			 "(" ^ mlArgField ^ ");"
	  in 
	    (inDecl::declarations, copyCode, [], [])
	  end

      val nReturns = if isSome(returnInfo) then 1 else 0
      val totalOuts = nOuts + nInsOuts

      fun getArgsInfo [] ns = []
	| getArgsInfo ((CptrAT (t, io), n)::rest) (nIn, nOut) = 
	    let 
	      val ins = if io=OUT then nIn else nIn+1
	      val outs = if io=IN then nOut else nOut+1
	      val argsInfo = getArgsInfo rest (ins, outs)
	    in
	      (get_arg_info (CptrAT(t,io), n, (nIn, nOut))) :: argsInfo
	    end
	| getArgsInfo ((CdefaultAT t, n)::rest) (nIn,nOut) = 
	    (get_arg_info (CdefaultAT t, n, (nIn,nOut))) :: (getArgsInfo rest (nIn+1, nOut))

      fun arg_iterate [] = ([],[])
	| arg_iterate args = 
	let
	  val (argsNlist, nArgs) = Lists.number_from_by_one (args, 0, fn f => f)
	  val argsInfo = getArgsInfo argsNlist (0, nReturns)

	  fun outputArg ([], declList, preInvoke, postInvoke, postAllocRec, n) = 
		(app out (rev declList); 
		 if totalOuts > 0 then 
		   out "  mlw_val returnRec, mlResult;"
		 else ();
		 app out (rev preInvoke);
		 (postInvoke, postAllocRec))
	    | outputArg ((decls, preInv, postInv, postAlloc) :: otherArgs, 
			decList, preInvL, postInvL, postAllocL, n) = 
		outputArg (otherArgs, decls @ decList, preInv @ preInvL, 
			   postInv @ postInvL, postAlloc @ postAllocL, n+1)
	in
	  outputArg (argsInfo, [], [], [], [], 0)
	end

      val applyStr = 
        if isResult then "result = " ^functName^ "(" ^ (getCargs args 0) ^ ");"
        else functName^ "(" ^ (getCargs args 0) ^ ");"

      fun outFunction () = 
	let 
	  val (postInvoke, postAlloc) = arg_iterate args
	in
	  out ("  " ^ applyStr);
	  case returnInfo of 
	      NONE => 
		if totalOuts > 0 then
		  (app out postInvoke;
		   out ("  returnRec = mlw_ci_tuple_make(" ^ i2s totalOuts ^");");
		   app out postAlloc;
		   out ("  return returnRec;"))
		else
		  out "  return mlw_val_unit;"
	    | SOME (C_PARAM {argName, outConv, copyCode, ...}) =>
		if totalOuts > 0 then
		  (app out copyCode;
		   app out postInvoke;
		   out ("  mlResult = " ^outConv^ "(" ^argName^ ");");
		   out ("  declare_gc_root(mlResult);");
		   out ("  returnRec = mlw_ci_tuple_make(" ^ i2s (totalOuts+1) ^");");
		   out ("  retract_gc_root(mlResult);");
		   out ("  mlw_val_rec_field(returnRec, 0) = mlResult;");
		   app out postAlloc;
		   out ("  return returnRec;"))
		else
		  (app out copyCode;
		   out ("  return " ^outConv^ "(" ^argName^ ");"))
	end

    in
      out "";
      out ("static mlw_val mlw_stub_" ^ functName ^ "(mlw_val arg)");
      out "{";
      case returnInfo of 
	  NONE => ()
	| SOME (C_PARAM {declarations, ...}) => app out declarations;
      outFunction();
      out "}";
      out "";
      getFstr functName
    end (* generateCstub *)

    (* just to get rid of compiler warnings, but should never happen - see uses of *)
    | generateCstub stream d = error "Invalid function declaration"

  fun genConstCstub ((out : string -> unit), name, t, conv_fn) =
    let
      val fName = "mlw_stubc_get_" ^ name
      val strUnOpt = 
	(case t of CstructT sName => SOME sName
		| CunionT uName => SOME uName
		| _ => NONE)
      val globalVar = 
	(case strUnOpt of 
	    SOME sName => ("\nstatic " ^sName^ " MLW_" ^name^ " = " ^name^ ";")
	  | NONE => "")
    in
      out ("\n" ^globalVar);
      out ("static mlw_val " ^fName^ "(mlw_val arg)");
      out "{";
      out ("  return " ^conv_fn^ "(" ^ (if isSome(strUnOpt) then "&MLW_" else "") ^name^ ");");
      out "}";
      "mlw_ci_register_function(\"MLW_GET_" ^name^ "\", " ^fName^ ");"
    end

  fun outCstub (c_name, c_headers, decls, stage) = 
    let
      val stageStr = "." ^ i2s stage
      val stream = TextIO.openOut (c_name ^ "_stub" ^stageStr^ ".c")
      fun out s = TextIO.output (stream, s ^ "\n")

      fun outOneDecl d (name, CfunctionT _) = generateCstub stream d
	| outOneDecl d (name, t as CintT (us, typeOfInt)) = 
	  (case (us, typeOfInt) of
	      (UNSIGNED, SHORT) => genConstCstub (out, name, t, getOutConv("ushort", ""))
     	    | (UNSIGNED, INT) =>   genConstCstub (out, name, t, getOutConv("uint", ""))
     	    | (UNSIGNED, LONG) =>  genConstCstub (out, name, t, getOutConv("ulong", ""))
     	    | (SIGNED, SHORT) =>   genConstCstub (out, name, t, getOutConv("short", ""))
	    | (SIGNED, INT) =>     genConstCstub (out, name, t, getOutConv("int", ""))
	    | (SIGNED, LONG) =>    genConstCstub (out, name, t, getOutConv("long", ""))
	    | (_, BITS n) => error "Sorry, bitfields not yet implemented")
	| outOneDecl d (name, t as CcharT us) = 
	    if (us = UNSIGNED) then
	      genConstCstub (out, name, t, getOutConv("uchar", ""))
	    else
	      genConstCstub (out, name, t, getOutConv("char", ""))
	| outOneDecl d (name, t as CarrayT a) = 
	    genConstCstub (out, name, t, getOutConv("void_ptr", "voidp"))
	| outOneDecl d (name, CdoubleT) = 
	    genConstCstub (out, name, CdoubleT, getOutConv("real", "double"))
	| outOneDecl d (name, CfloatT) = 
	    genConstCstub (out, name, CfloatT, getOutConv("real", "double"))
	| outOneDecl d (name, t as CptrT p) = 
	    genConstCstub (out, name, t, getOutConv("void_ptr", "voidp"))
	| outOneDecl d (name, CconstT t) = outOneDecl d (name, t)
	| outOneDecl d (name, CvoidT) = error "Top level void value not allowed"
	| outOneDecl d (name, CaddrT) = error "Top level address value not allowed"
	| outOneDecl d (name, CstructT s) = 
		(* used to define other types, eg. HWND *)
	    genConstCstub (out, name, CstructT s, getOutConv("void_ptr", "voidp"))
	| outOneDecl d (name, CunionT u) = 
	    genConstCstub (out, name, CunionT u, getOutConv("void_ptr", "voidp"))

      fun outTopLevel [] = []
	| outTopLevel ((d as DECL_INFO {declaration, ...})::rest) = 
	  (case declaration of 
	      Cdecl (name, t) => (outOneDecl d (name, t)) :: (outTopLevel rest)
	    | MLcoerceD coercedD => error "Coercions not implemented yet"
	    | _ => outTopLevel rest)

      val _ = 
	(out "/*  This file is auto-generated by the FI stub generator  ";
	 out " *  DO NOT EDIT THIS FILE";
	 out " */";
	 out "";
	 app (fn s => out ("#include " ^ s)) c_headers;
	 out "#include <errno.h>";
	 out "#include \"mlw_ci.h\"";
	 out "")

      val functionStrings = outTopLevel decls

    in
      out ("mlw_ci_export void mlw_stub_init_" ^c_name^ "(void)");
      out "{";
      app (fn s => out ("  " ^ s)) functionStrings;
      out "}";
      TextIO.closeOut stream
    end

  local

    fun mkFunctionDecl (stage, declName, args, result) = 
      let
        val newArgs = if stage >= 2 then args
		      else map (fn arg => CdefaultAT (arg2ctype arg)) args
        val newResult = if stage >= 2 then result
		        else (Normal (getResultCtype result))
	val newDecl = Cdecl (declName, CfunctionT (newArgs, newResult))
      in
	mkDeclInfo (newDecl, getFunctionType (newArgs, newResult), NONE)
      end

    fun setStructInfo [] = SOME []
      | setStructInfo ((n,t)::rest) = 
	  case setStructInfo(rest) of
	     NONE => error "Problem setting struct info"
	   | SOME sInfo => SOME ((n, t, addMLtype t, 0) :: sInfo)

    fun shuffleStrUn ([], l) = l
      | shuffleStrUn (decls, l) = 
	let
	  fun strUnMem (su, (DECL_INFO {declaration= CstructD (sName,mems), ...})::rest) = 
		su=sName orelse strUnMem(su, rest)
	    | strUnMem (su, (DECL_INFO {declaration = CunionD (uName,mems), ...})::rest) = 
	        su=uName orelse strUnMem(su, rest)
	    | strUnMem (su, []) = false
		(* should never happen but needed to get rid of compiler warning *)
	    | strUnMem (su, otherDeclType) = error "Invalid struct/union declaration"
	  fun intersect ([],l) = []
	    | intersect ((a::rest), l) = if strUnMem(a, l) then a::intersect(rest, l)
					 else intersect(rest, l)
	  fun depend (DECL_INFO {auxInfo, ...}) = getStructDependents auxInfo
	  val (consL, newDecls) = 
	    Lists.partition (fn d => intersect(depend d, decls) = []) decls
	in
	  if (consL = []) then error "Circular reference in structs/unions" else ();
	  shuffleStrUn (newDecls, consL @ l)
	end

    fun getDeclInfo st [] (exns, str'uns, cdecls) = 
	  cdecls @ shuffleStrUn(str'uns,[]) @ exns
      | getDeclInfo st ((d as Cdecl (declName, t))::rest) (exns, str'uns, cdecls) = 
          (case t of 
	      CfunctionT (args, result) => 
	        let val f = mkFunctionDecl (st, declName, args, result)
	        in
		  getDeclInfo st rest (exns, str'uns, f::cdecls)
	        end
            | other => 
	       (ignore (addMLtype t); (* Needed to add the types to the list *)
	        getDeclInfo st rest (exns, str'uns, (mkDeclInfo(d,NONE,NONE)) :: cdecls)))
      | getDeclInfo st ((d as CstructD (sName, members))::rest) (exns, str'uns, cdecls) = 
	  let val newS = mkDeclInfo (d, NONE, setStructInfo members)
	  in getDeclInfo st rest (exns, newS::str'uns, cdecls)
	  end
      | getDeclInfo st ((d as CunionD (uName, members))::rest) (exns, str'uns, cdecls) = 
	  let val newU = mkDeclInfo (d, NONE, setStructInfo members)
	  in getDeclInfo st rest (exns, newU::str'uns, cdecls)
	  end
      | getDeclInfo st ((d as (CexnD s))::rest) (exns, str'uns, cdecls) = 
	  getDeclInfo st rest ((mkDeclInfo (d, NONE, NONE))::exns, str'uns, cdecls)
      | getDeclInfo st ((d as MLcoerceD (decl, declStr))::rest) (es, su, ds) = 
	  error "Type coercion not implemented yet"

  in

    type stubDetails = 
	{name: string,
	 input: cdecl list,
	 c_headers: string list,
	 c_lib_name: string,
	 ann_fn_args: bool}

    fun generateStubs {name, input, c_headers, c_lib_name, ann_fn_args} = 
      let
        val stream = TextIO.openOut ("__" ^name^ "_stub.sml")
        fun out s = TextIO.output (stream, s ^ "\n")

        fun outStubs 0 = ()
	  | outStubs n = 
	    let val decls = getSizes (getDeclInfo n input ([],[],[])) [] 
	    in
	      outCstub (name, c_headers, decls, n);
	      outMLstubs (name, decls, n); 
	      outStubs (n-1)
	    end

        val applStr = "val " ^name^ "Lib = MLWorksDynamicLibrary.openLibrary (\""
	val stage1files = [name ^ ".1.sml", "__" ^ name ^ ".1.sml", name ^ "_stub.1.c"]
	val stage2files = [name ^ ".2.sml", "__" ^ name ^ ".2.sml", name ^ "_stub.2.c"]

	fun rename (old, new) = 
	  (OS.FileSys.remove(new) handle OS.SysErr _ => ();
	   OS.FileSys.rename {old=old, new=new})

	fun renameFiles [mlSigFile, mlStrFile, cFile] = 
	  (rename (mlSigFile, name^".sml");
	   rename (mlStrFile, "__"^name^".sml");
	   rename (cFile, name^"_stub.c"))
	  | renameFiles _ = error "Invalid arguments to renameFiles"

      in
        out "(*  This file is auto-generated by the FI stub generator  ";
        out " *  DO NOT EDIT THIS FILE";
        out " *)\n";
        out "require \"$.foreign.__mlworks_dynamic_library\";\n"; 

	(* Library extension is platform dependent *)
        out (applStr ^ c_lib_name ^ "\", \"mlw_stub_init_" ^name^ "\");");
        TextIO.closeOut stream;
        outStubs 2;
	if ann_fn_args then renameFiles(stage2files)
	else renameFiles(stage1files)
      end (* generateStubs *)

    fun genStubsSimple (name, input) = 
      generateStubs 
	       {name=name, 
		input=input,
		c_headers=["<" ^name^ ".h>"],
		ann_fn_args=true,
		c_lib_name=name^"_stub.dll"}

  end (* local *)

end (* struct *)
