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
