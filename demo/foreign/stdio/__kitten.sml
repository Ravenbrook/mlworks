(* Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 *
 * Kitten - a small/simple version of Unix cat implemented using the
 * MLWorksCIO interface.  Uses MLWorksCIO.fread and MLWorksCIO.fwrite
 * to read and write blocks of characters.
 * 
 * Revision Log
 * ------------
 * $Log: __kitten.sml,v $
 * Revision 1.4  1998/10/08 12:55:48  jkbrook
 * [Bug #70184]
 * Update for OS.Process.status
 *
 *  Revision 1.3  1998/01/22  19:01:49  jkbrook
 *  [Bug #70047]
 *  Syntax for delivery has changed
 *
 *  Revision 1.2  1997/07/03  10:21:45  stephenb
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *)

require "$.system.__os";     (* OS.Process.exit *)
require "$.basis.__word";
require "$.basis.__list";
require "$.foreign.__mlworks_c_interface";
require "$.foreign.__mlworks_c_resource";
require "$.foreign.__mlworks_c_io";


(* This is an application which is going to be delivered so there 
 * is nothing to be exported from the structure
 *)

structure Kitten : sig end = 
  struct
    
    exception OutOfMemory
    exception FileWriteError
    exception FileReadError
    exception InternalError
    exception NoSuchFile of string

    structure C = MLWorksCInterface
    structure IO = MLWorksCIO

    val withNonNullResource = MLWorksCResource.withNonNullResource

    fun withBuffer (size:Word.word) (action: C.void C.ptr -> 'a) =
      withNonNullResource (C.free, OutOfMemory, C.malloc size, action)

    val one = C.Uint.fromInt 1

    val bufferSize = 4096

    val exit = OS.Process.exit

    type status = OS.Process.status

    fun ferror (file: IO.FILE C.ptr): bool =
      C.Int.toInt (IO.ferror file) <> 0


    fun feof (file: IO.FILE C.ptr): bool =
      C.Int.toInt (IO.feof file) <> 0



    fun printError errorMessage =
      let
        val stderr = IO.stderr ()
      in
        ignore(IO.fputString (stderr, "kitten: "));
        ignore(IO.fputString (stderr, errorMessage));
        ignore(IO.fputString (stderr, "\n"));
        ()
      end



    fun catFILE (input, buffer, bufferSize, output) =
      let
        fun loop () =
          let
            val nRead = IO.fread (buffer, one, bufferSize, input)
          in
            if C.Uint.< (nRead, bufferSize) then
              if ferror input then
                raise FileReadError
              else if feof input then
                if IO.fwrite (buffer, one, nRead, output) = nRead then
                  ()
                else if ferror output then
                  raise FileWriteError
                else
                  raise InternalError
              else
                raise InternalError
            else
              let
                val nWritten = IO.fwrite (buffer, one, nRead, output)
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
      withBuffer (Word.fromInt bufferSize)
        (fn buffer =>
           let
             val stdin = IO.stdin ()
             val stdout = IO.stdout ()
           in
             catFILE (stdin, buffer, C.Uint.fromInt bufferSize, stdout);
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
           (catFILE (input, buffer, C.Uint.fromInt bufferSize, stdout);
            status))
  


    fun catFiles (files: string list) =
      withBuffer (Word.fromInt bufferSize)
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
                  

    val _ = MLWorks.Deliver.deliver ("kitten", main, MLWorks.Deliver.CONSOLE);

  end
