(*  ==== MODIFY NEW JERSEY ENVIRONMENT ====
 *
 *  Copyright (C) 1993 Harlequin Ltd
 *
 *  Description
 *  -----------
 *  This New Jersey ML source simulates the MLWorks pervasive environment
 *  under New Jersey, to the extent that we are able to compile the
 *  compiler.
 *
 *  Revision Log
 *  ------------
 *  $Log: change_nj.sml,v $
 *  Revision 1.113  1996/04/18 09:15:09  stephenb
 *  Remove exit, terminate, atExit and most of the OS structure since
 *  they are no longer needed now that OS.Process has been updated.
 *
 * Revision 1.112  1996/03/28  10:08:24  matthew
 * Adding definition of outstream
 *
 * Revision 1.111  1996/03/08  12:04:29  daveb
 * Converted the types Dynamic and Type to the new identifier naming scheme.
 *
 * Revision 1.110  1996/02/22  14:54:37  daveb
 * Moved MLWorks.Dynamic to MLWorks.Internal.Dynamic.  Hid some members; moved
 * some functionality to the Shell structure.
 *
 * Revision 1.109  1996/02/16  15:38:29  nickb
 * name change fn_save => deliver
 *
 *  Revision 1.108  1996/01/23  10:32:07  matthew
 *  Adding nj-env.sml file
 *
 *  Revision 1.107  1996/01/22  08:34:29  stephenb
 *  OS reorganisation: Remove the OS specific stuff since
 *  this is no longer in the pervasive library.
 *
 *  Revision 1.106  1996/01/16  12:15:33  nickb
 *  Change to GC interface.
 *
 *  Revision 1.105  1996/01/15  16:24:18  matthew
 *  Adding NT directory operations
 *
 *  Revision 1.104  1996/01/15  11:49:46  nickb
 *  Add thread sleep and wake operations.
 *
 *  Revision 1.103  1996/01/15  09:28:31  stephenb
 *  Update wrt change in ../pervasive/__pervasive_library.sml
 *
 *  Revision 1.102  1996/01/08  14:28:48  nickb
 *  Signal reservation removed.
 *
 *  Revision 1.101  1995/12/04  15:46:54  daveb
 *  Pervasive module names now begin with a space.
 *
 *  Revision 1.100  1995/11/21  11:23:35  jont
 *  Add Frame.frame_double for accessing directly spilled reals
 *
 *  Revision 1.99  1995/10/17  12:53:35  jont
 *  Add exec_save for saving executables
 *
 *  Revision 1.98  1995/09/18  09:52:54  daveb
 *  COrrected syntax error.
 *
 *  Revision 1.97  1995/09/18  09:12:57  daveb
 *  Made quot and rem be nonfix.
 *
 *  Revision 1.96  1995/09/13  14:26:22  jont
 *  Add fn_save
 *
 *  Revision 1.95  1995/09/13  13:44:00  daveb
 *  Removed bogus path name that I was using to test previous changes.
 *
 *  Revision 1.94  1995/09/13  13:08:39  daveb
 *  Implemented overloaded types for different sizes of words and ints.
 *
 *  Revision 1.93  1995/08/10  15:42:01  jont
 *  Add ml_char for giving textual representation of chars
 *
 *  Revision 1.92  1995/07/28  08:31:40  matthew
 *  Adding makestring function to Word structure
 *
 *  Revision 1.91  1995/07/25  14:01:17  jont
 *  Add Word structure and Overflow exn
 *
 *  Revision 1.90  1995/07/24  10:06:29  jont
 *  Add Overflow to structure exception
 *
 *  Revision 1.89  1995/07/19  15:10:31  nickb
 *  Two constructors called MLWorks.Profile.Profile.
 *
 *  Revision 1.88  1995/07/19  13:53:24  nickb
 *  Whoops; major type screwups in new profiler.
 *
 *  Revision 1.87  1995/07/19  13:40:57  nickb
 *  Change to profiler interface.
 *
 *  Revision 1.86  1995/07/19  09:15:59  jont
 *  Add chars stuff
 *  Also add new integer functions for hex printing
 *
 *  Revision 1.85  1995/06/02  13:59:54  nickb
 *  Change threads restart system.
 *
 *  Revision 1.84  1995/05/23  15:43:53  nickb
 *  Add threads system.
 *
 *  Revision 1.83  1995/05/11  09:35:56  jont
 *  Bring up to date with revised basis stuff in __pervasive_library.sml
 *
 *  Revision 1.82  1995/05/02  13:13:11  matthew
 *  Adding CAST and UMAP primitives
 *  Removing some stuff from Debugger
 *
 *  Revision 1.81  1995/04/18  09:06:55  jont
 *  Add missing values atExit and terminate
 *
 *  Revision 1.80  1995/03/20  10:41:00  matthew
 *  Adding implode_char
 *
 *  Revision 1.79  1995/03/02  13:41:07  matthew
 *  Unifying Value.Frame and Frame.pointer
 *
 *  Revision 1.78  1995/01/16  10:16:10  jont
 *  Bring into line with current state of Win_nt structure (getcd and get_path_name)
 *
 *  Revision 1.77  1994/12/09  14:39:46  jont
 *  Add OS.Win_nt structure
 *
 *  Revision 1.76  1994/11/24  16:13:54  matthew
 *  Adding new unsafe operations in MLWorks.Internal.Value
 *
 *  Revision 1.75  1994/09/27  16:05:01  matthew
 *  Added pervasive Option structure
 *
 *  Revision 1.74  1994/08/25  09:12:36  matthew
 *  Adding unsafe array operations
 *
 *  Revision 1.73  1994/07/08  10:13:32  nickh
 *  Add event functions for stack overflow and interrupt handlers.
 *
 *  Revision 1.72  1994/07/01  14:58:51  jont
 *  Add messages to Io
 *
 *  Revision 1.71  1994/06/24  09:01:44  nickh
 *  Add trace.restore_all
 *
 *  Revision 1.70  1994/06/10  10:03:18  nosa
 *  Breakpoint settings on function exits.
 *
 *  Revision 1.69  1994/06/09  15:40:59  nickh
 *  Updated runtime system handling.
 *
 *  Revision 1.68  1994/04/08  08:04:49  daveb
 *  Updated with set_file_modified and associated type.
 *
 *  Revision 1.67  1994/03/24  16:16:24  daveb
 *  Adding handler around realpath.
 *
 *  Revision 1.66  1994/03/24  10:41:48  daveb
 *  Fixing typo (braino?).
 *
 *  Revision 1.65  1994/03/23  17:35:08  daveb
 *  Added realpath to NJ runtime.
 *
 *  Revision 1.64  1994/03/14  17:37:26  nickh
 *  Add an fsync when closing files.
 *
 *  Revision 1.63  1994/03/01  10:08:05  nosa
 *  option was missing in structure Debugger.
 *
 *  Revision 1.62  1994/02/27  22:01:08  nosa
 *  Step and breakpoints Debugger.
 *
 *  Revision 1.61  1994/02/08  17:27:42  nickh
 *  Hope it works now :-)
 *
 *  Revision 1.60  1994/02/08  14:26:08  matthew
 *  Added definition for realpath.  This is just the identity function.
 *
 *  Revision 1.59  1994/02/08  10:51:34  nickh
 *  Added MLWorks.String.ml_string
 *
 *  Revision 1.58  1994/02/03  09:47:49  matthew
 *  Added definition for getwd
 *
 *  Revision 1.57  1993/11/26  12:31:52  nickh
 *  Hacks for Elapsed.elapsed, elapsed_since, format.
 *
 *  Revision 1.56  1993/11/22  16:26:36  jont
 *  Changed type of modules to include a time stamp field
 *
 *  Revision 1.55  1993/11/18  12:16:15  nickh
 *  Add to IO and RawIO to provide closed_in and closed_out functions for
 *  testing open/closed status. (also fix Time structure bug).
 *
 *  Revision 1.54  1993/11/15  15:18:52  nickh
 *  New pervasive time structure; in particular extension to encode/decode.
 *
 *  Revision 1.53  1993/08/31  09:52:13  daveb
 *  Added OS.Unix.{unlink,rmdir,mkdir}
 *
 *  Revision 1.52  1993/08/26  11:13:21  richard
 *  Removed the X exception.  It's now in the Motif interface code.
 *
 *  Revision 1.51  1993/08/26  10:09:04  richard
 *  Declared a special version of require for the pervasive modules.  This
 *  is necessary because of changes to the module naming scheme.
 *
 *  Revision 1.50  1993/08/26  09:58:26  richard
 *  Added X exception.
 *
 *  Revision 1.49  1993/08/25  14:01:00  richard
 *  Added dummy MLWorks.OS.Unix.kill.
 *
 *  Revision 1.48  1993/07/28  11:35:56  richard
 *  Changes to MLWORKS signature.  See pervasive/mlworks.sml.
 *
 *  Revision 1.47  1993/07/19  13:37:03  nosa
 *  Added two frame functions for debugger
 *
 *  Revision 1.46  1993/06/10  15:58:25  matthew
 *  Added text_preprocess hook
 *
 *  Revision 1.45  1993/05/05  16:05:56  jont
 *  Added MLWorks.OS.Unix.password_file to get the association list of user names
 *  to home directories necessary for translating ~
 *
 *  Revision 1.44  1993/04/23  14:51:13  jont
 *  Added Integer and Real substructures of MLWorks
 *
 *  Revision 1.43  1993/04/22  17:22:21  jont
 *  Added write_byte for FileIO and output_byte to RawIO
 *
 *  Revision 1.42  1993/04/22  13:39:46  richard
 *  Removed defunct Editor interface and added sytem calls to enable
 *  its replacement.
 *
 *  Revision 1.41  1993/04/20  10:12:57  richard
 *  New Unix and Trace stuff.  See MLWorks signature.
 *
 *  Revision 1.40  1993/04/13  09:59:17  matthew
 *  Changed TypeRep to Dynamic and restructured
 *  Moved break stuff out of tracing.
 *  
 *  Revision 1.39  1993/04/08  17:29:56  jont
 *  Minor modifications to editor structure
 *  
 *  Revision 1.38  1993/04/06  13:00:31  jont
 *  Removed use of pervasive ordof
 *  
 *  Revision 1.37  1993/04/02  15:27:40  jont
 *  Extended images structure to include table of contents reading
 *  
 *  Revision 1.36  1993/03/26  15:53:27  matthew
 *  Added break function to Tracing substructure
 *  
 *  Revision 1.35  1993/03/23  18:32:34  jont
 *  Minor change to interface to edit file
 *  
 *  Revision 1.34  1993/03/11  18:37:25  jont
 *  Added Intermal.Images including save and clean. Added other_operation to
 *  Editor for arbitrary bits of emacs lisp
 *  
 *  Revision 1.33  1993/03/10  16:30:56  jont
 *  Added editor substructure to MLWorks
 *  
 *  Revision 1.32  1993/02/18  16:56:08  matthew
 *  Added TypeRep signature in MLWorks.Internal
 *  
 *  Revision 1.31  1993/02/17  11:05:21  daveb
 *  Corrected string argument to Unimplemented for MLWorks.Time.Real.now.
 *  
 *  Revision 1.30  1993/01/05  16:54:24  richard
 *  Added some extra exceptions for the runtime system.
 *  
 *  Revision 1.29  1992/12/22  10:50:12  clive
 *  ExtendedArray should not be available at the top level
 *  
 *  Revision 1.28  1992/12/22  10:25:37  daveb
 *  Made ExtendedArray visible at top level.
 *  
 *  Revision 1.27  1992/12/22  10:05:26  clive
 *  Needed to define the type T in the Array structure
 *  
 *  Revision 1.26  1992/12/22  10:02:01  matthew
 *  Added 'agreed' Array and Vector structures.
 *  
 *  Revision 1.25  1992/12/01  13:05:26  matthew
 *  Fixed problem with IO
 *  
 *  Revision 1.24  1992/12/01  12:45:10  matthew
 *  Changed IO structure to mirror __pervasive_library
 *  
 *  Revision 1.23  1992/11/12  15:58:16  clive
 *  Added some rts support for tracing
 *  
 *  Revision 1.22  1992/11/10  13:14:23  richard
 *  Added StorageManager exception and changed the type of the
 *  StorageManager interface function.
 *  
 *  Revision 1.21  1992/11/02  10:06:49  richard
 *  Many changes.  See MLWorks signature.
 *  
 *  Revision 1.20  1992/09/25  14:36:13  matthew
 *  Added Internal.string_to_real
 *  
 *  Revision 1.19  1992/09/23  16:16:41  daveb
 *  Added clear_eof function to IO (unimplemented).
 *  
 *  Revision 1.18  1992/09/01  14:34:40  richard
 *  Changed the OS information stuff to functions.  Added Prod and
 *  Value exceptions.
 *  Implemented save.
 *  
 *  Revision 1.17  1992/08/28  15:00:49  clive
 *  Added a function to the pervasive_library to get debug_info from a
 *  function
 *  
 *  Revision 1.16  1992/08/28  08:26:28  richard
 *  Changed call to environment so that environment is not
 *  preserved across images.
 *  Added floating-point exceptions.
 *  
 *  Revision 1.15  1992/08/26  14:34:26  richard
 *  Rationalisation of the MLWorks structure.
 *  
 *  Revision 1.14  1992/08/25  16:27:11  richard
 *  Added ByteArray structure and writebf in FileIO.
 *  
 *  Revision 1.13  1992/08/24  14:16:46  davidt
 *  Added a faster implementation of FileIO.writef which
 *  doesn't allocate as many bytearrays.
 *  
 *  Revision 1.12  1992/08/20  12:44:05  richard
 *  Changed path of require of mlworks to use pervasive directory.
 *  
 *  Revision 1.11  1992/08/20  08:33:04  richard
 *  Enriched the Array structure.
 *  
 *  Revision 1.10  1992/08/18  16:40:49  richard
 *  Added real_to_string.
 *  
 *  Revision 1.9  1992/08/18  14:44:59  richard
 *  Changes to the MLWorks signature.  See mlworks file for
 *  details.
 *  
 *  Revision 1.8  1992/08/17  11:05:12  richard
 *  Added MLWorks.System.Runtime.GC.interface.
 *  
 *  Revision 1.7  1992/08/15  17:32:57  davidt
 *  Put in MLWorks.IO.input_line function.
 *  
 *  Revision 1.6  1992/08/13  15:30:59  clive
 *  Added two functions to the debugger
 *  
 *  Revision 1.4  1992/08/12  14:21:36  davidt
 *  Took out copying of Array and String structures from the
 *  MLWorks structure in an attempt to see if NewJersey was
 *  getting confused and not inlining code for array updates.
 *  
 *  Revision 1.3  1992/08/11  05:59:23  richard
 *  Added load_wordset to Int structure.
 *  
 *  Revision 1.2  1992/08/10  15:26:16  davidt
 *  Changed MLworks structure to MLWorks
 *  
 *  Revision 1.1  1992/08/07  15:03:28  davidt
 *  Initial revision
 *  
 *  Revision 1.1  1992/05/18  15:40:36  clive
 *  Initial revision
 *)

