(*
	ML description of input to the stub generator to produce a C stub
	file together with the ML signature and structure.  This file 
	describes the interface for the ndbm example.
*)

require "../__stub_gen_input";
require "__stub_gen";

local 

  open StubGenInput

  val --> = CfunctionT
  infix 2 -->
  val op * = CptrT
  nonfix *
  val :- = Cdecl
  infix 1 :-
  val A = CdefaultAT 	(* Default argument declaration *)
  val N = Normal 		(* Result type *)

  val CstringT = CarrayT (NONE, CcharT SIGNED)

  val c_int = CintT (SIGNED, INT)
  val c_uint = CintT (UNSIGNED, INT)
  val c_long = CintT (SIGNED, LONG)
  val c_char = CcharT SIGNED

  val DBM = 	CstructT "DBM"		(* used to generate C stubs - needs *)
  val datum = 	CstructT "datum"	(* to be same as in C header file *)

in
  val input = 
	[CstructD ("datum", 
                   [("dptr",   *c_char), 
                    ("dsize",  c_uint)]),
	 CstructD ("DBM", 
		   [("dirf",   c_int), 
		    ("pagf",   c_int),
		    ("flags",  c_int),
		    ("maxbno", c_long),
		    ("bitno",  c_long),
		    ("hmask",  c_long),
		    ("blkptr", c_long),
		    ("keyptr", c_int),
		    ("blkno",  c_long),
		    ("pagno",  c_long),
		    ("pagbuf", CarrayT (SOME 1024, c_char)),
		    ("dirbno", c_long),
		    ("dirbuf", CarrayT (SOME 4096, c_char))]),
	  CexnD "DeleteError of int",
	  CexnD "StoreError of int",

	 "DBM_INSERT"  :- c_int,
	 "DBM_REPLACE" :- c_int,

	 "dbm_open"     :- [A CstringT, A c_int, A c_int] --> N ( *DBM),
	 "dbm_close"    :- [A ( *DBM)]			--> N CvoidT,
	 "dbm_fetch"    :- [A ( *DBM), A datum]		--> N datum,
	 "dbm_delete"   :- [A ( *DBM), A datum]	       	-->
 			Exception (c_int, "$ < 0", "DeleteError $"),
	 "dbm_store"    :- [CptrAT (DBM, IN_OUT), A datum, A datum, A c_int]  --> 
			Exception (c_int, "$ < 0", "StoreError $"),
	 "dbm_firstkey" :- [A ( *DBM)]		     	--> N datum,
	 "dbm_nextkey"  :- [A ( *DBM)] 		     	--> N datum]


  fun genNdbmFiles () = 
	StubGen.generateStubs
	       {name="ndbm", 
		input=input, 
		c_lib_name="ndbm_stub.so", 
		c_headers=["<ndbm.h>"], 
		ann_fn_args=true}

end

