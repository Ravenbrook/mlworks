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
 * A very simple telephone database built on ndbm.
 * See the associated README for more information.
 * 
 * Revision Log
 * ------------
 * $Log: __phones.sml,v $
 * Revision 1.7  1998/10/28 11:30:46  jkbrook
 * [Bug #70184]
 * Remove debugging print statement
 *
 *  Revision 1.6  1998/10/26  14:43:57  jkbrook
 *  [Bug #70184]
 *  Update for changes to OS.Process
 *
 *  Revision 1.5  1998/01/22  19:03:58  jkbrook
 *  [Bug #70047]
 *  Syntax for delivery has changed
 *
 *  Revision 1.4  1997/07/07  12:36:20  stephenb
 *  [Bug #30029]
 *  Don't pass C to MLWorksCPointer since it is no longer required.
 *
 *  Revision 1.3  1997/07/02  10:04:06  stephenb
 *  [Bug #30029]
 *  The previous version used the signatures/structures from
 *  the prototype version the new FI.  This version uses the
 *  signatures/structures that a customer will see.
 *
 *  Revision 1.2  1997/05/22  10:48:54  stephenb
 *  [Bug #30121]
 *  The README is now either called README or README.TXT depending on
 *  the platform rather than README.txt.  So just refer to the file as README.
 *
 *  Revision 1.1  1997/05/02  09:35:08  stephenb
 *  new unit
 *  [Bug #30030]
 *
 *)

require "$.basis.__char";    (* Char.isSpace *)
require "$.basis.__string";  (* String.fields *)
require "$.basis.__int";     (* Int.toString *)
require "$.basis.__text_io"; (* TextIO.* *)
require "$.basis.__io";      (* IO.Io *)
require "$.basis.__list";    (* List.foldl *)
require "$.system.__os";     (* OS.Process.exit *)
require "$.basis.__word";
require "$.foreign._mlworks_c_pointer";
require "$.foreign.__mlworks_c_interface";
require "$.foreign.__mlworks_c_resource";
require "__open_flags";
require "__ndbm";


(* This is an application which is going to be delivered so there 
 * is nothing to be exported from the structure
 *)
structure Phones (* : sig end *) = 
  struct

    exception OutOfMemory
    exception CannotOpenDbmFile

    structure C = MLWorksCInterface

    (*
    **.fix.stderr: the error message should be displayed on stderr
    *)
    fun openError databaseName =
      (print "Cannot open ";
       print databaseName;
       print " as a phones database\n";
       OS.Process.exit OS.Process.failure)


    fun internalError databaseName =
      (print "internal error when reading ";
       print databaseName;
       print "\n";
       OS.Process.exit OS.Process.failure)


    structure datumPtr = MLWorksCPointer
      (type value = Ndbm.datum;
       val size = Ndbm.datum'size';
       val addr = Ndbm.datum'addr')

    fun makeDatum data =
      let
        val datum' = datumPtr.make ()
        val datum = datumPtr.! datum'
        val dataPtr = C.CharPtr.fromString data
        val size' = (C.Uint.fromInt (size data))
        val _ = C.PtrPtr.:= (Ndbm.datum'dptr'addr datum, dataPtr)
        val _ = C.UintPtr.:= (Ndbm.datum'dsize'addr datum, size')
      in
        datum
      end

    datatype access_type = READ | WRITE

    fun accessTypeToFlags (m, flags) = 
      case m of
        READ =>
          if flags = OpenFlags.O_WRONLY
          then OpenFlags.O_RDWR + OpenFlags.O_CREAT
          else OpenFlags.O_RDONLY
      | WRITE =>
          if flags = OpenFlags.O_RDONLY
          then OpenFlags.O_RDWR + OpenFlags.O_CREAT
          else OpenFlags.O_WRONLY


    (*
     * Apply 'f' to every element in 'db' with 'z' as the left zero.
     *)
    fun foldDb f z (db: Ndbm.DBM C.ptr) =
      let
        fun aux (v as (z, keyDatum)) = 
          if Ndbm.datum'dptr keyDatum = C.null then
            z
          else
            aux (f v, Ndbm.dbm_nextkey db)
      in
        aux (z, Ndbm.dbm_firstkey db)
      end


    val withResource = MLWorksCResource.withResource

    val withNonNullResource = MLWorksCResource.withNonNullResource

    fun withDatum datum f =
      withResource (datumPtr.free o Ndbm.datum'addr', datum, f)

    fun withCString str action =
      withNonNullResource (C.CharPtr.free, OutOfMemory, str, action)

    fun withNdbm db action =
       withNonNullResource (Ndbm.dbm_close, CannotOpenDbmFile, db, action)


    local
      fun fWrapper (f, data) datum' =
        let
          val datum = datumPtr.! datum'
          val dataPtr = C.CharPtr.fromString data
          val size' = C.Uint.fromInt (size data)
          val _ = C.PtrPtr.:= (Ndbm.datum'dptr'addr datum, dataPtr)
          val _ = C.UintPtr.:= (Ndbm.datum'dsize'addr datum, size')
        in
          f datum
        end
    in
      fun withNewDatum data f =
        withNonNullResource (datumPtr.free, OutOfMemory, datumPtr.make (), fWrapper (f, data))
    end



    (*
     * Open an Ndbm database with the given 'fileName' and 'accessTypes'.
     * If it cannot be opended for any reason, 'fail' is called.
     * If the database can be opened, then 'succ' is called with the database
     * as its only argument.
     *)
    fun withDb (fileName, accessTypes, action: Ndbm.DBM C.ptr -> 'a) =
      let 
        val flags = C.Int.fromInt (List.foldl accessTypeToFlags 0 accessTypes)
        val mode = C.Int.fromInt 0x1b0 (* 0660 *)
      in
        withCString (C.CharPtr.fromString fileName)
          (fn name =>
             withNdbm (Ndbm.dbm_open (name, flags, mode)) action)
      end


    fun withReadOnlyDb (databaseName: string) action =
      withDb (databaseName, [READ], action)
        handle CannotOpenDbmFile => openError databaseName



    fun withWriteOnlyDb (databaseName: string) action =
      withDb (databaseName, [WRITE], action)
        handle CannotOpenDbmFile => openError databaseName



    fun addPerson (db, name: string, phoneNumber: string) =
      withNewDatum name
        (fn nameDatum => 
          withNewDatum phoneNumber
           (fn phoneDatum =>
             let
               val result = Ndbm.dbm_store (db, nameDatum, phoneDatum, Ndbm.DBM_INSERT)
               val result' = C.Int.toInt result
             in
               if result' = 1 then
                 (print "Sorry, cannot add ";
                  print name;
                  print " since it is already in the database\n")
               else
                 ()
             end))


    fun foldOverLinesInInputFile
     (inputFileName: string)
     (fail: string * string -> unit)
     (succ: int * string -> unit) =
      let
        val stream = TextIO.openIn inputFileName
        fun loop lineNumber =
          if TextIO.endOfStream stream then
            TextIO.closeIn stream
          else
            (succ (lineNumber, TextIO.inputLine stream);
            loop (lineNumber+1))
      in
        loop 0
      end
      handle IO.Io {name, function, ...} => fail (name, function)



    fun createDb (inputFileName, databaseName) =
      withWriteOnlyDb databaseName
        (fn db =>
           (foldOverLinesInInputFile inputFileName
             (fn (name, function) =>
               (print "Could not ";
                print function;
                print " from ";
                print name;
                print "\n"))
             (fn (lineNumber, line) =>
               (case String.fields Char.isSpace line of
                  [name, phoneNumber, ""] =>
                    (addPerson (db, name, phoneNumber); ())
                | [] => ()
                | _ =>
                  (print "Malformed input on line ";
                   print (Int.toString lineNumber);
                   print " ";
                   print line;
                   print "\n")))))



    val wordFromUint = Word.fromLargeWord o C.Uint.toLargeWord

    fun datumToString (datum: Ndbm.datum): string =
      let
        val data = Ndbm.datum'dptr datum
        val size = wordFromUint (Ndbm.datum'dsize datum)
      in
        C.CharPtr.copySubString (data, size)
      end



    fun getNumber (db, nameDatum) =
      withDatum (Ndbm.dbm_fetch (db, nameDatum)) 
        (fn phoneDatum =>
          if Ndbm.datum'dptr phoneDatum = C.null then
            NONE
          else
            SOME (datumToString phoneDatum))



    fun dumpDb databaseName =
      withReadOnlyDb databaseName
        (fn db =>
          let
            fun dumpItem (z, nameDatum) =
              let
                val name = datumToString nameDatum
              in
                case (getNumber (db, nameDatum)) of
                 NONE => internalError databaseName
               | SOME number =>
                  (print name;
                   print " ";
                   print number;
                   print "\n";
                   datumPtr.free (Ndbm.datum'addr' nameDatum))
              end
          in
            foldDb dumpItem () db
          end)



    fun lookupInDb (personName, databaseName) =
      withReadOnlyDb databaseName
        (fn db =>
          withNewDatum personName
            (fn personDatum =>
              case getNumber (db, personDatum) of
                NONE =>
                  (print "Sorry, no number available for ";
                   print personName;
                   print "\n")
              | SOME number =>
                 (print personName;
                  print " ";
                  print number;
                  print "\n")))



    fun removeFromDb (personName, databaseName) =
      withWriteOnlyDb databaseName
        (fn db =>
          withNewDatum personName
            (fn person =>
              let
                val result = Ndbm.dbm_delete (db, person)
                val result' = C.Int.toInt result
              in
                if result' <> 0 then
                  (print "Sorry, cannot remove ";
                   print personName;
                   print " from ";
                   print databaseName;
                   print " since ";
                   print personName;
                   print " is not in the database\n")
                else
                  ()
              end))



    fun addToDb (personName, phoneNumber, databaseName) =
      withWriteOnlyDb databaseName
        (fn db => addPerson (db, personName, phoneNumber))



    (*
    **.fix.stderr: the usage message should be displayed on stderr.
    **.fix.prog-name: the usage message should include the name of the program.
    *)
    fun usage () =
      (print "[ -c input | -d | -r person | -a person phone | -l person ] database\n";
      OS.Process.exit OS.Process.failure)



    fun parseArgs ("-c"::inputFileName::[databaseName]) =
        createDb (inputFileName, databaseName)
    | parseArgs ("-d"::[databaseName]) =
        dumpDb databaseName
    | parseArgs ("-l"::personName::[databaseName]) =
        lookupInDb (personName, databaseName)
    | parseArgs ("-r"::personName::[databaseName]) =
        removeFromDb (personName, databaseName)
    | parseArgs ("-a"::personName::phoneNumber::[databaseName]) =
        addToDb (personName, phoneNumber, databaseName)
    | parseArgs _ = usage ()


    fun main () =
      (parseArgs (MLWorks.arguments ()))
      handle OutOfMemory => print "out of memory\n";

    val _ = MLWorks.Deliver.deliver ("phones", main, MLWorks.Deliver.CONSOLE);

  end
