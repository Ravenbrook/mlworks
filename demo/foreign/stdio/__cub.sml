(* Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 *
 * Cub - a small/simple version of Unix cat implemented using the
 * MLWorksCIO interface.  Uses MLWorksCIO.freadCharArray and 
 * MLWorksCIO.fwriteCharArray to read and write blocks of characters.
 * 
 *
 * Revision Log
 * ------------
 * $Log: __cub.sml,v $
 * Revision 1.4  1998/10/08 12:54:42  jkbrook
 * [Bug #70184]
 * Update for OS.Process.status
 *
 *  Revision 1.3  1998/01/22  19:01:27  jkbrook
 *  [Bug #70047]
 *  Syntax for delivery has changed
 *
 *  Revision 1.2  1997/07/03  10:20:55  stephenb
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *)

require "$.system.__os";     (* OS.Process.exit *)
require "$.basis.__word";
require "$.basis.__list";
require "$.basis.__char_array";
require "$.foreign.__mlworks_c_interface";
require "$.foreign.__mlworks_c_resource";
require "$.foreign.__mlworks_c_io";


(* This is an application which is going to be delivered so there 
 * is nothing to be exported from the structure
 *)
structure Cub : sig end = 
  struct
    
    exception OutOfMemory
    exception FileWriteError
    exception FileReadError
    exception InternalError
    exception NoSuchFile of string

    structure C = MLWorksCInterface
    structure IO = MLWorksCIO

    val withNonNullResource = MLWorksCResource.withNonNullResource

    (*
     * Unlike the equivalent in __kitten.sml which uses a malloc'd block
     * of memory and so needs to be wrapped in a resource, this uses
     * an ML allocated CharArray and so it is left to the GC to clean 
     * it up.
     *)
    fun withBuffer (size:int) (action: CharArray.array -> 'a) =
      action (CharArray.array (size, #" "))



    val bufferSize = 4096


    val exit = OS.Process.exit


    fun ferror (file: IO.FILE C.ptr): bool =
      C.Int.toInt (IO.ferror file) <> 0


    fun feof (file: IO.FILE C.ptr): bool =
      C.Int.toInt (IO.feof file) <> 0



    fun printError errorMessage =
      let
        val stderr = IO.stderr ()
      in
        ignore(IO.fputString (stderr, "cub: "));
        ignore(IO.fputString (stderr, errorMessage));
        ignore(IO.fputString (stderr, "\n"));
        ()
      end



    fun catFILE (input, buffer, bufferSize, output) =
      let
        fun loop () =
          let
            val nRead = IO.freadCharArray (buffer, 0, bufferSize, input)
          in
            if nRead < bufferSize then
              if ferror input then
                raise FileReadError
              else if feof input then
                if IO.fwriteCharArray (buffer, 0, nRead, output) = nRead then
                  ()
                else if ferror output then
                  raise FileWriteError
                else
                  raise InternalError
              else
                raise InternalError
            else
              let
                val nWritten = IO.fwriteCharArray (buffer, 0, nRead, output)
              in
                if nWritten = nRead then
                  loop ()
                else if ferror output then
                  raise FileWriteError
                else
                  raise InternalError
              end
          end
      in
        loop ()
      end



    fun catStdin () =
      withBuffer bufferSize
        (fn buffer =>
           let
             val stdin = IO.stdin ()
             val stdout = IO.stdout ()
           in
             catFILE (stdin, buffer, bufferSize, stdout);
             OS.Process.success
           end)



    fun withOpenInputFile (fileName: string) (action: IO.FILE C.ptr -> 'a) =
      let
        val exn = NoSuchFile fileName
        val file = IO.fopen (fileName, "r")
      in
        withNonNullResource (IO.fclose, exn, file, action)
      end



    fun catFile (buffer, bufferSize, stdout) (fileName: string, status: OS.Process.status) =
      withOpenInputFile fileName
        (fn input =>
           (catFILE (input, buffer, bufferSize, stdout);
            status))
  


    fun catFiles (files: string list) =
      withBuffer bufferSize
        (fn buffer =>
           let
             val stdout = IO.stdout ()
             fun cat file =
               catFile (buffer, bufferSize, stdout) file
                 handle NoSuchFile fileName => 
                   (printError ("cannot open '" ^ fileName ^ "'");
                    OS.Process.failure)
           in
             List.foldl cat OS.Process.success files
           end)

    fun parseArgs [] = catStdin ()
      | parseArgs files = catFiles files
      

    fun main () = 
      (exit (parseArgs (MLWorks.arguments ())))
      handle
        OutOfMemory => (printError "out of Memory"; exit OS.Process.failure)
      | FileWriteError => (printError "could not write to output"; exit OS.Process.failure)
      | FileReadError => (printError "could not read from input"; exit OS.Process.failure)
      | InternalError => (printError "internal error"; exit OS.Process.failure)
                  

    val _ = MLWorks.Deliver.deliver ("cub", main, MLWorks.Deliver.CONSOLE);

  end
