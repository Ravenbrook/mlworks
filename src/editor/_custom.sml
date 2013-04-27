(*  === CUSTOM Editor interface ===
 *
 *  $Log: _custom.sml,v $
 *  Revision 1.3  1997/10/31 09:28:14  johnh
 *  [Bug #30233]
 *  Change editor interface to make connectDialogs distinct from custom commands.
 *
 *  Revision 1.2  1996/10/30  20:07:49  io
 *  moving String from toplevel
 *
 *  Revision 1.1  1996/06/11  21:46:24  brianm
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

require "^.basis.__list";
require "custom";

functor CustomEditor () : CUSTOM_EDITOR =
  struct

     val emptyEntry = ("",[])

     type dBentry = (string * string list)

     val editorsOneWay : (string * string) list ref = ref []
     val editorsTwoWay : (string * dBentry) list ref = ref []

     fun split P lst =
         let fun sp (a::l,r) =
                 if P(a) then (SOME(a), List.revAppend (r,l)) else sp(l,a::r)
               | sp ([],_) = (NONE,lst)
         in
             sp(lst,[])
         end

     fun findFirst P lst =
         let fun fF (a::l) =
                 if P(a) then SOME(a) else fF(l)
               | fF ([]) = NONE
         in
             fF(lst)
         end

     fun names edlist () = map (fn (s,_) => s) (!edlist)

     (* Public *)

     fun removeCommand ed =
       let 
	 val (itm,rest) = split (fn (s,_) => (s = ed)) (!editorsOneWay)
         val result =
           case itm of
             NONE => ""
           | SOME (_,r) => r
       in 
	 editorsOneWay := rest;
	 result
       end

     fun removeDialog ed =
       let 
	 val (itm,rest) = split (fn (s,_) => (s = ed)) (!editorsTwoWay)
         val result =
           case itm of
             NONE => emptyEntry
           | SOME((_,r)) => r
       in 
	 editorsTwoWay := rest;
	 result
       end

     fun getCommandEntry ed =
       let 
	 val itm = findFirst (fn (s,_) => (s = ed)) (!editorsOneWay)
       in
         case itm of
           NONE => ""
         | SOME (_,r) => r
       end

     fun getDialogEntry ed =
       let 
	 val itm = findFirst (fn (s,_) => (s = ed)) (!editorsTwoWay)
       in
         case itm of
           NONE => emptyEntry
         | SOME (_,r) => r
       end

     fun addCommand (ed,cmd) =
	 let 
	   val (itm,rest) = split (fn (s,_) => (s = ed)) (!editorsOneWay)
           val new_itm = (ed,cmd)
         in 
           editorsOneWay := new_itm :: rest
         end

     fun addConnectDialog (ed,con_type,cmds) =
	 let 
	   val (itm,rest) = split (fn (s,_) => (s = ed)) (!editorsTwoWay)
           val new_itm = (ed,(con_type,cmds))
         in 
           editorsTwoWay := (new_itm :: rest)
         end

     val commandNames = names editorsOneWay
     val dialogNames = names editorsTwoWay

  end;
