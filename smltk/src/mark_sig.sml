(* ***********************************************************************

   Project: sml/Tk: an Tk Toolkit for sml
   Author: Stefan Westmeier, University of Bremen
  $Date: 1999/06/16 10:02:15 $
  $Revision: 1.1 $
   Purpose of this file: Mark Module

   *********************************************************************** *)

require "basic_types";

signature MARK =
    sig
	exception MARK of string

	val show  : BasicTypes.Mark -> string
	val showL : (BasicTypes.Mark * BasicTypes.Mark) list -> string

	val read  : string -> BasicTypes.Mark
	val readL : string -> (BasicTypes.Mark * BasicTypes.Mark) list

    end
