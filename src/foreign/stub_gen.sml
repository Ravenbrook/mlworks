(*
 * Copyright (C) 1999.  Harlequin Group plc.  All rights reserved.
 * 
 * Stub Generator signature for FI.
 *
 * Revision Log
 * ------------
 * $log$
 *
 *)

require "__stub_gen_input";

signature STUB_GEN = 
sig

  type cdecl = StubGenInput.cdecl

  type stubDetails = 
	{name: string,
	 input: cdecl list,
	 c_headers: string list,
	 c_lib_name: string,
	 ann_fn_args: bool}

  val generateStubs : stubDetails -> unit

  val genStubsSimple : string * cdecl list -> unit

end