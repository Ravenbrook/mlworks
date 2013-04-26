(*  === SPECIAL PURPOSE MAP ===
 *           SIGNATURE
 *
 *  Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 *  All rights reserved.
 *  
 *  Redistribution and use in source and binary forms, with or without
 *  modification, are permitted provided that the following conditions are
 *  met:
 *  
 *  1. Redistributions of source code must retain the above copyright
 *     notice, this list of conditions and the following disclaimer.
 *  
 *  2. Redistributions in binary form must reproduce the above copyright
 *     notice, this list of conditions and the following disclaimer in the
 *     documentation and/or other materials provided with the distribution.
 *  
 *  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 *  IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 *  TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 *  PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 *  HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 *  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 *  TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 *  Description
 *  -----------
 *  A map is a general purpose partial function from some domain to some
 *  range, or, if you prefer, a look-up table.  For the sake of efficiency a
 *  complete order must be provided when constructing a map.
 *
 *  Notes
 *  -----
 *  This signature is intended to have more than one implementation, using
 *  association lists, balanced trees, arrays, etc.  I want to keep the
 *  signature simple and self-contained.
 *
 *  $Log: monomap.sml,v $
 *  Revision 1.2  1997/05/01 12:58:16  jont
 *  [Bug #30088]
 *  Get rid of MLWorks.Option
 *
 *  Revision 1.1  1996/02/26  12:45:32  jont
 *  new unit
 *  Moved from mononewmap
 *
Revision 1.2  1994/10/13  10:05:57  matthew
Use pervasive Option.option for return values

Revision 1.1  1992/10/29  14:50:00  jont
Initial revision

 *)


signature MONOMAP =
  sig
    (*  === THE MAP TYPE ===  *)

    type ('image) T (* The map type *)
    eqtype object   (* The domain type *)

    (*  === CONSTRUCT AN EMPTY MAP ===
     *
     *  An empty map is undefined everywhere, and is constructed by
     *  supplying an ordering function for the object type (<) and
     *  an equality function
     *  Note:
     *    ForAll f,x . apply (empty f) x = raise Undefined
     *
     *)

    val empty  : ('image) T

    (* Determining if a map is empty *)
    val is_empty : ('image) T -> bool

    (*  === DEFINE THE MAP AT A POINT ===
     *
     *  Adds a mapping from the object to the image such that
     *    apply (define (M, x, y)) x = y
     *)

    val define  : ('image) T * object * 'image -> ('image) T
    val define' : ('image) T * (object * 'image) -> ('image) T

    (*  === DEFINE THE MAP AT A POINT ===
     *
     *  Adds a mapping from the object to the image, combining the
     *  images using the supplied function if the object is already
     *  present in the mapping.
     *)

    val combine : (object * 'image * 'image -> 'image) -> ('image) T * object * 'image -> ('image) T

    (*  === UNDEFINE THE MAP AT A POINT ===
     *
     *  Removed a mapping from the object to the image such that
     *    apply (undefine (M, x)) x = raise Undefined
     *)

    val undefine : ('image) T * object -> ('image) T


    (*  === APPLY THE MAP TO AN OBJECT ===
     *
     *  Looks up the image of an object in the map, and raises Undefined if
     *  no mapping has been defined for that object.  apply M is the partial
     *  function represented by the map M, and should be lifted out of loops
     *  and functions so that apply has a chance to optimise the map.
     *
     *  apply' is an uncurried alternative to apply.  Use the curried
     *  version if it can be lifted (see previous paragraph).  apply_default
     *  and apply_default' will return a default image rather than raise
     *  Undefined.
     *)

    exception Undefined

    val apply          : ('image) T -> object -> 'image
    val apply'         : ('image) T * object -> 'image
    val tryApply       : ('image) T -> object -> 'image option
    val tryApply'      : ('image) T * object -> 'image option
    val apply_default  : ('image) T * 'image -> object -> 'image
    val apply_default' : ('image) T * 'image * object -> 'image

    (*  === EXTRACT THE DOMAIN OF A MAP ===
     *
     *  A list of all objects for which the map is defined is returned.
     *)

    val domain : ('image) T -> object list
    val domain_ordered : ('image) T -> object list

    (*  === EXTRACT THE RANGE OF A MAP ===
     *
     *  A list of all images mapped to in the map is returned.  This may
     *  contain duplicate entries.
     *)

    val range : ('image) T -> 'image list
    val range_ordered : ('image) T -> 'image list

    (*  === CONVERT MAP TO LIST ===
     *
     *  Converts a map to a list of pairs of the form (object, image), in no
     *  particular order.  to_list_ordered produces the pairs in ascending
     *  order of object.
     *)

    val to_list         : ('image) T -> (object * 'image) list
    val to_list_ordered : ('image) T -> (object * 'image) list

    (*  === CONVERT LIST TO MAP ===
     *
     *  Converts a list of pairs of the form (object, image) to a map
     *  defined for all such objects.  An ordering function on the objects
     *  is also required as for `empty' (see above).
     *)

    val from_list :
      (object * 'image) list ->
      ('image) T

    (*  === FOLD OVER MAP ===
     *
     *  Folds over all the live elements of a map.
     *)

    val fold : ('a * object * 'c -> 'a) -> 'a * ('c)T -> 'a
    val fold_in_order : ('a * object * 'c -> 'a) -> 'a * ('c)T -> 'a
    val fold_in_rev_order : ('a * object * 'c -> 'a) -> 'a * ('c)T -> 'a

    (*  === MAP OVER MAP ===
     *
     *  Map over all the live elements of a map in order.
     *)

    val map : (object * 'b -> 'c) -> ('b)T -> ('c)T

    (*
     *  Calculate the number of entries in a map.
     *)

    val size : ('b)T -> int

    (*
     * Given an equality function on the image, checks if two maps are equal.
     *)

    val eq : ('a * 'b -> bool) -> ('a)T * ('b)T -> bool

    (*
     *  Find the position of an object in the domain (wrt to the domain
     *  ordering), counting from zero for the least object. Raises Undefined
     *  if the object is not present in the domain.
     *)

    val rank  : ('b)T -> object -> int
    val rank' : ('b)T * object -> int

    (*  === UNITE MAPS ===
     *
     *  Overrides the first map with the second
     *)

    val union : ('b)T * ('b)T -> ('b)T

    (*  === UNITE MAPS ===
     *
     *  Merges the first map with the second, using the function
     *  provided if both maps map the same object.
     *)

    val merge : ('b * 'b -> 'b) -> ('b)T * ('b)T -> ('b)T

    (*  === LOGICAL FUNCTIONS OVER MAP RANGES ===
     *
     *  Forall and Exists quantifiers
     *)

    val forall : (object * 'b -> bool) -> ('b)T -> bool
    val exists : (object * 'b -> bool) -> ('b)T -> bool

    (*  === ITERATION OVER MAPS ===
     *
     *  Iterate and Iterate ordered
     *)

    val iterate : (object * 'b -> unit) -> ('b)T -> unit
    val iterate_ordered : (object * 'b -> unit) -> ('b)T -> unit

    (* === PRINTING OF MAPS ===
     *
     * Make a map into a string.
     *)

    val string :
      (object -> string) -> ('b -> string) ->
      {start : string, domSep : string, itemSep : string, finish : string} ->
      ('b)T -> string

  end
