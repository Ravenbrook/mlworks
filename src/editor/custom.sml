(*  === CUSTOM Editor interface ===
 *
 *  $Log: custom.sml,v $
 *  Revision 1.2  1997/10/31 09:30:40  johnh
 *  [Bug #30233]
 *  Change editor interface to make connectDialogs distinct from custom commands.
 *
 *  Revision 1.1  1996/06/14  17:32:26  brianm
 *  new unit
 *  New file.
 *
 *
 *  Copyright (C) 1996 Harlequin Ltd
 *
 *)

signature CUSTOM_EDITOR =
  sig

     (* This interface is a bit on the crufty side - I would prefer
      * to use some datatypes & options to wrap this up a bit more.
      *
      * But this has to be exposed to the User via the Shell structure -
      * the present means of implementing this is pretty horrendous.  So,
      * exposing the structure like this will have to do until the shell is
      * implemented in a better, more hygenic manner ...
      *)

     val addCommand : string * string -> unit
     val addConnectDialog : string * string * string list -> unit

     val removeCommand : string -> string 
     val removeDialog  : string -> (string * string list)

     val commandNames  : unit -> string list
     val dialogNames  : unit -> string list

     val getCommandEntry : string -> string 
     val getDialogEntry : string -> (string * string list)
  end;
