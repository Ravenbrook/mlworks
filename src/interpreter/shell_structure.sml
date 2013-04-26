(*  This module creates the user-visible shell structure.
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

