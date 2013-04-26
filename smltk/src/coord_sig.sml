(* ***********************************************************************

   Project: sml/Tk: an Tk Toolkit for sml
   Author: Stefan Westmeier, University of Bremen
  $Date: 1999/06/16 09:58:20 $
  $Revision: 1.1 $
   Purpose of this file: Coordinate Module

   *********************************************************************** *)

require "basic_types";

signature COORD =
    sig
	exception COORD of string

	val show : BasicTypes.Coord list -> string
	val read : string -> BasicTypes.Coord list

	val add : BasicTypes.Coord -> BasicTypes.Coord -> BasicTypes.Coord
	val sub : BasicTypes.Coord-> BasicTypes.Coord -> BasicTypes.Coord
	val smult : BasicTypes.Coord-> int-> BasicTypes.Coord

        type Rect

	val inside   : BasicTypes.Coord-> Rect-> bool
	val moveRect : Rect-> BasicTypes.Coord-> Rect
        val showRect : Rect-> string

    end
