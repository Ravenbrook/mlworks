(*
 *
 * $Log: Part.sig,v $
 * Revision 1.2  1998/06/02 15:49:53  jont
 * Automatic checkin:
 * changed attribute _comment to ' * '
 *
 *
 *)
RCS "$Id: Part.sig,v 1.2 1998/06/02 15:49:53 jont Exp $";
(*****************************************************************************)
(*              PARTICLES NEED AN ORDERING AND AN EQUALITY                   *)
(*****************************************************************************)

signature PART =
sig
   eqtype part

   val hashval  : part -> int
     
   val eq : part * part -> bool
   val le : part * part -> bool

   val name    : part -> part
   val inverse : part -> part
   val isname  : part -> bool

   val mkstr  : part -> string
   val mkpart : string -> part
end
