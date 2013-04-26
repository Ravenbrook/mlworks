(* ***********************************************************************

   Project: sml/Tk: an Tk Toolkit for sml
   Author: Stefan Westmeier, University of Bremen
  $Date: 1999/06/16 09:53:18 $
  $Revision: 1.1 $
   Purpose of this file: Functions related to Text Widget Annotations 
                         in Widget Tree

   *********************************************************************** *)

require "basic_types";

signature ANNOTATION_TREE =
    sig
	exception ANNOTATION_TREE of string

	val get : BasicTypes.WidId      -> 
	          BasicTypes.AnnId      -> 
		  BasicTypes.Annotation

	val upd : BasicTypes.WidId      -> 
	          BasicTypes.AnnId      -> 
		  BasicTypes.Annotation -> 
		  unit

	val add    : BasicTypes.WidId      ->        (* inWid *)
	             BasicTypes.Annotation ->        (* toAdd *)
		     unit
(*
	val insert : BasicTypes.WidId       ->       (* inWid *)
	             BasicTypes.Annotation  ->       (* toAdd *)
		     BasicTypes.AnnId       ->       (* after *)
		     unit
 *)

	val delete : BasicTypes.WidId   ->           (* inWid *)
	             BasicTypes.AnnId   ->           (* toDel *)
		     unit



	val getConfigure  : BasicTypes.WidId         -> 
	                    BasicTypes.AnnId         -> 
			    BasicTypes.Configure list
	val addConfigure  : BasicTypes.WidId          -> 
	                    BasicTypes.AnnId          -> 
			    BasicTypes.Configure list -> 
			    unit

	val getBinding    : BasicTypes.WidId        -> 
	                    BasicTypes.AnnId        -> 
			    BasicTypes.Binding list
	val addBinding    : BasicTypes.WidId        -> 
	                    BasicTypes.AnnId        -> 
			    BasicTypes.Binding list -> 
			    unit



	val readSelection : BasicTypes.WidId -> 
	                    (BasicTypes.Mark * BasicTypes.Mark) list 

	val readMarks : BasicTypes.WidId -> 
	                BasicTypes.AnnId ->
	                (BasicTypes.Mark * BasicTypes.Mark) list 

    end