(* This require is just for the pervasive modules. *)

fun require s =
  (fn SOME #" " => use ("../pervasive/" ^ String.substring (s, 1, size s - 1) ^ ".sml")
    | _ => use ("../pervasive/" ^ s ^ ".sml")) (Char.fromString s);

type word = int;

nonfix quot rem;

require "mlworks";

exception Unimplemented of string
fun unimplemented name =
  (output (std_out, "unimplemented MLWorks pervasive: " ^ name ^ "\n");
   raise Unimplemented name)

structure MLWorks : MLWORKS =
  struct

    structure Option = 
      struct
        datatype 'a option = SOME of 'a | NONE 
        datatype ('a,'b) union = INL of 'a | INR of 'b 
      end

    structure Bits =
      struct
	open NewJersey.Bits
	fun arshift _ = unimplemented "MLWorks.Bits.arshift"
      end

    structure Vector =
      struct
        datatype 'a vector = Vector of 'a list

        exception Size
        exception Subscript

	nonfix sub

        val vector = Vector

        fun tabulate (i, f) =
          let fun tab j = if j < i then f j :: tab (j+1) else nil
          in if i < 0 then raise Size else Vector (tab 0)
          end

        fun sub (Vector nil, i) = raise Subscript
        |   sub (Vector (a::r), i) =
          if i > 0 then sub (Vector r, i-1)
          else if i < 0 then raise Subscript
          else a

        fun length (Vector nil) = 0
        |   length (Vector (a::r)) = 1 + length (Vector r)
      end

    structure Array = 
      struct
        open NewJersey.Array
          type 'a T = 'a array
      end

    structure ExtendedArray =
      struct
        open NewJersey.Array

        nonfix sub
        type 'a T = 'a array

        fun tabulate (l, f) =
          if l = 0 then
            arrayoflist []
          else
            let
              val first = f 0
              val a = array (l, first)

              fun init 0 = a
                | init n =
                  (update (a, n-l, f (n-l));
                   init (n-1))
            in
              init (l-1)
            end

        val from_list = arrayoflist

        fun fill (a, x) =
          let
            fun fill' 0 = ()
              | fill' n =
                (update (a, n-1, x);
                 fill' (n-1))
          in
            fill' (length a)
          end

        fun map f a =
          let
            val l = length a
          in
            if l = 0 then
              from_list []
            else
              let
                val first = f (sub (a, 0))
                val new = array (l, first)

                fun map' 0 = new
                  | map' n =
                    (update (new, l-n, f (sub (a, l-n)));
                     map' (n-1))
              in
                map' (l-1)
              end
          end

        fun map_index f a =
          let
            val l = length a
          in
            if l = 0 then
              from_list []
            else
              let
                val first = f (0, sub (a, 0))
                val new = array (l, first)

                fun map' 0 = new
                  | map' n =
                    (update (new, l-n, f (l-n, sub (a, l-n)));
                     map' (n-1))
              in
                map' (l-1)
              end
          end

        fun to_list a =
          let
            fun to_list' (0, list) = list
              | to_list' (n, list) =
                to_list' (n-1, sub (a, n-1) :: list)
          in
            to_list' (length a, nil)
          end

        fun iterate f a =
          let
            val l = length a

            fun iterate' 0 = ()
              | iterate' n =
                (f (sub (a, l-n));
                 iterate' (n-1))
          in
            iterate' l
          end

        fun iterate_index f a =
          let
            val l = length a

            fun iterate' 0 = ()
              | iterate' n =
                (f (l-n, sub (a, l-n));
                 iterate' (n-1))
          in
            iterate' l
          end

        fun rev a =
          let
            val l = length a
          in
            if l = 0 then
              from_list []
            else
              let
                val first = sub (a, 0)
                val new = array (l, first)

                fun rev' 0 = new
                  | rev' n =
                    (update (new, n-1, sub (a, l-n));
                     rev' (n-1))
              in
                rev' (l-1)
              end
          end

        fun duplicate a =
          let
            val l = length a
          in
            if l = 0 then
              from_list []
            else
              let
                val first = sub (a, 0)
                val new = array (l, first)

                fun duplicate' 0 = new
                  | duplicate' n =
                    (update (new, l-n, sub (a, l-n));
                     duplicate' (n-1))
              in
                duplicate' (l-1)
              end
          end

        exception Subarray of int * int
        fun subarray (a, start, finish) =
          let
            val l = length a
          in
            if start < 0 orelse start > l orelse finish > l orelse
               start > finish then
              raise Subarray (start, finish)
            else
              let
                val l' = finish - start
              in
                if l' = 0 then
                  from_list []
                else
                  let
                    val first = sub (a, start)
                    val new = array (l', first)

                    fun copy 0 = new
                      | copy n =
                        (update (new, l'-n, sub (a, start+l'-n));
                         copy (n-1))
                  in
                    copy (l'-1)
                  end
              end
          end

        fun append (array1, array2) =
          let
            val l1 = length array1
            val l2 = length array2
            val l = l1 + l2
          in
            if l = 0 then
              from_list []
            else
              let
                val first =
                  if l1 = 0 then
                    sub (array2, 0)
                  else
                    sub (array1, 0)

                val new = array (l, first)

                fun copy1 0 = new
                  | copy1 n =
                    (update (new, l1-n, sub (array1, l1-n));
                     copy1 (n-1))

                fun copy2 0 = copy1 (l1-1)
                  | copy2 n =
                    (update (new, l-n, sub (array2, l2-n));
                     copy2 (n-1))
              in
                copy2 l2
              end
          end

        fun reducel f (i, a) =
          let
            val l = length a

            fun reducel' (i, 0) = i
              | reducel' (i, n) =
                reducel' (f (i, sub (a, l-n)), n-1)
          in
            reducel' (i, l)
          end

        fun reducel_index f (i, a) =
          let
            val l = length a

            fun reducel' (i, 0) = i
              | reducel' (i, n) =
                reducel' (f (l-n, i, sub (a, l-n)), n-1)
          in
            reducel' (i, l)
          end

        fun reducer f (a, i) =
          let
            val l = length a

            fun reducer' (0, i) = i
              | reducer' (n, i) =
                reducer' (n-1, f (sub (a, n-1), i))
          in
            reducer' (l, i)
          end

        fun reducer_index f (a, i) =
          let
            val l = length a

            fun reducer' (0, i) = i
              | reducer' (n, i) =
                reducer' (n-1, f (n-1, sub (a, n-1), i))
          in
            reducer' (l, i)
          end

        exception Copy of int * int * int
        fun copy (from, start, finish, to, start') =
          let
            val l1 = length from
            val l2 = length to
          in
            if start < 0 orelse start > l1 orelse finish > l1 orelse
               start > finish orelse
               start' < 0 orelse start' + finish - start > l2 then
              raise Copy (start, finish, start')
            else
              let
                fun copy' 0 = ()
                  | copy' n =
                    (update (to, start'+n-1, sub (from, start+n-1));
                     copy' (n-1))
              in
                copy' (finish - start)
              end
          end

        exception Fill of int * int
        fun fill_range (a, start, finish, x) =
          let
            val l = length a
          in
            if start < 0 orelse start > l orelse finish > l orelse
               start > finish then
              raise Fill (start, finish)
            else
              let
                fun fill' 0 = ()
                  | fill' n =
                    (update (a, start+n-1, x);
                     fill' (n-1))
              in
                fill' (finish - start)
              end
          end

        exception Find
        fun find predicate a =
          let
            val l = length a
            fun find' 0 = raise Find
              | find' n = if predicate (sub (a, l-n)) then l-n else find' (n-1)
          in
            find' l
          end

        fun find_default (predicate, default) a =
          let
            val l = length a
            fun find' 0 = default
              | find' n = if predicate (sub (a, l-n)) then l-n else find' (n-1)
          in
            find' l
          end

      end

    structure String =
      struct
	fun ml_string (s,max_size) =
	  let
	    fun to_digit n = chr (n +ord "0")
	      
	    fun aux ([],result,_) = implode (rev result)
	      | aux (_,result,0) = implode (rev ("\\..." :: result))
	      | aux (char::rest,result,n) =
		let val newres =
		  case char of 
		    "\n" => "\\n"::result
		  | "\t" => "\\t"::result
		  | "\"" => "\\\""::result
		  | "\\" => "\\\\"::result
		  | c =>
		      let val n = ord c
		      in
			if n < 32 orelse n >= 127 then
			  let
			    val n1 = n div 10
			  in
			    (to_digit (n mod 10))::
			    (to_digit (n1 mod 10))::
			    (to_digit (n1 div 10))::
			    ("\\")::result
			  end
			else
			  c::result
		      end
		in
		  aux (rest, newres, n-1)
		end
	  in
	    aux (explode s,[],if max_size<0 then ~1 else max_size)
	  end
	open NewJersey.String

        fun implode_char l = implode (map chr l)

      end
    
    structure Char =
      struct
	type char = int
	fun ml_char c = String.ml_string(chr c, ~1)
	val chr = fn x => x
	val ord = fn x => x
	val maxCharOrd = 255
	exception Chr = Chr

	(* Finally define these *)
	val op <  : char * char -> bool = op <
	val op >  : char * char -> bool = op >
	val op <= : char * char -> bool = op <=
	val op >= : char * char -> bool = op >=
      end

    structure ByteArray = 
      struct
        open NewJersey.ByteArray

        exception Range of int
        exception Size

        nonfix sub
        type T = bytearray
 
        val iterate = app

        val array = fn argument => 
          array argument handle Ord => raise Size

        exception Substring = NewJersey.Substring
        fun substring argument =
          extract argument handle _ => raise Substring

        fun to_string b = extract (b, 0, length b)

        fun from_string s =
          let
            val l = size s
            val b = array (l, 0)
            fun from_string' 0 = b
              | from_string' n =
                (update (b, n-1, NewJersey.String.ordof (s, n-1));
                 from_string' (n-1))
          in
            from_string' l
          end

        fun from_list list =
          let
            fun list_length (n, []) = n
              | list_length (n, _::xs) = list_length (n+1, xs)

            val new = array (list_length (0, list), 0)

            fun fill (_, []) = new
              | fill (n, x::xs) =
                (update (new, n, x);
                 fill (n+1, xs))
          in
            fill (0, list)
          end

        val arrayoflist = from_list

        fun tabulate (l, f) =
          if l = 0 then
            arrayoflist []
          else
            let
              val first = f 0
              val a = array (l, first)

              fun init 0 = a
                | init n =
                  (update (a, n-l, f (n-l));
                   init (n-1))
            in
              init (l-1)
            end

        val from_list = arrayoflist

        fun fill (a, x) =
          let
            fun fill' 0 = ()
              | fill' n =
                (update (a, n-1, x);
                 fill' (n-1))
          in
            fill' (length a)
          end

        fun map f a =
          let
            val l = length a
          in
            if l = 0 then
              from_list []
            else
              let
                val first = f (sub (a, 0))
                val new = array (l, first)

                fun map' 0 = new
                  | map' n =
                    (update (new, l-n, f (sub (a, l-n)));
                     map' (n-1))
              in
                map' (l-1)
              end
          end

        fun map_index f a =
          let
            val l = length a
          in
            if l = 0 then
              from_list []
            else
              let
                val first = f (0, sub (a, 0))
                val new = array (l, first)

                fun map' 0 = new
                  | map' n =
                    (update (new, l-n, f (l-n, sub (a, l-n)));
                     map' (n-1))
              in
                map' (l-1)
              end
          end

        fun to_list a =
          let
            fun to_list' (0, list) = list
              | to_list' (n, list) =
                to_list' (n-1, sub (a, n-1) :: list)
          in
            to_list' (length a, nil)
          end

        fun iterate f a =
          let
            val l = length a

            fun iterate' 0 = ()
              | iterate' n =
                (f (sub (a, l-n));
                 iterate' (n-1))
          in
            iterate' l
          end

        fun iterate_index f a =
          let
            val l = length a

            fun iterate' 0 = ()
              | iterate' n =
                (f (l-n, sub (a, l-n));
                 iterate' (n-1))
          in
            iterate' l
          end

        fun rev a =
          let
            val l = length a
          in
            if l = 0 then
              from_list []
            else
              let
                val first = sub (a, 0)
                val new = array (l, first)

                fun rev' 0 = new
                  | rev' n =
                    (update (new, n-1, sub (a, l-n));
                     rev' (n-1))
              in
                rev' (l-1)
              end
          end

        fun duplicate a =
          let
            val l = length a
          in
            if l = 0 then
              from_list []
            else
              let
                val first = sub (a, 0)
                val new = array (l, first)

                fun duplicate' 0 = new
                  | duplicate' n =
                    (update (new, l-n, sub (a, l-n));
                     duplicate' (n-1))
              in
                duplicate' (l-1)
              end
          end

        exception Subarray of int * int
        fun subarray (a, start, finish) =
          let
            val l = length a
          in
            if start < 0 orelse start > l orelse finish > l orelse
               start > finish then
              raise Subarray (start, finish)
            else
              let
                val l' = finish - start
              in
                if l' = 0 then
                  from_list []
                else
                  let
                    val first = sub (a, start)
                    val new = array (l', first)

                    fun copy 0 = new
                      | copy n =
                        (update (new, l'-n, sub (a, start+l'-n));
                         copy (n-1))
                  in
                    copy (l'-1)
                  end
              end
          end

        fun append (array1, array2) =
          let
            val l1 = length array1
            val l2 = length array2
            val l = l1 + l2
          in
            if l = 0 then
              from_list []
            else
              let
                val first =
                  if l1 = 0 then
                    sub (array2, 0)
                  else
                    sub (array1, 0)

                val new = array (l, first)

                fun copy1 0 = new
                  | copy1 n =
                    (update (new, l1-n, sub (array1, l1-n));
                     copy1 (n-1))

                fun copy2 0 = copy1 (l1-1)
                  | copy2 n =
                    (update (new, l-n, sub (array2, l2-n));
                     copy2 (n-1))
              in
                copy2 l2
              end
          end

        fun reducel f (i, a) =
          let
            val l = length a

            fun reducel' (i, 0) = i
              | reducel' (i, n) =
                reducel' (f (i, sub (a, l-n)), n-1)
          in
            reducel' (i, l)
          end

        fun reducel_index f (i, a) =
          let
            val l = length a

            fun reducel' (i, 0) = i
              | reducel' (i, n) =
                reducel' (f (l-n, i, sub (a, l-n)), n-1)
          in
            reducel' (i, l)
          end

        fun reducer f (a, i) =
          let
            val l = length a

            fun reducer' (0, i) = i
              | reducer' (n, i) =
                reducer' (n-1, f (sub (a, n-1), i))
          in
            reducer' (l, i)
          end

        fun reducer_index f (a, i) =
          let
            val l = length a

            fun reducer' (0, i) = i
              | reducer' (n, i) =
                reducer' (n-1, f (n-1, sub (a, n-1), i))
          in
            reducer' (l, i)
          end

        exception Copy of int * int * int
        fun copy (from, start, finish, to, start') =
          let
            val l1 = length from
            val l2 = length to
          in
            if start < 0 orelse start > l1 orelse finish > l1 orelse
               start > finish orelse
               start' < 0 orelse start' + finish - start > l2 then
              raise Copy (start, finish, start')
            else
              let
                fun copy' 0 = ()
                  | copy' n =
                    (update (to, start'+n-1, sub (from, start+n-1));
                     copy' (n-1))
              in
                copy' (finish - start)
              end
          end

        exception Fill of int * int
        fun fill_range (a, start, finish, x) =
          let
            val l = length a
          in
            if start < 0 orelse start > l orelse finish > l orelse
               start > finish then
              raise Fill (start, finish)
            else
              let
                fun fill' 0 = ()
                  | fill' n =
                    (update (a, start+n-1, x);
                     fill' (n-1))
              in
                fill' (finish - start)
              end
          end

        exception Find
        fun find predicate a =
          let
            val l = length a
            fun find' 0 = raise Find
              | find' n = if predicate (sub (a, l-n)) then l-n else find' (n-1)
          in
            find' l
          end

        fun find_default (predicate, default) a =
          let
            val l = length a
            fun find' 0 = default
              | find' n = if predicate (sub (a, l-n)) then l-n else find' (n-1)
          in
            find' l
          end

      end

    structure Integer =
      struct
	val makestring : int -> string = makestring
	val print : int -> unit = fn i => output(std_out, makestring i)
	fun hexmakestring _ = unimplemented"hexmakestring"
	fun hexprint _ = unimplemented"hexprint"
      end

    structure Real =
      struct
	val makestring : real -> string = makestring
	val print : real -> unit = fn r => output(std_out, makestring r)
      end

    structure Time =
      struct

	type time = NewJersey.System.Timer.time
	val zero = NewJersey.System.Timer.TIME {sec=0, usec=0}

	structure Interval =
	  struct
	    type T = time
	    fun to_real _ = unimplemented "MLWorks.Time.Interval.to_real"
	    fun from_real _ =  unimplemented "MLWorks.Time.Interval.from_real"

	    val op+ = NewJersey.System.Timer.add_time
	    val op- = NewJersey.System.Timer.sub_time
	    fun x*y = unimplemented "MLWorks.Time.Interval.*"
	    fun x/y = unimplemented "MLWorks.Time.Interval./"
	    val op< = NewJersey.System.Timer.earlier
	    val decimal_places = ref 2
	    val format = NewJersey.System.Timer.makestring
	  end

	structure Elapsed = 
	  struct
	    datatype T = ELAPSED of {real: Interval.T,
				     user: Interval.T,
				     system: Interval.T,
				     gc: Interval.T}
	      val zero = ELAPSED {real=zero,
				  user=zero,
				  system=zero,
				  gc=zero}
	    fun elapsed () = zero
	    fun elapsed_since _ = zero
	    fun x+y = unimplemented "MLWorks.Time.Elapsed.+"
	    fun x-y = unimplemented "MLWorks.Time.Elapsed.-"
	    fun x*y = unimplemented "MLWorks.Time.Elapsed.*"
	    fun x/y = unimplemented "MLWorks.Time.Elapsed./"
	    fun format _ = ""
	  end
	
	fun now _ = unimplemented "MLWorks.Time.now"
	val op< = NewJersey.System.Timer.earlier

	fun interval _ = unimplemented "MLWorks.Time.interval"

	datatype zone = GREENWICH | LOCAL
	fun format (_, _, time) = NewJersey.System.Timer.makestring time

            (* This must encoded times in the same way as *)
            (* rts/pervasive/time.c and rts/marshal.c *)
	exception MLWorksTimeEncode

	fun encode (NewJersey.System.Timer.TIME {sec, usec}) =
	  let
	    fun marshal_ints [] = []
	      | marshal_ints (x::xs) =
		if x >= 128 then
		  chr ((x mod 128)+128) :: marshal_ints ((x div 128)::xs)
		else
		  chr x :: (marshal_ints xs)
	  in
	    implode (marshal_ints [sec,usec])
	  end
	    
	fun decode s =
	  let
	    fun unmarshal_int (acc,s, []) = raise MLWorksTimeEncode
	      | unmarshal_int (acc,s, c::cs) =
		let
		  val i = ord c
		in
		  if i >= 128 then
		    unmarshal_int (acc+ ((i mod 128) * s),
				   s*128, cs)
		  else
		    (acc+(i * s),cs)
		end
	    val (sec,s') = unmarshal_int (0,1,explode s)
	    val (usec,_) = unmarshal_int (0,1,s')
	  in
	    NewJersey.System.Timer.TIME {sec = sec,usec = usec}
	  end

	val op+ = NewJersey.System.Timer.add_time
	val op- = NewJersey.System.Timer.sub_time
      end

    structure Threads =
      struct
	type 'a thread = unit

	fun fork _ = unimplemented "MLWorks.Threads.fork"
	fun yield _ = unimplemented "MLWorks.Threads.yield"

	datatype 'a result =
	  Running		(* still running *)
	| Waiting		(* waiting *)
	| Sleeping		(* sleeping *)
	| Result of 'a		(* completed, with this result *)
	| Exception of exn	(* exited with this uncaught exn *)
	| Died			(* died (e.g. bus error) *)
	| Killed		(* killed *)
	| Expired		(* no longer exists (from a previous image) *)

	fun result _ = unimplemented "MLWorks.Threads.result"
	fun sleep _ =  unimplemented "MLWorks.Threads.sleep"
	fun wake _ =  unimplemented "MLWorks.Threads.wake"

	structure Internal =
	  struct
	    type thread_id = unit
	    fun id _ = unimplemented "MLWorks.Threads.Internal.id"
	    fun get_id _ = unimplemented "MLWorks.Threads.Internal.get_id"
	    fun children _ = unimplemented "MLWorks.Threads.Internal.children"
	    fun parent _ = unimplemented "MLWorks.Threads.Internal.parent"
	    fun all _ = unimplemented "MLWorks.Threads.Internal.all"
	    fun kill _ = unimplemented "MLWorks.Threads.Internal.kill"
	    fun raise_in _ = unimplemented "MLWorks.Threads.Internal.raise_in"
	    fun yield_to _ = unimplemented "MLWorks.Threads.Internal.yield_to"
	    fun state _ = unimplemented "MLWorks.Threads.Internal.state"
	    fun get_num _ = unimplemented "MLWorks.Threads.Internal.get_num"
	    fun set_handler _ =
	      unimplemented "MLWorks.Threads.Internal.set_handler"
	    fun reset_fatal_status _ = unimplemented "MLWorks.Threads.Internal.reset_fatal_status"
	    structure Preemption = 
	      struct
		fun start _ = unimplemented "MLWorks.Threads.Internal.Preemption.start"
		fun stop _ = unimplemented "MLWorks.Threads.Internal.Preemption.stop"
		fun on _ = unimplemented "MLWorks.Threads.Internal.Preemption.on"
		fun get_interval _ = unimplemented "MLWorks.Threads.Internal.Preemption.get_interval"
		fun set_interval _ = unimplemented "MLWorks.Threads.Internal.Preemption.set_interval"
	      end
	  end
      end

    structure RawIO =
      struct
        open NewJersey (* types instream, outstream,
			  values std_in, std_out, std_err, open_in, open_out, end_of_stream, input,
			         lookahead, output, close_in, close_out *)

	fun output_byte(fd, byte) = output(fd, chr byte)

	fun closed_in _ = unimplemented "MLWorks.IO.closed_in"
	fun closed_out _ = unimplemented "MLWorks.IO.closed_out"
	fun clear_eof _ = unimplemented "MLWorks.IO.clear_eof"
      end

    structure IO =
      struct
        open RawIO
        val terminal_in = std_in
        fun with_standard_input _ = unimplemented "MLWorks.IO.with_standard_input"
        val terminal_out = std_out
	val messages = std_err
        fun instream _ = std_in
        fun outstream _ = std_out
        fun with_standard_output _ = unimplemented "MLWorks.IO.with_standard_output"
        fun with_standard_error _ = unimplemented "MLWorks.IO.with_standard_error"
	datatype modtime = NOW | TIME of Time.time

        fun file_modified filename =
          NewJersey.System.Unsafe.SysIO.mtime
          (NewJersey.System.Unsafe.SysIO.PATH filename)
          handle _ => raise Io (implode ["Cannot mtime ", filename, ": doesn't exist"])

	fun set_file_modified _ = unimplemented "MLWorks.IO.set_file_modified";

      end

    structure Profile =
      struct
	type manner = int
	type function_id = string
	type cost_centre_profile = unit
	  
	datatype object_kind =
	  RECORD
	| PAIR
	| CLOSURE
	| STRING
	| ARRAY
	| BYTEARRAY
	| OTHER		(* includes weak arrays, code objects *)
	| TOTAL		(* used when specifying a profiling manner *)
	  
	datatype large_size =
	  Large_Size of
	  {megabytes : int,
	   bytes : int}	
	  
	datatype object_count =
	  Object_Count of
	  {number : int,
	   size : large_size,
	   overhead : int}
	  
	type object_breakdown = (object_kind * object_count) list
	  
	datatype function_space_profile =
	  Function_Space_Profile of
	  {allocated : large_size,	
	   copied : large_size,		
	   copies : large_size list,
	   allocation : object_breakdown list}
	  
	datatype function_caller =
	  Function_Caller of
	  {id: function_id,
	   found: int,
	   top: int,
	   scans: int,
	   callers: function_caller list}
	  
	datatype function_time_profile =
	  Function_Time_Profile of
	  {found: int,
	   top: int,
	   scans: int,
	   depth: int,
	   self: int,
	   callers: function_caller list}
	  
	datatype function_profile =
	  Function_Profile of
	  {id: function_id,
	   call_count: int,
	   time: function_time_profile,
	   space: function_space_profile}
	  
	datatype general_header = 
	  General of
	  {data_allocated: int,
	   period: Time.Interval.T,
	   suspended: Time.Interval.T}
	  
	datatype call_header = 
	  Call of {functions : int}
	  
	datatype time_header =
	  Time of
	  {data_allocated: int,
	   functions: int,
	   scans: int,
	   gc_ticks: int,
	   profile_ticks: int,
	   frames: real,
	   ml_frames: real,
	   max_ml_stack_depth: int}
	  
	datatype space_header = 
	  Space of
	  {data_allocated: int,
	   functions: int, 
	   collections: int, 
	   total_profiled : function_space_profile} 
	  
	type cost_header = unit
	  
	datatype profile =
	  Profile of
	  {general: general_header,
	   call: call_header,
	   time: time_header,
	   space: space_header,
	   cost: cost_header,
	   functions: function_profile list,
	   centres: cost_centre_profile list}
	  
	datatype options =
	  Options of
	  {scan : int,
	   selector : function_id -> manner}
	  
	datatype 'a result = 
	  Result of 'a
	| Exception of exn
	  
	exception ProfileError of string
	
	fun profile (Options {scan, selector}) f a =
	  unimplemented "MLWorks.Profile.profile"
	  
	fun make_manner {time, space, copies, calls, depth, breakdown} = 
	  unimplemented "MLWorks.Profile.make_manner"
	  
      end

    exception Save of string
    fun save (filename, function) =
      (NewJersey.exportFn (filename, fn _ => (function (); ()));
       function)

    fun deliver _ = unimplemented "MLWorks.deliver"

    fun exec_save _ = unimplemented "MLWorks.exec_save"

    structure OS =
      struct
        fun arguments () =
          case NewJersey.System.argv ()
            of [] => []
             | program_name::rest => rest
      end

    structure Debugger =
      struct
        fun default_break s = IO.output(IO.std_out,"Break at " ^ s ^ "\n")
        val break_hook = ref default_break
        fun break s = (!break_hook) s
      end

    structure Internal =
      struct
        val text_preprocess = ref (fn (f : int -> string ) => f)
        val real_to_string = NewJersey.makestring

        exception StringToReal

        fun string_to_real chars =
          let
            exception too_small
            exception too_big
            fun getint str =
              let
                fun convert res [] = res
                  | convert res (h :: t) =
                    let
                      val d = ord h - ord "0"
                    in
                      if d >= 0 andalso d <= 9 then
                        convert (res * 10 + d) t
                      else
                        raise StringToReal
                    end
              in
                convert 0 str
              end

            fun decode_real x =
              let
                val string_chars = explode x
                val (sign, string_chars) = case string_chars of
                  [] => raise StringToReal
                | "~" :: xs => (true, xs)
                | _ => (false, string_chars)
                val (integer, fraction, exponent) =
                  let
                    fun find_point_exp(integer, fraction, exponent, _, _, []) =
                      (rev integer, rev fraction, rev exponent)
                      | find_point_exp(integer, fraction, exponent, got_point, got_exp,
                                       "." :: xs) =
                        find_point_exp(integer, [], [], true, false, xs)
                      | find_point_exp(integer, fraction, exponent, got_point, got_exp,
                                       "E" :: xs) =
                        find_point_exp(integer, fraction, [], true, true, xs)
                      | find_point_exp(integer, fraction, exponent, got_point, got_exp,
                                       x :: xs) =
                        if got_exp then
                          find_point_exp(integer, fraction, x :: exponent, true, true, xs)
                        else
                          if got_point then
                            find_point_exp(integer, x :: fraction, [], true, false, xs)
                          else
                            find_point_exp(x :: integer, [], [], false, false, xs)
                  in
                    find_point_exp([], [], [], false, false, string_chars)
                  end
                val (exponent_sign, exponent) = case exponent of
                  [] => (false, ["0"])
                | "~" :: xs => (true, xs)
                | _ => (false, exponent)
                val integer = integer @ fraction
                val exponent =
                  getint exponent
                  handle _ => raise(if exponent_sign then too_small else too_big)
                val exponent =
                  (if exponent_sign then ~exponent else exponent) - length fraction
              in
                (sign, integer, exponent < 0, abs exponent)
              end
            
            
            val (sign, floor, exp_sign, exponent) = decode_real chars
              
            fun floor_to_real([], result) = result
              | floor_to_real(x :: xs, result) =
                floor_to_real(xs, 10.0 * result + real(ord(x) - ord"0"))
            val r = floor_to_real(floor, 0.0)
              
            fun apply_exponent(r, sign, exponent) =
              if exponent = 0 then r
              else
                let
                  val conv = real exponent * ln 10.0
                  val conv = if sign then ~conv else conv
                in
                  r * exp conv handle _ => raise(if sign then too_small else too_big)
                end
            val r = apply_exponent(r, exp_sign, exponent)
          in
            if sign then ~r else r
          end

	structure Images =
	  struct
	    fun clean _ = ()
	    val save = save
	    exception Table of string
	    fun table _ = []
	  end

	structure Types =
	  struct
	    (* These are all somewhat bogus. *)
	    type word8 = int
	    type int8 = int
	    type word16 = int
	    type int16 = int
	    type word32 = int
	    type int32 = int
	  end

        structure Word =
          struct
	    type word = int
	    local
	      open NewJersey.Bits
	    in
	      val word_lshift  : word * word -> word = lshift
	      val word_rshift  : word * word -> word = rshift
	      val word_arshift : word * word -> word =
	        fn _ => unimplemented "MLWorks.Word.arshift"
	      val word_orb  : word * word -> word = orb
	      val word_xorb : word * word -> word = xorb
	      val word_andb : word * word -> word = andb
	      val word_notb : word -> word = notb
	    end
          end

        structure Word32 =
          struct
	    type word = int
	    local
	      open NewJersey.Bits
	    in
	      val word32_lshift  : word * word -> word = lshift
	      val word32_rshift  : word * word -> word = rshift
	      val word32_arshift : word * word -> word =
	        fn _ => unimplemented "MLWorks.Word.arshift"
	      val word32_orb  : word * word -> word = orb
	      val word32_xorb : word * word -> word = xorb
	      val word32_andb : word * word -> word = andb
	      val word32_notb : word -> word = notb
	    end
          end

        structure Value =
          struct
            type T = unit
            type ml_value = T
            exception Value of string
            val cast = NewJersey.System.Unsafe.cast
            val ccast = NewJersey.System.Unsafe.cast
            datatype print_options =
              DEFAULT |
              OPTIONS of {depth_max	  	: int,
                          string_length_max	: int,
                          indent		: bool,
                          tags		  	: bool}

            fun unsafe_plus _ = unimplemented "MLWorks.Internal.Value.unsafe_plus"
            fun unsafe_minus _ = unimplemented "MLWorks.Internal.Value.unsafe_minus"

            val unsafe_array_sub = Array.sub
            val unsafe_array_update = Array.update

            val unsafe_bytearray_sub = ByteArray.sub
            val unsafe_bytearray_update = ByteArray.update

            fun unsafe_record_sub _ = unimplemented "MLWorks.Internal.Value.unsafe_record_sub"
            fun unsafe_record_update _ = unimplemented "MLWorks.Internal.Value.unsafe_record_update"

            fun unsafe_string_sub _ = unimplemented "MLWorks.Internal.Value.unsafe_string_sub"
            fun unsafe_string_update _ = unimplemented "MLWorks.Internal.Value.unsafe_string_update"

            fun alloc_pair _ = unimplemented "MLWorks.Internal.Value.alloc_pair"
            fun alloc_string _ = unimplemented "MLWorks.Internal.Value.alloc_string"
            fun alloc_vector _ = unimplemented "MLWorks.Internal.Value.alloc_vector"

            fun list_to_tuple _ = unimplemented "MLWorks.Internal.Value.list_to_tuple"
            fun tuple_to_list _ = unimplemented "MLWorks.Internal.Value.tuple_to_list"
            fun string_to_real _ = unimplemented "MLWorks.Internal.Value.string_to_real"
            fun real_to_string _ = unimplemented "MLWorks.Internal.Value.real_to_string"
            fun print _ = unimplemented "MLWorks.Internal.Value.print"
            fun primary _ = unimplemented "MLWorks.Internal.Value.primary"
            fun header _ = unimplemented "MLWorks.Internal.Value.secondary"
            fun update_header _ = unimplemented "MLWorks.Internal.Value.update_header"
            fun pointer _ = unimplemented "MLWorks.Internal.Value.pointer"
            fun update _ = unimplemented "MLWorks.Internal.Value.update"
            fun sub _ = unimplemented "MLWorks.Internal.Value.sub"
            fun update_byte _ = unimplemented "MLWorks.Internal.Value.update_byte"
            fun sub_byte _ = unimplemented "MLWorks.Internal.Value.sub_byte"
            fun update_header _ = unimplemented "MLWorks.Internal.Value.update_header"
            fun exn_name _ = unimplemented "MLWorks.Internal.Value.exn_name"
            fun code_name _ = unimplemented "MLWorks.Internal.Value.code_name"
            fun exn_argument _ = unimplemented "MLWorks.Internal.Value.exn_argument"
            fun exn_name_string _ = unimplemented "MLWorks.Internal.Value.exn_name_string"

            structure Frame = 
              struct
                type frame = unit

                fun frame_call _ = unimplemented "MLWorks.Internal.Value.Frame.frame_call"
                fun frame_next _ = unimplemented "MLWorks.Internal.Value.Frame.frame_next"
                fun frame_offset _ = unimplemented "MLWorks.Internal.Value.Frame.frame_offset"
                fun frame_double _ = unimplemented "MLWorks.Internal.Value.Frame.frame_double"
                fun frame_allocations _ = unimplemented "MLWorks.Internal.Value.Frame.frame_allocations"
                fun is_ml_frame _ = unimplemented "MLWorks.Internal.Value.Frame.is_ml_frame"
                fun sub _ = unimplemented "MLWorks.Internal.Value.Frame.sub"
                fun update _ = unimplemented "MLWorks.Internal.Value.Frame.update"
                fun current _ = unimplemented "MLWorks.Internal.Value.Frame.current"
              end
          end

        structure Trace =
          struct
            exception Trace of string
            fun intercept _ = unimplemented "MLWorks.Internal.Trace.intercept"
            fun replace _ = unimplemented "MLWorks.Internal.Trace.replace"
            fun restore _ = unimplemented "MLWorks.Internal.Trace.restore" 
	    fun restore_all _ = unimplemented "MLWorks.Internal.Trace.restore_all" 
            datatype status = INTERCEPT | NONE | REPLACE
            fun status _ = unimplemented "MLWorks.Internal.Trace.status"
          end

        structure Dynamic =
          struct
            type dynamic = int ref * int ref
            type type_rep = int ref
            exception Coerce of type_rep * type_rep

            val generalises_ref : (type_rep * type_rep -> bool) ref =
	      ref (fn _ => false)

	    local
              fun generalises data = (!generalises_ref) data

              val get_type = Value.cast (fn (a,b) => b)
              val get_value = Value.cast (fn (a,b) => a)
	    in
              fun coerce (d,t) =
                if generalises (get_type d,t) then
		  get_value d
                else
		  raise Coerce(get_type d,t)
	    end
          end

        structure FileIO =
          struct
            type fd = NewJersey.System.Unsafe.SysIO.fd * NewJersey.ByteArray.bytearray * int ref
            datatype offset = BEG | CUR | END

            fun flush (fd, buffer, bp) =
              (NewJersey.System.Unsafe.SysIO.write(fd, buffer, !bp); bp := 0)

            fun openf s =
              (NewJersey.System.Unsafe.SysIO.openf(s, NewJersey.System.Unsafe.SysIO.O_WRITE),
               NewJersey.ByteArray.array (4096, 0), ref 0)

	      (* to close:
	       - flush our buffer,
	       - do an fsync,
	       - close the file.
	       The fsync is required to avoid MLWorks bug 561, q.v.
	       The fsync is very ugly. Nick Haines 14-Mar-94 *)
	      
            fun closef (f as (fd, _, _)) =
              (flush f;
	       NewJersey.System.Unsafe.CInterface.wrap_sysfn
	       "fsync"
	       NewJersey.System.Unsafe.CInterface.syscall
	       (95,[NewJersey.System.Unsafe.cast fd]);
	       NewJersey.System.Unsafe.SysIO.closef fd)

            fun seekf (f as (fd, _, _), i, p) =
              let
                val pos = case p of
                  BEG => NewJersey.System.Unsafe.SysIO.L_SET
                | CUR => NewJersey.System.Unsafe.SysIO.L_INCR
                | END => NewJersey.System.Unsafe.SysIO.L_XTND
              in
                flush f; NewJersey.System.Unsafe.SysIO.lseek (fd, i, pos); ()
              end

            fun writebf (f as (fd, _, _), bytearray, start, length) =
              (flush f; NewJersey.System.Unsafe.SysIO.writei (fd, bytearray, start, length))

            fun writef ((fd, buffer, bp), s) =
              let
                val sz = size s

                fun copy (x, ptr) =
                  if x > 4095 then
                    (NewJersey.System.Unsafe.SysIO.write(fd, buffer, 4096); copy(0, ptr))
                  else
                    if ptr < sz then
                      (NewJersey.ByteArray.update(buffer, x, NewJersey.String.ordof(s,ptr)); copy(x+1, ptr+1))
                    else
                      (bp := x)
              in
                copy(!bp, 0)
              end

	    fun write_byte(fd, byte) = writef(fd, chr byte)
          end

        structure Runtime =
	  struct
            exception Unbound of string
            val environment = Value.cast o nj_environment (* Defined in nj_env.sml *)

            val modules = ref ([] : (string * Value.T * Time.time) list)

            structure Loader =
              struct
                exception Load of string
                fun load_module _ = unimplemented "MLWorks.Internal.Runtime.Loader.load_module"
                fun load_wordset _ = unimplemented "MLWorks.Internal.Runtime.Loader.load_wordset"
              end

	    structure Memory =
	      struct
		val gc_message_level = ref 0
		val max_stack_blocks = ref 0
                fun collect _ = unimplemented "MLWorks.Internal.Runtime.Memory.collect"
                fun collect_all _ = unimplemented "MLWorks.Internal.Runtime.Memory.collect_all"
                fun promote_all _ = unimplemented "MLWorks.Internal.Runtime.Memory.promote_all"
                fun collections _ = unimplemented "MLWorks.Internal.Runtime.Memory.collections"
	      end

            structure Event =
              struct
                datatype T = SIGNAL of int
                exception Signal of string
                fun signal _ = unimplemented "MLWorks.Internal.Runtime.Event.signal"
		fun stack_overflow_handler _ = unimplemented "MLWorks.Internal.Runtime.Event.stack_overflow_handler"
		fun interrupt_handler _ = unimplemented "MLWorks.Internal.Runtime.Event.interrput_handler"
		  
              end

          end
      end

  end;

structure Bits = NewJersey.Bits;
structure OldNewJersey = NewJersey;
structure NewJersey = struct end;
