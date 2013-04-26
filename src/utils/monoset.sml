(*  ==== MONOMORPHIC SET ABSTRACT TYPE ====
 *              SIGNATURE
 *
 *  Copyright (C) 1992 Harlequin Ltd.
 *
 *  Description
 *  -----------
 *  This signature describes monomorphic sets with useful operations thereon.
 *
 *  Revision Log
 *  ------------
 *  $Log: monoset.sml,v $
 *  Revision 1.4  1992/06/04 09:04:15  richard
 *  Added is_empty.
 *
 *  Revision 1.3  1992/05/05  10:14:07  richard
 *  Added `filter'.
 *
 *  Revision 1.2  1992/04/07  09:27:13  richard
 *  Corrected the type for `cardinality'.
 *
 *  Revision 1.1  1992/03/02  12:35:26  richard
 *  Initial revision
 *
 *)


require "text";


signature MONOSET =

  sig

    structure Text	: TEXT

    type T
    type element

    val empty		: T
    val singleton	: element -> T
    val add		: T * element -> T
    val remove		: T * element -> T
    val member		: T * element -> bool
    val is_empty	: T -> bool
    val equal		: T * T -> bool
    val subset		: T * T -> bool
    val intersection	: T * T -> T
    val union		: T * T -> T
    val difference	: T * T -> T
    val cardinality	: T -> int

    val reduce		: ('a * element -> 'a) -> ('a * T) -> 'a
    val iterate		: (element -> unit) -> T -> unit
    val filter		: (element -> bool) -> T -> T

    val to_list		: T -> element list
    val from_list	: element list -> T
    val to_text		: T -> Text.T

  end
