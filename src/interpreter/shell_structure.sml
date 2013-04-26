(*  This module creates the user-visible shell structure.
 *
 *  Copyright (C) 1992,1993 Harlequin Ltd
 *
 *  $Log: shell_structure.sml,v $
 *  Revision 1.6  1995/07/12 13:23:15  jont
 *  Add parameter to make_shell_structure to indicate image type (ie tty or motif)
 *
 *  Revision 1.5  1993/05/10  14:15:25  daveb
 *  Removed error_info field from ListenerArgs, ShellData and Incremental.options
 *
 *  Revision 1.4  1993/03/29  09:51:53  matthew
 *  make_shell_structure gets shell_data from a ref.
 *  
 *  Revision 1.3  1993/03/15  14:41:37  matthew
 *  Renamed ShellArgs to ShellData
 *  
 *  Revision 1.2  1993/03/05  14:45:57  matthew
 *  Remove Context ref arg to make_shell_structure
 *  
 *  Revision 1.1  1993/03/02  18:31:30  daveb
 *  Initial revision
 *  
 *
 *)

signature SHELL_STRUCTURE =
sig
  type ShellData
  type Context

  (* augment the parameter context with the shell functions.  These *)
  (* functions get shell info from the ShellData ref parameter *)
     
  val make_shell_structure : bool -> ShellData ref * Context -> Context
end;

