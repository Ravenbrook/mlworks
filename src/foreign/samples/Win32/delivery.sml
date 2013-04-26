
(* Test example ML FI interface code (with delivery).
 *
 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *)


require "$.basis.__int";
require "$.foreign.__interface";

(* ML FI structure mapping *)

local
   structure Aliens      = Interface.Aliens

   structure Store       = Interface.Store
   structure Structure   = Interface.C.Structure
   structure Signature   = Interface.C.Signature
   structure Function    = Interface.C.Function
   structure Type        = Interface.C.Type
   structure Value       = Interface.C.Value
in
   val ALIGNED_4     = Store.ALIGNED_4
   val BREAK         = Store.BREAK
   val RDWR_STATUS   = Store.RDWR_STATUS
   val store         = Store.store

   val loadObjectFile   = Structure.loadObjectFile
   val IMMEDIATE_LOAD   = Structure.IMMEDIATE_LOAD

   val refreshAliens    = Aliens.refreshAliens

   val newSignature = Signature.newSignature
   val defEntry = Signature.defEntry
   val FUN_DECL = Signature.FUN_DECL
     
   val defineForeignFun = Function.defineForeignFun
   val call             = Function.call

   type c_type = Type.c_type

   val INT_TYPE      = Type.INT_TYPE

   val object          = Value.object
   val setInt          = Value.setInt
   val getInt          = Value.getInt
end


(* Loading a Structure *)

   val test_struct = loadObjectFile("foreign/samples/sum.dll",IMMEDIATE_LOAD);
   (* the filename is relative to the current directory that MLWorks is using *)


(* Building a store *)

    val test_store =
          store{ alloc    = ALIGNED_4,
                 overflow = BREAK,
                 size     = 60,
                 status   = RDWR_STATUS   };


(* Creating objects *)

   val int_object1 =
         object { ctype  = INT_TYPE,
                  store  = test_store };

   val int_object2 =
         object { ctype  = INT_TYPE,
                  store  = test_store };

   val int_object3 =
         object { ctype  = INT_TYPE,
                  store  = test_store };


(* Defining a c_signature object *)

   val test_sig = newSignature ();


(* Adding a new Signature entry *)

     defEntry(test_sig,
	      FUN_DECL { name = "sum",
                        source = [INT_TYPE, INT_TYPE] : c_type list,
                        target = INT_TYPE }
            );


(* Make a `callable object' lookup function for our foreign code *)

   val def_test = defineForeignFun( test_struct, test_sig );


(* Extract a foreign function object as an ML value *) 

   val sum = def_test "sum";;


(* Define a function using a foreign function *)

fun testWrapper (i, j) =
    (

      (* Pack the arguments *)
      setInt (int_object1, i);
      setInt (int_object2, j);

      (* Call the foreign function *)
      call sum ( [int_object1, int_object2], int_object3 );

      (* Extracting the result data *)
      getInt(int_object3)
    );

(* Define the top level function *)

fun topLevel () =
    (
      (* reestablish the foreign code *)
      refreshAliens ();

      (* call foreign function *)
      print (Int.toString (testWrapper (23, 19)));
      ()
    );

(* Now deliver an executable that just runs the topLevel function and exits *)

MLWorks.Deliver.deliver ("deliverTest", topLevel, true);

