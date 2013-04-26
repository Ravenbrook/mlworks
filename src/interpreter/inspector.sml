(* tty inspector
 *
 * Copyright (C) 1993 Harlequin Ltd.
 *
 * $Log: inspector.sml,v $
 * Revision 1.3  1994/02/23 17:37:13  matthew
 * Added function to inspect a dynamic value
 *
Revision 1.2  1993/04/21  14:20:12  matthew
inspect_value takes a ShellData now

Revision 1.1  1993/03/12  15:24:44  matthew
Initial revision

 *)

signature INSPECTOR =
  sig
    type ShellData
    type Type
    val inspect_value : (MLWorks.Internal.Value.T * Type) * ShellData -> unit
    val inspect_it : ShellData -> unit
  end

    
