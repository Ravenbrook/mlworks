(*
 * $Log: labelstrings.sml,v $
 * Revision 1.5  1998/03/25 13:36:38  johnh
 * [Bug #50035]
 * Add virtual key codes.
 *
 * Revision 1.4  1997/07/23  09:28:21  johnh
 * [Bug #30182]
 * Add virtual keys to signature.
 *
 * Revision 1.3  1996/02/28  16:44:36  matthew
 * Adding title function
 *
 * Revision 1.2  1995/11/20  13:52:37  matthew
 * Adding get_acton
 *
# Revision 1.1  1995/08/11  14:01:56  matthew
# new unit
# \nLabel resources for windows code
#
 *)

signature LABELSTRINGS =
  sig
    type word
    type AcceleratorFlag

    val VK_DELETE : int

    val VK_PRIOR : int
    val VK_NEXT : int
    val VK_END : int
    val VK_HOME : int

    val VK_LEFT : int
    val VK_UP : int
    val VK_RIGHT : int
    val VK_DOWN : int

    val accelerators : (AcceleratorFlag list * int * int) list
    val get_label : string -> string 
    val get_action : string -> word
    val get_title : string -> string
  end
