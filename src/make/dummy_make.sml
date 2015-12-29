(*
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
 *  This file defines a simple "make" system we can use for bootstrapping from
 *  mlworks.  The code is highly grungy, but hopefully clear.
 *  It is intended to be independent of any of the existing compiler internals. * 
 *  It does, of course, limit the kinds of things we can do with the make
 *  system and the compiler, but it should only affect the batch files.
 * 
 *  Revision Log
 *  ------------
 *  $Log: dummy_make.sml,v $
 *  Revision 1.4  1998/03/20 15:42:40  jont
 *  [Bug #30090]
 *  Modify to use TextIO instead of MLWorks.IO
 *
 *  Revision 1.3  1997/09/22  16:02:46  jont
 *  [Bug #70009]
 *  Modify to cope with leading $ in module names
 *
 *  Revision 1.2  1997/05/12  14:44:46  jont
 *  [Bug #20050]
 *  main/io now exports MLWORKS_IO
 *
 *  Revision 1.1  1997/01/06  13:18:05  matthew
 *  new unit
 *  New unit
 *
*)

local
  datatype Path = ABS of string list| REL of string list
  fun strip (#"\t" :: rest) = strip rest
    | strip (#" " :: rest) = strip rest
    | strip l = l

  (* This takes a line of text and returns SOME filename if the line of the *)
  (* form "<whitespace>require<whitespace>"<filename>"<trailing stuff>" else *)
  (* it returns NONE *)
    
  fun getrequire l =
    let
      val chars = explode l        
      fun scan (#"r" :: #"e" :: #"q" :: #"u" :: #"i" :: #"r" :: #"e" :: rest) =
        scan2 (strip rest)
        | scan _ = NONE        
      and scan2 (#"\""::rest) =
                 scan3 (rest,[])
        | scan2 _ = NONE
      and scan3 ([],chars) = NONE
        | scan3 (#"\""::rest,acc) = 
                 SOME (implode (rev acc))
        | scan3 (a::rest,acc) = scan3 (rest,a::acc)
    in
      scan (strip chars)
    end

  fun get_requires f =
    let
     val s = TextIO.openIn f
     fun doline acc =
	 case TextIO.inputLine s of
	     NONE => rev acc
	   | SOME line => case getrequire line of
			      SOME r => doline (r ::acc)
			    | _ => doline acc
     val res = doline []
   in
                 TextIO.closeIn s;
                 res
   end
   handle e => (print ("get_requires for " ^ f ^ " failed\n"); raise e)

  fun parsename s =
  let
    val chars = explode s
    fun doit ([],[],acc) = acc
      | doit ([],l,acc) = doit ([],[],implode (rev l) :: acc)
      | doit ([#".",#"s",#"m",#"l"],l,acc) = doit ([],[],implode (rev l) :: acc)
      | doit (#"."::rest,l,acc) = doit (rest,[],implode (rev l) :: acc)
      | doit (#"/"::rest,l,acc) = doit (rest,[],implode (rev l) :: acc)
      | doit (a::rest,l,acc) = doit (rest,a::l,acc)
  in
    case chars of
      #"." :: #"." :: #"/" :: rest =>
      ABS (doit (rest,[],[]))
    | #"^" :: #"." :: rest =>
      ABS (doit (rest,[],[]))
    | #"$" :: #"." :: rest =>
      ABS (doit (rest,[],[]))
    | _ => REL (doit (chars,[],[]))
  end

  fun toString [] = ""
    | toString [s] = s
    | toString (a::b) = toString b ^ "/" ^ a

  fun resolve_path dir file =
    case parsename file of
      ABS s => s
    | REL s => (s @ dir)

  fun read_dependencies (here,file) =
    let
      val requires = get_requires file
    in
      map (resolve_path here) requires
    end

  fun member (a,[]) = false
    | member (a,b::c) = a=b orelse member (a,c)
    
  fun iterate (f : 'a -> unit) [] = ()
    | iterate f (a::b) = (f a; iterate f b)
  exception Cdr
  fun cdr [] = raise Cdr
    | cdr (a::b) = b

  fun scan file =
  let
    val seen = ref []
    val result = ref []
    fun one f =
      let
        val path = toString f ^ ".sml"
      in
        let
          val name = OS.FileSys.realPath path
        in
          if member (name,!seen) then ()
          else
            (seen := name :: !seen;
             let
(*
               val _ = print ("Doing dependencies for " ^ name ^ "\n")
*)
               val sub = read_dependencies (cdr f,name)
             in
               iterate one sub;
               result := name :: !result
             end)
        end
        handle e => (print ("scan for " ^ path ^ " failed\n"); raise e)
      end
  in
    one file;
    rev (!result)
  end

in
  fun require _ = ()
  fun make f =
    case parsename f of
      REL l => map use (scan l)
    | ABS l => map use (scan l)
end


