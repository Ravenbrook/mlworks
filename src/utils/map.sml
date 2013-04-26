(*  === GENERAL PURPOSE MAP ===
 *           SIGNATURE
 *
 *  Copyright (C) 1991 Harlequin Ltd.
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
 *  Revision Log
 *  ------------
 *  $Log: map.sml,v $
 *  Revision 1.9  1997/05/01 12:58:03  jont
 *  [Bug #30088]
 *  Get rid of MLWorks.Option
 *
 *  Revision 1.8  1996/03/19  14:21:45  matthew
 *  Adding extra parameter to merge
 *
 *  Revision 1.7  1996/02/23  18:08:51  jont
 *  new unit
 *  Old newmap moved here for better naming in CS library
 *
 *  Revision 1.18  1994/10/13  10:05:38  matthew
 *  Use pervasive Option.option for return values
 *
 *  Revision 1.17  1993/06/15  16:53:15  daveb
 *  Added tryApply'Eq, for use in _realise.
 *
 *  Revision 1.16  1992/10/28  14:35:47  jont
 *  Some cosmetic changes to emphasise the need for strict less than functions
 *
 *  Revision 1.15  1992/10/02  14:38:13  clive
 *  Change to NewMap.empty which now takes < and = functions instead of the single-function
 *
 *  Revision 1.14  1992/09/15  18:18:50  jont
 *  Added empty'' for strict less than functions which do the less than test
 *  first. this should be more efficient for large maps
 *
 *  Revision 1.13  1992/08/27  15:19:08  davidt
 *  Added the functions fold_in_rev_order and string.
 *
 *  Revision 1.12  1992/08/26  12:51:12  davidt
 *  Changed the type of forall and exists, adding the
 *  function map.
 *
 *  Revision 1.11  1992/08/18  16:55:08  davidt
 *  Added the combine function.
 *
 *  Revision 1.10  1992/08/13  14:20:42  davidt
 *  Added tryApply, tryApply', size, rank, rank, and merge functions.
 *
 *  Revision 1.9  1992/08/11  11:22:14  jont
 *  Removed some redundant structure arguments and sharing
 *  Converted where relevant to use NewMap.{forall,exists,iterate}
 *
 *  Revision 1.8  1992/08/04  17:51:49  jont
 *  Added fold, fold_in_order and union on maps
 *
 *  Revision 1.7  1992/07/13  10:31:41  jont
 *  Added is_empty predicate
 *
 *  Revision 1.6  1992/06/17  10:24:09  jont
 *  Added range_ordered for signature matching requirements of lambda translator
 *
 *  Revision 1.5  1992/06/11  14:41:58  jont
 *  Added domain_ordered function (required by lambda translator)
 *
 *  Revision 1.4  1992/06/10  12:13:02  richard
 *  Added to_list_ordered.
 *
 *  Revision 1.3  1992/06/01  09:48:14  richard
 *  Added empty' and from_list'.
 *
 *  Revision 1.2  1992/05/19  10:33:01  richard
 *  Added efficient variants of `apply' for different situations.
 *
 *  Revision 1.1  1991/12/05  14:23:56  richard
 *  Initial revision
 *
 *)


signature MAP =
  sig
    (*  === THE MAP TYPE ===  *)

    type ('object, 'image) map


    (*  === CONSTRUCT AN EMPTY MAP ===
     *
     *  An empty map is undefined everywhere, and is constructed by
     *  supplying an ordering function for the object type (<) and
     *  an equality function
     *  Note:
     *    ForAll f,x . apply (empty f) x = raise Undefined
     *
     *  empty' is a variation which takes a less function (or <) for an
     *  equality-admitting object type.
     *
     *)

    val empty  : (('object * 'object -> bool) * ('object * 'object -> bool)) -> ('object, 'image) map
    val empty' : (''object * ''object -> bool) -> (''object, 'image) map

    (* Determining if a map is empty *)
    val is_empty : ('object, 'image) map -> bool

    (*  === DEFINE THE MAP AT A POINT ===
     *
     *  Adds a mapping from the object to the image such that
     *    apply (define (M, x, y)) x = y
     *)

    val define  : ('object, 'image) map * 'object * 'image -> ('object, 'image) map
    val define' : ('object, 'image) map * ('object * 'image) -> ('object, 'image) map

    (*  === DEFINE THE MAP AT A POINT ===
     *
     *  Adds a mapping from the object to the image, combining the
     *  images using the supplied function if the object is already
     *  present in the mapping.
     *)

    val combine : ('object * 'image * 'image -> 'image) -> ('object, 'image) map * 'object * 'image -> ('object, 'image) map

    (*  === UNDEFINE THE MAP AT A POINT ===
     *
     *  Removed a mapping from the object to the image such that
     *    apply (undefine (M, x)) x = raise Undefined
     *)

    val undefine : ('object, 'image) map * 'object -> ('object, 'image) map


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
     *
     *  tryApply and tryApply' encode the result status in the return value.
     *  tryApply'Eq uses polymorphic equality during the lookup instead of
     *  the one with which the tree was built.  This is for signature
     *  realisation, when (unusually) the constructor status of entries in
     *  the value environment is important.
     *)

    exception Undefined

    val apply          : ('object, 'image) map -> 'object -> 'image
    val apply'         : ('object, 'image) map * 'object -> 'image
    val tryApply       : ('object, 'image) map -> 'object -> 'image option
    val tryApply'      : ('object, 'image) map * 'object -> 'image option
    val tryApply'Eq    : (''object, 'image) map * ''object -> 'image option
    val apply_default  : ('object, 'image) map * 'image -> 'object -> 'image
    val apply_default' : ('object, 'image) map * 'image * 'object -> 'image


    (*  === EXTRACT THE DOMAIN OF A MAP ===
     *
     *  A list of all objects for which the map is defined is returned.
     *)

    val domain : ('object, 'image) map -> 'object list
    val domain_ordered : ('object, 'image) map -> 'object list


    (*  === EXTRACT THE RANGE OF A MAP ===
     *
     *  A list of all images mapped to in the map is returned.  This may
     *  contain duplicate entries.
     *)

    val range : ('object, 'image) map -> 'image list
    val range_ordered : ('object, 'image) map -> 'image list


    (*  === CONVERT MAP TO LIST ===
     *
     *  Converts a map to a list of pairs of the form (object, image), in no
     *  particular order.  to_list_ordered produces the pairs in ascending
     *  order of object.
     *)

    val to_list         : ('object, 'image) map -> ('object * 'image) list
    val to_list_ordered : ('object, 'image) map -> ('object * 'image) list


    (*  === CONVERT LIST TO MAP ===
     *
     *  Converts a list of pairs of the form (object, image) to a map
     *  defined for all such objects.  An ordering function on the objects
     *  is also required as for `empty' (see above).
     *)

    val from_list :
      (('object * 'object -> bool) * ('object * 'object -> bool)) ->
      ('object * 'image) list ->
      ('object, 'image) map

    val from_list' :
      (''object * ''object -> bool) ->
      (''object * 'image) list ->
      (''object, 'image) map

    (*  === FOLD OVER MAP ===
     *
     *  Folds over all the live elements of a map.
     *)

    val fold : ('a * 'b * 'c -> 'a) -> 'a * ('b, 'c) map -> 'a
    val fold_in_order : ('a * 'b * 'c -> 'a) -> 'a * ('b, 'c) map -> 'a
    val fold_in_rev_order : ('a * 'b * 'c -> 'a) -> 'a * ('b, 'c) map -> 'a

    (*  === FOLD OVER MAP ===
     *
     *  Map over all the live elements of a map in order.
     *)

    val map : ('a * 'b -> 'c) -> ('a, 'b) map -> ('a, 'c) map

    (*
     *  Calculate the number of entries in a map.
     *)

    val size : ('a, 'b) map -> int

    (*
     * Given an equality function on the image, checks if two maps are equal.
     *)

    val eq : ('a * 'b -> bool) -> ('o, 'a) map * ('o, 'b) map -> bool

    (*
     *  Find the position of an object in the domain (wrt to the domain
     *  ordering), counting from zero for the least object. Raises Undefined
     *  if the object is not present in the domain.
     *)

    val rank  : ('a, 'b) map -> 'a -> int
    val rank' : ('a, 'b) map * 'a -> int

    (*  === UNITE MAPS ===
     *
     *  Overrides the first map with the second
     *)

    val union : ('a, 'b) map * ('a, 'b) map -> ('a, 'b) map

    (*  === UNITE MAPS ===
     *
     *  Merges the first map with the second, using the function
     *  provided if both maps map the same object.
     *)

    val merge : ('a * 'b * 'b -> 'b) -> ('a, 'b) map * ('a, 'b) map -> ('a, 'b) map

    (*  === LOGICAL FUNCTIONS OVER MAP RANGES ===
     *
     *  Forall and Exists quantifiers
     *)

    val forall : ('a * 'b -> bool) -> ('a, 'b) map -> bool
    val exists : ('a * 'b -> bool) -> ('a, 'b) map -> bool

    (*  === ITERATION OVER MAPS ===
     *
     *  Iterate and Iterate ordered
     *)

    val iterate : ('a * 'b -> unit) -> ('a, 'b) map -> unit
    val iterate_ordered : ('a * 'b -> unit) -> ('a, 'b) map -> unit

    (* === PRINTING OF MAPS ===
     *
     * Make a map into a string.
     *)

    val string :
      ('a -> string) -> ('b -> string) ->
      {start : string, domSep : string, itemSep : string, finish : string} ->
      ('a, 'b) map -> string

  (* === GET RELATION === 
   *
   * Get the ordering relation from a map
   *)

    val get_ordering : ('a,'b) map -> ('a * 'a -> bool)
    val get_equality : ('a,'b) map -> ('a * 'a -> bool)

  end
