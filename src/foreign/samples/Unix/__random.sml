(*  ==== FI EXAMPLES : Random structure ====
 *
 *  Copyright (C) 1996 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This module provides ML functions to generate random numbers, using
 *  the foreign functions defined in random.c.
 *
 *  Revision Log
 *  ------------
 *  $Log: __random.sml,v $
 *  Revision 1.4  1998/04/07 19:59:33  jkbrook
 *  [Bug #30387]
 *  Date.fromTime should be replaced by Date.fromTimeLocal
 *
 *  Revision 1.3  1996/11/06  13:24:51  brianm
 *  Fixing samples.
 *
 *  Revision 1.2  1996/10/22  17:43:48  io
 *  updating naming conventions
 *
 *  Revision 1.1  1996/08/30  10:56:39  davids
 *  new unit
 *
 *
 *)


require "random";
require "$.system.__time";
require "$.basis.__date";
require "$.foreign.__interface";

structure Random : RANDOM =
  struct

    structure Store = Interface.Store
    structure CStructure = Interface.C.Structure
    structure CSignature = Interface.C.Signature
    structure CFunction = Interface.C.Function
    structure CType = Interface.C.Type
    structure CValue = Interface.C.Value

    (* Loading a Structure *)

    val random_struct = 
      CStructure.loadObjectFile ("foreign/samples/random.so", CStructure.IMMEDIATE_LOAD);
    (* the filename is relative to the current directory that MLWorks is using *)



    (* Building a store *)

    val random_store =
      Store.store {alloc    = Store.ALIGNED_4,
		   overflow = Store.BREAK,
		   size     = 60,
		   status   = Store.RDWR_STATUS};


    (* Creating objects *)

    val void_object =
      CValue.object {ctype = CType.VOID_TYPE,
		     store = random_store};

    val long_object1 =
      CValue.object {ctype = CType.LONG_TYPE,
		     store = random_store};
  
    val long_object2 =
      CValue.object {ctype = CType.LONG_TYPE,
		     store = random_store};
  
    val long_object3 =
      CValue.object {ctype = CType.LONG_TYPE,
		     store = random_store};


    (* Defining a c_signature object *)

    val random_sig = CSignature.newSignature ();


    (* Adding a new Signature entry *)

    val _ = CSignature.defEntry (random_sig,
				  CSignature.FUN_DECL 
				    {name = "random_num",
				     source = [CType.LONG_TYPE,
					       CType.LONG_TYPE],
				     target = CType.LONG_TYPE });

    val _ = CSignature.defEntry (random_sig,
				  CSignature.FUN_DECL
				    {name = "set_seed",
				     source = [CType.LONG_TYPE],
				     target = CType.VOID_TYPE });


    (* Make a `callable object' lookup function for our foreign code *)

    val def_random = 
      CFunction.defineForeignFun (random_struct, random_sig);


    (* Extract a foreign function object as an ML value *) 

    val randomFF = def_random "random_num";

    val set_seedFF = def_random "set_seed";
      

    (* Set the seed for the random number generator. *)

    fun setSeed seed =
      (CValue.setLong (long_object1, seed);
       CFunction.call set_seedFF ([long_object1], void_object))


    (* Find a random number between 'a' and 'b'. *)

    fun random (a, b) =
      (CValue.setLong (long_object1, a);
       CValue.setLong (long_object2, b);
       CFunction.call randomFF ([long_object1, long_object2], long_object3);
       CValue.getLong (long_object3))


    (* Use the current time to seed the random generator, by finding the
     current number of microseconds in the current second. *)

    fun randomize () =
      let
	val theTime = Time.now ()
	val roundedTime = Date.toTime (Date.fromTimeLocal theTime)
	val fracTime = Time.- (theTime, roundedTime)
 	val seed = Time.toMicroseconds fracTime
      in
	setSeed seed
      end

  end
