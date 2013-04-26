(*
 Copyright (c) 1993 Harlequin Ltd.
 
 based on Revision ???
 
 Revision Log
 ------------
 $Log: machregisters.sml,v $
 Revision 1.2  1993/11/17 14:08:35  io
 Deleted old SPARC comments and fixed type errors

 *)
 
require "../utils/set";


signature MACHREGISTERS =

  sig

    structure Set	: SET

    eqtype T


    (*  == General registers ==  *)

    val gcs : T Set.Set		(* int/ptr visible to garbage collector *)
    val non_gcs : T Set.Set	(* int/ptr not visible to garbage collector *)
    val fps : T Set.Set		(* floating point registers *)


    (*  == Special purpose reserved registers ==  *)

    val fn_arg : T	(* function argument and return *)
    val cl_arg : T	(* closure pointer *)
    val fp : T		(* frame pointer *)
    val sp : T		(* stack pointer *)
    val lr : T		(* link register *)
    val handler : T	(* pointer to exception handler code *)
    val global : T	(* not affected by PRESERVE or RESTORE *)
    val gc1 : T		(* reserved for garbage collector *)
    val gc2 : T		(* reserved for garbage collector *)

    val after_preserve : T -> T
    val after_restore : T -> T

  end
