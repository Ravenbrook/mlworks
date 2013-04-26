(*
 *
 * $Log: __code.sml,v $
 * Revision 1.2  1998/06/08 12:57:40  jont
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *
 *)
(*		Jo: A concurrent constraint programming language
			(Programming for the 1990s)
			
				Andrew Wilson
				
		       Description of internal code

			   9th November 1990
========================================================================
                             the structure

version of July 1996 modified to use the Harlequin MLWorks separate
compilation system.
*)


require "__store";
require "_code";

structure Code = Code(structure Store = Store);
