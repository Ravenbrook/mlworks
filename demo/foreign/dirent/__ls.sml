(* Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
 * All rights reserved.
 * 
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 * 
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
 * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * A very simple version of ls implemented using the dirent interface.
 * It produces output akin to an unsorted version of "ls -1a".
 * 
 * Revision Log
 * ------------
 * $Log: __ls.sml,v $
 * Revision 1.3  1998/01/22 19:06:59  jkbrook
 * [Bug #70047]
 * Syntax for delivery has changed
 *
 *  Revision 1.2  1997/07/03  10:10:02  stephenb
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *)

require "$.system.__os";     (* OS.Process.exit *)
require "$.basis.__word";
require "$.foreign._mlworks_c_pointer";
require "$.foreign.__mlworks_c_interface";
require "$.foreign.__mlworks_c_resource";
require "__dirent";


(* This is an application which is going to be delivered so there 
 * is nothing to be exported from the structure
 *)

structure Ls : sig end = 
  struct
    
    exception OutOfMemory
    exception NoSuchDirectory of string

    structure C = MLWorksCInterface

    val withNonNullResource = MLWorksCResource.withNonNullResource

    fun withCString str action = 
      withNonNullResource (C.CharPtr.free, OutOfMemory, str, action)

    fun withDirectory directoryName action =
      withCString (C.CharPtr.fromString directoryName)
        (fn cDirectoryName =>
          withNonNullResource (Dirent.closedir, NoSuchDirectory directoryName,
                               Dirent.opendir cDirectoryName, action))

    fun applyPair (f, g) x = (f x, g x)

    fun dirApp (f, dir) =
      let 
        val entry = Dirent.readdir dir
      in
        if entry = C.null then
          ()
        else
          (f entry;  dirApp (f, dir))
      end

    val wordFromUshort = Word.fromLargeWord o C.Ushort.toLargeWord

    val direntName : Dirent.struct'dirent -> string
      = C.CharPtr.copySubString
      o applyPair (Dirent.struct'dirent'd_name,
                   wordFromUshort o Dirent.struct'dirent'd_namlen)


    structure direntPtr = MLWorksCPointer
      (type value = Dirent.struct'dirent
       val size = Dirent.struct'dirent'size'
       val addr = Dirent.struct'dirent'addr'
       structure C = C);

    val printName = print o direntName o direntPtr.!

    fun longListing directoryName = ()


    fun shortListing directoryName =
      withDirectory directoryName
        (fn dir =>
           dirApp (fn entry => (printName entry; print "\n"), dir))


    (*
    **.fix.stderr: the usage message should be displayed on stderr.
    **.fix.prog-name: the usage message should include the name of the program.
    *)
    fun usage () =
      (print "[ directory ]\n";
      OS.Process.exit 1)



    fun parseArgs ([directoryName]) = shortListing directoryName
      | parseArgs ([]) = shortListing "."
      | parseArgs _ = usage ()

    fun main () = parseArgs (MLWorks.arguments ())
                  handle
                    OutOfMemory => print "Out of Memory\n"
                  | NoSuchDirectory d => 
                      print ("No such directory: " ^ d ^ "\n")

    val _ = MLWorks.Deliver.deliver ("simplels", main, MLWorks.Deliver.CONSOLE);

  end
