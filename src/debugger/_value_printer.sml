(* _value_printer.sml the functor *)
(*
 * $Log: _value_printer.sml,v $
 * Revision 1.119  1998/03/20 08:46:32  mitchell
 * [Bug #70076]
 * Change value printer to use MLWorks.Internal.Value.exn_name instead of General.exnName
 *
 * Revision 1.118  1998/02/18  17:38:58  jont
 * [Bug #70070]
 * Remove MLWorks.IO.terminal_out in favour of Terminal.output
 *
 * Revision 1.117  1997/09/24  09:13:40  brucem
 * [Bug #30153]
 * Fix mistake from previous change (Old.chr is equiv to String.str(Chr.chr ...)).
 *
 * Revision 1.116  1997/09/18  14:43:07  brucem
 * [Bug #30153]
 * Remove references to Old.
 *
 * Revision 1.115  1997/05/02  16:44:56  jont
 * [Bug #30088]
 * Get rid of MLWorks.Option
 *
 * Revision 1.114  1997/03/27  14:47:38  matthew
 * Removing <<not a ...>> message
 *
 * Revision 1.113  1997/03/18  17:06:12  andreww
 * [Bug #1431]
 * Printing the Io exception nicely.
 *
 * Revision 1.112  1997/01/06  17:42:12  andreww
 * [Bug #1818]
 * Adding routine to print value of floatarray.
 *
 * Revision 1.111  1996/11/06  11:23:18  matthew
 * [Bug #1728]
 * __integer becomes __int
 *
 * Revision 1.110  1996/10/31  14:29:42  io
 * [Bug #1614]
 * basifying String
 *
 * Revision 1.109  1996/10/02  16:11:53  andreww
 * [Bug #1592]
 * threading level info in tynames.
 *
 * Revision 1.108  1996/06/04  20:24:16  io
 * stringcvt->string_cvt
 *
 * Revision 1.107  1996/05/30  12:58:09  daveb
 * (Char.)ord is now at top level.
 *
 * Revision 1.106  1996/05/28  11:57:08  matthew
 * FIxing problem with string printing.
 *
 * Revision 1.105  1996/05/22  13:32:05  matthew
 * Changed type of MLWorks.Internal.real_to_string
 * ,
 *
 * Revision 1.104  1996/05/13  11:19:54  matthew
 * Changes to basis
 *
 * Revision 1.103  1996/05/03  11:03:16  matthew
 * Changes to Word structure
 *
 * Revision 1.102  1996/05/01  09:30:21  jont
 * String functions explode, implode, chr and ord now only available from String
 * io functions and types
 * instream, oustream, open_in, open_out, close_in, close_out, input, output and end_of_stream
 * now only available from MLWorks.IO
 *
 * Revision 1.101  1996/04/30  09:35:23  matthew
 * Removing MLWorks.Integer
 *
 * Revision 1.100  1996/04/18  15:18:04  jont
 * initbasis moves to basis
 *
 * Revision 1.99  1996/03/28  12:20:07  matthew
 * New language definition
 *
 * Revision 1.98  1996/03/27  16:24:23  jont
 * Modify printing of functions when show details is on
 * so as not to include <Entry1> type info.
 *
 * Revision 1.97  1996/03/20  14:01:21  matthew
 * Language revision
 *
 * Revision 1.96  1996/02/15  10:38:33  jont
 * ERROR becomes MLERROR
 *
 * Revision 1.95  1995/12/27  13:16:00  jont
 * Removing Option in favour of MLWorks.Option
 *
 * Revision 1.94  1995/10/19  15:47:57  matthew
 * Correcting misspelling of abbreviate.
 *
Revision 1.93  1995/10/13  22:59:06  brianm
Adding extra control for abbreviated strings - needed in printing labels
in the Graphical Inspector, which uses stringify_value eventually.

Revision 1.92  1995/09/15  11:08:15  daveb
Added printing for Int32.int values.

Revision 1.91  1995/09/12  17:53:30  daveb
Added types for different lengths of words, ints and reals.

Revision 1.90  1995/07/26  14:13:21  jont
Add printing for builtin word type

Revision 1.89  1995/07/17  11:58:22  jont
Add printing of builtin char type

Revision 1.88  1995/04/28  14:00:08  matthew
Changing uses of cast (again)

Revision 1.87  1995/03/24  16:47:08  matthew
Changing Tyname_id etc. to Stamp

Revision 1.86  1995/03/15  15:41:45  matthew
Removing call to shape (again).

Revision 1.85  1995/03/01  10:48:01  matthew
Various minor changes to the way things are printed

Revision 1.84  1995/01/30  12:35:32  matthew
Rationalizing

Revision 1.83  1994/12/14  15:23:32  matthew
Removed call to shape when an unexpected value is found
as shape can bus error with some inputs.  This should be sorted
out properly.

Revision 1.82  1994/12/06  10:27:26  matthew
Changing uses of cast

Revision 1.81  1994/11/21  17:14:04  matthew
Fixing 2 element vector printing.

Revision 1.80  1994/08/16  11:12:37  jont
Made the printing of values more strict. Values supposedly from datatypes
will now only print if they are integers or pairs, and if pairs only if
the tag is an integer, and in either case, if and only the type of the constructor
(vcc or non-vcc) is correct for the value in question.

Revision 1.79  1994/06/23  13:58:29  jont
Update debugger information production

Revision 1.78  1994/06/23  12:02:50  nickh
Change bogus code message and shared closure bug.

Revision 1.77  1994/06/09  15:49:41  nickh
New runtime directory structure.

Revision 1.76  1994/06/03  14:55:30  matthew
Fixed debruijn printing.
Fixed depth in bound debruijns.

Revision 1.75  1994/06/02  14:00:59  brianm
Prevented shape printer from showing record contents (my first bug fix - with help from ma)

Revision 1.74  1994/05/11  14:52:09  daveb
Datatypes.META_OVERLOADED takes extra arguments.

Revision 1.73  1994/03/22  16:00:34  nickh
Fixed Waynisms and added better shape printing for unknown shapes.

Revision 1.72  1994/03/16  17:55:47  matthew
Changed exn printing again to use brackets only when needed.

Revision 1.71  1994/03/16  15:46:14  matthew
Changed printing of exception values slightly.

Revision 1.70  1994/02/28  08:24:34  nosa
Changed null type function handling to accomodate Monomorphic debugger decapsulation;
Extra TYNAME valenv for Modules Debugger.

Revision 1.69  1994/02/23  12:40:50  daveb
Adding function to find the name of a function.

Revision 1.68  1994/02/14  16:24:56  nickh
Moved convert_string to MLWorks.String.ml_string.

Revision 1.67  1993/12/09  19:27:30  jont
Added copyright message

Revision 1.66  1993/11/30  13:25:48  matthew
Added is_abs field to TYNAME and METATYNAME
Print abstypes as _

Revision 1.65  1993/11/24  10:20:30  nickh
Fix printing of wide tuples (and rewrite related code for efficiency).

Revision 1.64  1993/11/18  17:52:23  daveb
Made exceptions print as just their name, instead of "exn(name)".

Revision 1.63  1993/10/13  11:51:39  daveb
Merged in bug fix.

Revision 1.62  1993/10/08  16:08:06  matthew
Merging from bug fix branch

Revision 1.61  1993/09/16  15:26:04  nosa
Instances for METATYVARs and TYVARs and in schemes for polymorphic debugger.

Revision 1.60.1.3  1993/10/12  17:00:30  daveb
Changed maximum_list_size to maximum_seq_size, and made it affect arrays,
bytearrays and vectors.  Added a maximum_string_size.  Made negative values
for either of these be interpreted as infinity.

Revision 1.60.1.2  1993/10/06  16:28:48  matthew
Improved exception printing

Revision 1.60.1.1  1993/08/19  09:16:43  jont
Fork for bug fixing

Revision 1.60  1993/08/19  09:16:43  matthew
Changed parsing of debug information string
This should be done by some central utilities

Revision 1.59  1993/07/30  13:40:25  nosa
Changed type of constructor NULL_TYFUN for value printing in
local and closure variable inspection in the debugger.

Revision 1.58  1993/06/01  17:17:39  matthew
Changes to debug information
Better handling of types defined within functor parameters.

Revision 1.57  1993/05/18  16:32:56  daveb
Merged the maximum_depth and maximum_shape_depth options.
Replaced Integer.makestring with MLWorks.Integer.makestring and removed
the Integer structure.

Revision 1.56  1993/05/12  17:27:44  matthew
Fixed error with handler for Nth

Revision 1.55  1993/05/06  12:08:48  matthew
 Removed printer descriptors.
stringify_value now takes just a print_options object

Revision 1.54  1993/04/20  15:31:03  jont
Added code to deal with printing of vectors

Revision 1.53  1993/04/02  13:33:53  matthew
Signature changes

Revision 1.52  1993/03/24  18:44:54  jont
Got byte arrays printing properly after tagging changes

Revision 1.51  1993/03/11  10:50:58  matthew
Signature revisions

Revision 1.50  1993/03/08  16:06:00  matthew
Options & Info changes

Revision 1.49  1993/03/02  15:20:29  matthew
Rationalised use of Mapping structure

Revision 1.48  1993/03/01  18:24:04  matthew
 Change of error messages

Revision 1.47  1993/03/01  11:06:19  matthew
Printing for arrays, bytearrays, vectors

Revision 1.46  1993/02/23  17:50:28  matthew
Slightly more intelligent treatment of brackets for constructed values

Revision 1.45  1993/02/09  10:18:48  matthew
Typechecker structure changes

Revision 1.44  1993/02/04  17:32:21  matthew
Changed functor parameter

Revision 1.43  1993/01/08  11:35:08  daveb
Changes to support new list representation.

Revision 1.42  1992/12/22  15:01:46  jont
*** empty log message ***

Revision 1.41  1992/12/18  11:36:11  clive
Removed the debug message in generate_underbar

Revision 1.40  1992/12/09  19:29:15  clive
Changed the list size exceeded extension

Revision 1.39  1992/12/09  19:00:13  clive
maximum_list_size was being ignored

Revision 1.38  1992/12/09  16:01:18  clive
Changed depth message to ...

Revision 1.37  1992/12/09  11:25:46  clive
Printing of one element tuple

Revision 1.36  1992/12/08  13:42:42  clive
If maximum_shape_depth is zero then do not print shape details

Revision 1.35  1992/12/07  13:54:31  clive
Added some debugging messages

Revision 1.34  1992/11/27  14:14:12  clive
Removed default print_descriptor

Revision 1.33  1992/11/20  12:31:39  clive
Added a flag to control detailed printed of exceptions
Added maximum list size

Revision 1.32  1992/11/20  11:43:46  clive
Added a bound to the size of printed lists

Revision 1.31  1992/11/13  16:17:34  clive
Backpointers were causing a problem with printing

Revision 1.30  1992/11/05  18:01:12  richard
Changes to the pervsaive library.  Specifcally, calls to the
pervasive Debugger structure have been replaced by calls to
Internal.Value.

Revision 1.29  1992/10/28  11:23:53  clive
Got compare and equality round the wrong way in empty

Revision 1.28  1992/10/28  10:22:48  clive
Changed to use empty instead of empty'

Revision 1.27  1992/10/23  14:11:04  clive
null_tyfun no longer erroneously generated

Revision 1.26  1992/10/19  16:45:12  clive
Empty VE tynames are printed as "_"

Revision 1.25  1992/10/12  08:32:20  clive
Tynames now have a slot recording their definition point

Revision 1.24  1992/10/07  16:53:52  clive
Changes for the use of new shell

Revision 1.23  1992/09/24  14:19:54  matthew
Changed string value printer so that characters are escaped properly.

Revision 1.22  1992/09/14  10:29:36  clive
Now prints out real numbers

Revision 1.21  1992/09/09  13:09:15  clive
Added switches t the value-printer to control depth of printing etc

Revision 1.20  1992/09/03  09:22:34  clive
Added functionality to the value_printer

Revision 1.19  1992/09/02  16:23:12  clive
Took out wrong real number printer

Revision 1.18  1992/09/01  11:43:08  clive
Fiex the shape routine

Revision 1.17  1992/08/28  17:31:20  clive
Changes to reflect new Internal structure

Revision 1.16  1992/08/28  10:43:31  clive
Added the shape function

Revision 1.15  1992/08/27  09:48:04  richard
Rationalisation of the MLWorks structure.

Revision 1.14  1992/08/26  16:25:00  clive
More support for the definition of print functions

Revision 1.13  1992/08/19  09:24:10  clive
Extra then statement had been added

Revision 1.12  1992/08/18  16:25:14  richard
 Changed coercion and the ml_value type in the pervasive environment.

Revision 1.11  1992/08/17  13:20:14  clive
Various improvements

Revision 1.10  1992/08/14  14:42:12  clive
Added the printing of reals

Revision 1.9  1992/08/13  15:47:49  clive
Neatening up, plus changes due to lower level sharing changes

Revision 1.8  1992/08/11  13:05:19  clive
More improvements

Revision 1.7  1992/08/10  13:56:41  clive
New sharing constraints after lower level changes

Revision 1.6  1992/08/06  12:26:09  clive
Now handles eta_tyfuns

Revision 1.5  1992/07/29  11:32:38  clive
Periodical checking in - many improvements

Revision 1.4  1992/07/14  08:56:11  clive
Prints the value carried by an exception

Revision 1.3  1992/07/13  09:53:08  clive
Some minor printing changes

Revision 1.2  1992/06/25  09:19:56  clive
Added a simplified function for toplevel printing

Revision 1.1  1992/06/22  15:20:13  clive
Initial revision

 * Copyright 2013 Ravenbrook Limited <http://www.ravenbrook.com/>.
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
*)

require "$.basis.__int";
require "$.basis.__int32";
require "$.basis.__word" ;
require "$.basis.__word32" ;
require "$.basis.__string_cvt" ;
require "$.basis.__char";
require "$.basis.__string";
require "^.utils.__terminal";

require "../typechecker/types" ;
require "../typechecker/valenv";
require "value_printer_utilities";
require "debugger_types";
require "../rts/gen/tags";
require "../utils/lists";
require "../utils/crash";
require "value_printer" ;

functor ValuePrinter(
  structure Types : TYPES
  structure Valenv : VALENV
  structure ValuePrinterUtilities : VALUEPRINTERUTILITIES
  structure Debugger_Types : DEBUGGER_TYPES
  structure Tags : TAGS
  structure Lists : LISTS
  structure Crash : CRASH

  sharing Types.Datatypes = Valenv.Datatypes =
          ValuePrinterUtilities.BasisTypes.Datatypes

  sharing type Types.Datatypes.Type = Debugger_Types.Type
) : VALUE_PRINTER =
  struct

    structure BasisTypes = ValuePrinterUtilities.BasisTypes
    structure Datatypes = Types.Datatypes
    structure NewMap = Datatypes.NewMap
    structure Ident = Datatypes.Ident
    structure Debugger_Types = Debugger_Types
    structure Options = Types.Options

    type TypeBasis = BasisTypes.Basis
    type Type = Datatypes.Type
    type DebugInformation = Debugger_Types.information

    val do_debug = false

    fun debug s = if do_debug then Terminal.output(s ^ "\n") else ()

    val cast : 'a -> 'b = MLWorks.Internal.Value.cast
    fun max_len (max_seq_size, actual_seq_size) =
      if max_seq_size < 0 orelse max_seq_size > actual_seq_size then
	actual_seq_size
      else
	max_seq_size

    fun generate_underbar x = "_" ^ (if do_debug then (" [" ^ x ^ "] ") else "")

    val ellipsis = ".."

    val list_ellipsis = ", " ^ ellipsis ^ "]"

    val string_abbreviation = ref "\\..."

(*
    fun equal_tynames(Datatypes.TYNAME (x,_,_,_,_,_,_,_),Datatypes.TYNAME (y,_,_,_,_,_,_,_)) = 
      Datatypes.Stamp.stamp_eq(x,y)
      | equal_tynames _ = false

    fun compare_tynames(Datatypes.TYNAME (x,_,_,_,_,_,_,_),Datatypes.TYNAME (y,_,_,_,_,_,_,_)) = 
      Datatypes.Stamp.stamp_lt(x,y)
      | compare_tynames _ = false
*)

    fun get_arg_type(Datatypes.METATYVAR(ref(_,object,_),_,_)) = get_arg_type object
      | get_arg_type(Datatypes.FUNTYPE (arg,_)) = arg
      | get_arg_type x = Datatypes.NULLTYPE


    fun splice (left, separator, right) [] = left ^ right
      | splice (left, separator, right) (s::ss) =
        concat (left :: s ::
                 Lists.reducer
                 (fn (s, strings) => separator :: s :: strings)
                 (ss, [right]))

    fun vector_map (object, length) f =
        let
          fun iterate (list, 0) = list
            | iterate (list, n) =
              iterate ((f (MLWorks.Internal.Value.sub (object, n)))::list, n-1)
        in
          iterate ([], length)
        end

    (* For pairs we select 0 & 1 *)
    (* else 1,2,...,n *)
    fun record_map (object, 2) f =
        [f (MLWorks.Internal.Value.sub (object, 0)),
         f (MLWorks.Internal.Value.sub (object, 1))]
      | record_map (object, length) f =
        vector_map (object,length) f

    fun array_map (object, length) f =
      let
        fun iterate (list, 0) = list
          | iterate (list, n) =
            iterate ((f (MLWorks.Internal.Value.sub (object, n+2)))::list, n-1)
      in
        iterate ([], length)
      end

    fun bytearray_map (object, length) f =
      let
        fun iterate (list, 0) = list
          | iterate (list, n) =
	    iterate 
	      (cast
	         (f(MLWorks.Internal.Value.sub_byte(object, n+3))):: list,  n-1)
      in
        iterate ([], length)
      end


    fun floatarray_map (object, length) f =
      let
        fun iterate (list, 0) = list
          | iterate (list, n) =
	    iterate 
	      (cast
	         (f(MLWorks.Internal.FloatArray.sub(object, n-1))):: list,  n-1)
      in
        iterate ([], length)
      end




    exception Value of string


    (* A header of zero is possible if we are in a shared closure *)
    fun select field =
      if field < 0 then
        raise Value "select: negative field"
      else
        fn value =>
        let
          val primary = MLWorks.Internal.Value.primary value
        in
          if primary = Tags.PAIRPTR 
            then
              if field >= 2 
                then
                  raise Value "select: field >= 2 in pair"
              else
                MLWorks.Internal.Value.sub (value, field)
	  else if primary = Tags.POINTER 
		 then
		   let
		     val (secondary, length) = MLWorks.Internal.Value.header value
		   in
		     if (secondary = Tags.INTEGER0 andalso field=0)
		       orelse (secondary = Tags.INTEGER1 andalso field=0)
		       then
			 MLWorks.Internal.Value.sub (value, 1)
		     else 
		       if secondary = Tags.RECORD then
			 if field >= length then
			   raise Value "select: field >= length in record"
			 else
			   MLWorks.Internal.Value.sub (value, field+1)
		       else
			 raise Value "select: invalid secondary"
		   end
	       else
		 raise Value "select: invalid primary"
        end

    fun integer value =
      let
        val primary = MLWorks.Internal.Value.primary value
      in
        if primary = Tags.INTEGER0 orelse primary = Tags.INTEGER1 then
          cast value : int
        else
          raise Value "not an integer"
      end

    fun word value =
      let
        val primary = MLWorks.Internal.Value.primary value
      in
        if primary = Tags.INTEGER0 orelse primary = Tags.INTEGER1 then
          cast value : word
        else
          raise Value "not a word"
      end

    fun word32 value =
      if
	MLWorks.Internal.Value.primary value = Tags.POINTER andalso
        #1 (MLWorks.Internal.Value.header value) = Tags.STRING
      then
        (cast value : Word32.word)
      else
        raise Value "not a word32"

    fun int32 value =
      if
	MLWorks.Internal.Value.primary value = Tags.POINTER andalso
        #1 (MLWorks.Internal.Value.header value) = Tags.STRING
      then
        (cast value : Int32.int)
      else
        raise Value "not a int32"

    fun contag value =
      let
        val primary = MLWorks.Internal.Value.primary value
      in
        if primary = Tags.INTEGER0 orelse primary = Tags.INTEGER1 then
          cast value : int
        else if primary = Tags.PAIRPTR then
          cast (MLWorks.Internal.Value.sub (value, 0)) : int
        else
          raise Value "contag: not a constructor"
      end

    fun bool value =
      let
        val primary = MLWorks.Internal.Value.primary value
      in
        if primary = Tags.INTEGER0 orelse primary = Tags.INTEGER1 then
          case cast value : int of
            0 => false
          | 1 => true
          | _ => raise Value "bool: invalid integer"
        else
          raise Value "bool: wrong primary"
      end

    fun string value =
      if
        MLWorks.Internal.Value.primary (cast value) = Tags.POINTER andalso
        #1 (MLWorks.Internal.Value.header (cast value)) = Tags.STRING
      then
        cast value : string
      else
        raise Value "not a string"

    fun list (count, value, acc) =
      let val primary = MLWorks.Internal.Value.primary value
      in
	if primary = Tags.INTEGER1 then
          if (cast value : int) = 1 then
	    (true, rev acc)
	  else
	    raise Value "list: invalid integer"
        else if primary = Tags.PAIRPTR then
	  let val head = select 0 value
	      val tail = select 1 value
	  in
	    if count = 0 then
	      (false, rev acc)
	    else
	      list (if count < 0 then count else count - 1, tail, head :: acc)
	  end
        else
	  raise Value "invalid list"
      end
      
    fun real value =
      if
        MLWorks.Internal.Value.primary value = Tags.POINTER andalso
        MLWorks.Internal.Value.header value = (Tags.BYTEARRAY, 12)
      then
        cast value : real
      else
        raise Value "not a real"

    fun code_name value =
      if
        MLWorks.Internal.Value.primary value = Tags.POINTER andalso
         #1 (MLWorks.Internal.Value.header value) = Tags.BACKPTR
      then
        MLWorks.Internal.Value.code_name value
      else
        raise Value "code_name: not a code item"

    fun exn value =
      if MLWorks.Internal.Value.primary value = Tags.PAIRPTR then
        let
          val (name, arg) = cast value
        in
          if MLWorks.Internal.Value.primary name = Tags.PAIRPTR then
            let
              val (unique, string) = cast name
            in
              if MLWorks.Internal.Value.primary unique = Tags.REFPTR then
                if MLWorks.Internal.Value.primary string = Tags.POINTER then
                  if #1 (MLWorks.Internal.Value.header string) = Tags.STRING then
                    cast value : exn
                  else raise Value "exn: wrong secondary on exn name string"
                else raise Value "exn: wrong primary on exn name string"
              else raise Value "exn: wrong primary on exn name unique"
            end
          else raise Value "exn: wrong primary on exn name"
        end
      else raise Value "exn: wrong primary"

    fun convert_ref value =
      if
        MLWorks.Internal.Value.primary value = Tags.REFPTR andalso
        MLWorks.Internal.Value.header value = (Tags.ARRAY, 1)
      then
        cast value : MLWorks.Internal.Value.T ref
      else
        raise Value "not a ref cell"

    fun get_location s =
      let
        val sz = size s
        fun find_end_of_name x =
          if x=sz orelse substring (* could raise Substring *)(s,x,1) = "["
	    then x
	  else find_end_of_name (x+1)
	val ix = find_end_of_name 0
      in
	substring (* could raise Substring *) (s,ix,sz-ix)
      end

    fun find_end_of_name name =
      let
        val s = size name
        fun f x =
          if x=s
            then name
          else if substring (* could raise Substring *)(name,x,1) = "["
                 then substring (* could raise Substring *)(name,0,x)
               else f (x+1)
      in
        f 0
      end
                   

    fun exn_lookup (debug_info, name) =
      let
        val name' = find_end_of_name name
      in
        case Debugger_Types.lookup_debug_info (debug_info,name) of
          SOME (Debugger_Types.FUNINFO {ty,...}) =>
            (name',get_arg_type ty)
        | _ => (name',Datatypes.NULLTYPE)
      end

(*
    type print_method_table =
      (Datatypes.Tyname,(MLWorks.Internal.Value.T list 
                         * (MLWorks.Internal.Value.T -> string) list
                         * (MLWorks.Internal.Value.T -> MLWorks.Internal.Value.T list)
      * (MLWorks.Internal.Value.T -> bool * int)
      -> string)) NewMap.T
            
    fun make_empty_definition_table() = (NewMap.empty 
                                         (compare_tynames,equal_tynames)) : print_method_table

    datatype printer_descriptor =
      PRINTER_DESCRIPTOR of
      {print_options : Options.print_options,
       print_method_table : print_method_table
       }

    (* Define a table of print methods for other types *)

    val default_print_method_table = make_empty_definition_table ()

    fun define_a_print_method(basis,ty,function,
                              descriptor as 
                              (PRINTER_DESCRIPTOR 
                               {print_options,
                                print_method_table})) =
      let
        val tyname = ValuePrinterUtilities.find_tyname(basis,ty)
        val new_definition_table = NewMap.define(print_method_table,tyname,function)
      in
        (true,
         PRINTER_DESCRIPTOR
         {print_options = print_options,
          print_method_table = new_definition_table})
      end
    handle ValuePrinterUtilities.FailedToFind => (false,descriptor)

    fun print_method_defined(basis,ty,PRINTER_DESCRIPTOR printer_descriptor) =
      let
        val tyname = ValuePrinterUtilities.find_tyname(basis,ty)
        val _ = NewMap.apply'(#print_method_table printer_descriptor,tyname)
      in
        true
      end
    handle NewMap.Undefined => false
         | ValuePrinterUtilities.FailedToFind => false

    val toplevel_default_print_descriptor =
      PRINTER_DESCRIPTOR
      {print_options = Options.default_print_options,
       print_method_table = make_empty_definition_table()}

    val global_print_method_table = ref (make_empty_definition_table())
*)

    val error_notify = false

    datatype environment = EMPTY | ENTRY of Datatypes.Type list * environment

    fun unknown (message,primary,secondary,length) =
      concat [message,
	       "primary = ",
	       Int.toString primary,
	       ", secondary = ",
	       Int.toString secondary,
	       ", length = ",
	       Int.toString length]

    (* find if value is a closure *)
    (* Assumes value is either a pair or a record. *)

    fun is_closure value =
      let 
	val fst = select 0 value
      in
        MLWorks.Internal.Value.primary fst = Tags.POINTER andalso
         #1 (MLWorks.Internal.Value.header fst) = Tags.BACKPTR
      end

    fun shape (0,_,_,_,_) = generate_underbar("shape")
      | shape (depth, max_seq_size, max_str_size, float_precision,object) =
        let
          val primary = MLWorks.Internal.Value.primary object
        in
          if primary = Tags.INTEGER0 orelse primary = Tags.INTEGER1 
	    then Int.toString(cast object)
          else if primary = Tags.PAIRPTR 
	    then
	      if is_closure object
		then "<fn>"
	      else
		splice ("{", ", ", "}")
		(record_map (object, 2)
		 (fn object => shape (depth-1, max_seq_size, max_str_size, float_precision,object)))
	    else 
	      if primary = Tags.POINTER then
            let
              val (secondary, length) = MLWorks.Internal.Value.header object
            in
              if secondary = Tags.RECORD then
		if is_closure object
		  then "<fn>"
		else
		  splice ("{", ", ", "}")
		  (record_map (object, length)
                 (fn object => shape (depth-1, max_seq_size, max_str_size, float_precision,object)))
              else if secondary = Tags.STRING then
                concat ["\"", 
                                MLWorks.String.ml_string
                                (cast object,
                                 max_str_size), "\""]
              else if secondary = Tags.BYTEARRAY then
                if length = 12 then
                  MLWorks.Internal.real_to_string (cast object,float_precision)
                else
                  unknown("bad real: ",primary, secondary,length)
              else if secondary = Tags.CODE then
		"<CODE>"
              else if secondary = Tags.BACKPTR then
                "<BACKPTR>"
		(* shared closure case *)
	      else if secondary = 0 andalso length = 0
		     then "<fn>"
	      else 
		unknown("bad ptr: ", primary, secondary, length)
            end
          else if primary = Tags.REFPTR then
            let
              val (secondary, length) = MLWorks.Internal.Value.header object
	      val tail = if length > max_seq_size andalso max_seq_size > 0
                           then list_ellipsis
			 else "]"
            in
              if secondary = Tags.ARRAY then
                splice ("array[", ", ", tail)
                (array_map (object, max_len (max_seq_size, length))
                 (fn object => shape (depth-1, max_seq_size, max_str_size, float_precision,object)))
              else
		if secondary = Tags.BYTEARRAY then
		  splice ("bytearray[", ",", tail)
		  (bytearray_map (object, max_len (max_seq_size, length))
		   (fn object =>
 		      shape (depth-1, max_seq_size, max_str_size,
			     float_precision, cast object)))
		else
		  unknown("bad refptr: ", primary, secondary,length)
            end
          else
	    unknown("bad primary: ", primary, 0, 0)
        end
          
    fun stringify_value debugger_print
      (print_options as
       Options.PRINTOPTIONS {maximum_seq_size,
                             maximum_string_size,
                             maximum_ref_depth,
                             maximum_depth,
                             print_fn_details,
                             print_exn_details,
                             float_precision,
                             ...},
       object,
       ty,
       interpreter_information) =

      let
        (* val print_method_table = !global_print_method_table *)
          fun error_notification (object, message) =
            let
              val shape = "_" 
            (* shape (maximum_depth, maximum_seq_size,maximum_string_size, float_precision, object) *)
            in
              concat
              (if error_notify then
                 ["<", message, ": ", shape, ">"]
               else
                 ["_"])
            end
              
          fun get_arg_type(Datatypes.METATYVAR(ref(_,object,_),_,_)) = get_arg_type object
            | get_arg_type(Datatypes.FUNTYPE (arg,_)) = arg
            | get_arg_type x = Datatypes.NULLTYPE
              
          fun get_next_part_of_type(Datatypes.METATYVAR(ref(_,object,_),_,_)) = 
                 get_next_part_of_type object
            | get_next_part_of_type x = x

          (* maybe the printer should produce an s-expression representation, which can *)
          (* be printed optimally *)

          (* This function could be combined with print_value' *)

          fun needs_brackets (ty as Datatypes.METATYVAR _) =
              needs_brackets (get_next_part_of_type ty)
            | needs_brackets (Datatypes.META_OVERLOADED {1=ref ty,...}) =
              needs_brackets (get_next_part_of_type ty)
            | needs_brackets (Datatypes.CONSTYPE(tys,Datatypes.METATYNAME(ref(tyfun as (Datatypes.TYFUN _)),_,_,_,_,_))) =
              needs_brackets (Types.apply(tyfun,tys))
            | needs_brackets (Datatypes.CONSTYPE
                              (tys,Datatypes.METATYNAME(ref(Datatypes.ETA_TYFUN tyname),_,_,_,_,_))) =
              needs_brackets (Datatypes.CONSTYPE(tys,tyname))
            | needs_brackets (Datatypes.CONSTYPE
                              (tys,Datatypes.METATYNAME(ref(Datatypes.NULL_TYFUN _),_,_,_,_,_))) = false
            | needs_brackets (ty as Datatypes.CONSTYPE(tys,tyname)) =
              if
		Types.num_or_string_typep ty orelse
                Types.tyname_eq (tyname,Types.bool_tyname) orelse
                Types.tyname_eq (tyname,Types.list_tyname) orelse
                Types.tyname_eq (tyname,Types.ml_value_tyname) orelse
                Types.tyname_eq (tyname,Types.dynamic_tyname)
                then false
              else true
            | needs_brackets _ = false

	  val entry1 = "<Entry1>"
	  val entry2 = "<Entry2>"
	  val closure = "<Closure>"

	  val sz_entry1 = size entry1
	  val sz_closure = size closure

	  fun strip_fn_name name =
	    let
	      val sz = size name
	    in
	      if sz >= sz_entry1 andalso
		let
		  val en_string = substring (* could raise Substring *)(name, sz-sz_entry1, sz_entry1)
		in
		 en_string = entry1 orelse en_string = entry2
		end then
		substring (* could raise Substring *)(name, 0, sz-sz_entry1)
	      else
		if sz >= sz_closure andalso
		  substring (* could raise Substring *)(name, sz-sz_closure, sz_closure) = closure then
		  substring (* could raise Substring *)(name, 0, sz-sz_closure)
		else
		  name
	    end

          fun value_to_string(object,ty,env) =
            let
              fun value_to_string'(_,_,_,_,0) = ellipsis
                | value_to_string'(object,ty as Datatypes.METATYVAR _,env,ref_depth,depth) = 
                  value_to_string'(object,get_next_part_of_type ty,env,ref_depth,depth)
                  
                | value_to_string'
		    (object, Datatypes.META_OVERLOADED {1=ref ty,...},
		     env,ref_depth,depth) = 
                  value_to_string'(object,get_next_part_of_type ty,env,ref_depth,depth)
                  
                | value_to_string'(object,Datatypes.TYVAR _,env,ref_depth,depth) = 
                  generate_underbar("tyvar")
                  
                | value_to_string'(object,Datatypes.FUNTYPE _,env,ref_depth,depth) = 
                  if print_fn_details then
		    let
		      val name = MLWorks.String.ml_string (code_name (select 0 object), ~1)
		    in
		      "fn[" ^ strip_fn_name name ^ "]"
		    end
                    handle Value message => error_notification (object, message)
                  else
                    "fn"

                | value_to_string' (object,Datatypes.METARECTYPE (ref (_,uninstantiated,ty,_,_)),env,ref_depth,depth) = 
                  if uninstantiated
                    then
                      error_notification (object,"Uninstantiated METARECTYPE")
                  else
                    value_to_string' (object,ty,env,ref_depth,depth)

		| value_to_string'(object,ty as (Datatypes.RECTYPE _),env,ref_depth,depth) =
                  (* Unless there is enough room to print the components, don't print the labels *)
                  if depth <= 1
                    then ellipsis
                  else
		  let
		    val dom = Types.rectype_domain ty
		    val len = length dom
		    val range = Types.rectype_range ty
		    val primary = MLWorks.Internal.Value.primary object
		  in
		    if len = 0 then 
		      "()"
		    else
		      if primary = Tags.PAIRPTR orelse primary = Tags.POINTER then
			let
			  fun get_elements ([],_) = []
			    | get_elements (ty::tys,pos) = 
			      value_to_string'
			      (MLWorks.Internal.Value.sub (object,pos),
			       ty,env,ref_depth,depth-1) ::
                              get_elements(tys,pos+1)
			      
			  (* tuple members are not guaranteed to be in order,
			   * so we build a list of indices *)
			      
			  fun tuple_indices () =
			    if len < 2 then NONE
			    else
			      let
				fun tuple_indices' (acc,0) = SOME acc
				  | tuple_indices' (acc,n) = 
				    (let
				       val name = Int.toString n
				       val sym = Ident.Symbol.find_symbol name
				       val lab = Ident.LAB sym
				       val pos = Lists.find (lab,dom)
				     in
				       tuple_indices' (pos::acc, n-1)
				     end)
			      in
				tuple_indices' ([],len)
				handle Lists.Find => NONE
			      end
			    
			  fun print_as_record values =
			    let
			      fun print_as_record' (Ident.LAB name,value) =
				Ident.Symbol.symbol_name name ^ "=" ^ value
			      val result = map print_as_record' (Lists.zip(dom,values))
			    in
			      case result of
				[] => "()"
			      | [one] => "{" ^ one ^ "}"
			      | arg::args =>
				  let
				    fun put_together [] = ""
				      | put_together (h::t) = ", " ^ h ^ put_together t
				  in
				    "{" ^ arg ^ put_together args ^ "}"
				  end
			    end
			  
			  (* for a tuple, take a list of indices and a list of elements *)
			
			  fun print_as_tuple (ilist, els) =
			    let
			      val ordered_els = (map (fn n => Lists.nth(n,els)) ilist
						 handle Lists.Nth => Crash.impossible "Problem (2) in value_printer")
			      fun put_together [] = ""
				| put_together (h::t) = ", " ^ h ^ put_together t
			    in
			      case ordered_els of
				arg::args => 
				  "(" ^ arg ^ put_together args ^ ")"
			      | _ =>
				  Crash.impossible "Problem (1) in value_printer"
			    end
			  
			  val record_size =
			    if primary = Tags.PAIRPTR then
			      2
			    else
			      #2 (MLWorks.Internal.Value.header object)
			in
			  if length range = record_size then
			    let val elements = get_elements (range, if record_size = 2 then 0 else 1)
			    in
			      case tuple_indices () of 
				NONE =>
				  print_as_record elements
			      | SOME index_list =>
				  print_as_tuple (index_list,elements)
			    end
			  else 
			    error_notification(object,"(Record is not of correct size)")
			end
		      else
			error_notification(object,"(record pointer not found when expected)")
		  end

		| value_to_string'(object,
                                   Datatypes.CONSTYPE
                                   (tys,Datatypes.METATYNAME(ref(tyfun as (Datatypes.TYFUN _)),_,_,_,_,_)),
                                   env,ref_depth,depth) =
                  value_to_string'(object,Types.apply(tyfun,tys),env,ref_depth,depth)
                  
                | value_to_string'(object,
                                   Datatypes.CONSTYPE
                                   (tys,Datatypes.METATYNAME(ref(Datatypes.ETA_TYFUN tyname),_,_,_,_,_)),
                                   env,ref_depth,depth) =
                  value_to_string'(object,Datatypes.CONSTYPE(tys,tyname),env,ref_depth,depth)

                | value_to_string' (object, ty as Datatypes.CONSTYPE(tys,tyname),env,ref_depth,depth) =
                  if debugger_print andalso
                     (case tyname of
                        Datatypes.METATYNAME(ref(Datatypes.NULL_TYFUN _),_,_,_,ref ve,_) =>
                          Valenv.empty_valenvp ve
                      | _ => false) then
                      (case tyname of
                         Datatypes.METATYNAME(ref(Datatypes.NULL_TYFUN(_,tyfun)),name,n,b,ve,is_abs) =>
                         (value_to_string'(object,
                                        Datatypes.CONSTYPE(tys,
                                                  Datatypes.METATYNAME(tyfun,name,n,b,ve,is_abs)),
                                        env,ref_depth,depth))
                        | _ => Crash.impossible "CONSTYPE:value_printer")
                  else 
                  let
                    val (in_table,func) = (* (true,NewMap.apply'(print_method_table,tyname)) 
                      handle NewMap.Undefined => *) (false, fn _ => "")

                    val primary = MLWorks.Internal.Value.primary object
                  in
                    if in_table then
                      let
                        val print_methods_for_arguments =
                          map (fn ty => fn (object) => value_to_string'(object,ty,env,ref_depth,depth-1)) tys

                        fun extract_elements object =
                          if primary = Tags.INTEGER0 orelse primary = Tags.INTEGER1 then
                            [object]
                          else if primary = Tags.PAIRPTR then
                            [MLWorks.Internal.Value.sub (object, 0),
                             MLWorks.Internal.Value.sub (object, 1)]
                          else if primary = Tags.REFPTR then
			    let
			      val (secondary, length) = MLWorks.Internal.Value.header object
			    in
			      if secondary = Tags.ARRAY then
				array_map
				  (object, max_len (maximum_seq_size, length))
				  (fn x => x)
			      else
				bytearray_map
				(object, max_len (maximum_seq_size, length))
				(fn x => x)
                            end
                          else if primary = Tags.POINTER then
                            let
                              val (secondary, length) = MLWorks.Internal.Value.header object
                            in
                              if secondary = Tags.RECORD then
                                record_map (object, length) (fn x => x)
                              else
                                []
                            end
                          else
                            []

                        val list_of_elements = extract_elements object

                        fun is_integer_tagged object =
                          let
                            val primary = MLWorks.Internal.Value.primary object
                          in
                            if primary = Tags.INTEGER0 orelse primary = Tags.INTEGER1 then
                              (true, cast object : int)
                            else
                              (false, 0)
                          end
                      in
                        func(list_of_elements,print_methods_for_arguments,extract_elements,is_integer_tagged)
                        handle _ => error_notification (object,"(Failure in a user print function)")
                      end

                    else 
		      if Types.type_eq (ty, Types.int32_type, true, true) then
                        Int32.toString (int32 object)
                        handle Value message => error_notification (object, "<" ^ message ^ ">")
                      else if Types.int_typep ty then
                        Int.toString (integer object)
                        handle Value message => error_notification (object, "<" ^ message ^ ">")

		      else if Types.type_eq (ty, Types.word32_type, true, true) then
                        "0w" ^ Word32.fmt StringCvt.DEC (word32 object)
                        handle Value message => error_notification (object, "<" ^ message ^ ">")
                      else if Types.word_typep ty then
                        "0w" ^ Word.fmt StringCvt.DEC (word object)
                        handle Value message => error_notification (object, "<" ^ message ^ ">")

                      else if Types.real_typep ty then
                        MLWorks.Internal.real_to_string(real object,float_precision)
                        handle Value message => error_notification (object, "<" ^ message ^ ">")

                      else if Types.tyname_eq (tyname,Types.bool_tyname) then
                        (fn true => "true" | false => "false") (bool object)
                        handle Value message => error_notification (object, "<" ^ message ^ ">")

                      else if Types.tyname_eq (tyname,Types.string_tyname) then
                        concat ["\"", MLWorks.String.ml_string
					 (string object,
					  maximum_string_size), "\""]
                        handle Value message => error_notification (object, "<" ^ message ^ ">")

                      else if Types.tyname_eq (tyname,Types.char_tyname) then
                        concat ["#\"", MLWorks.String.ml_string
				 (string (String.str(Char.chr(ord(MLWorks.Internal.Value.cast object)))),
				  maximum_string_size), "\""]
                        handle Value message => error_notification (object, "<" ^ message ^ ">")

                      else if Types.tyname_eq (tyname,Types.list_tyname) then
                        (case tys of
                           [ty] =>
                             if depth <= 1 then "[...]"
                             else
                               let
                                 val (total,element_list) =   
                                   list (maximum_seq_size,object,[])
                               in
                                 concat
                                 ("[" ::
                                  rev (
                                       (if total then "]" else list_ellipsis) ::
                                          Lists.reducel
                                          (fn (list, object) =>
                                           value_to_string' (object, ty, env, ref_depth, depth-1) ::
                                           (case list of
                                              [] => []
                                            | list => ", " :: list))
                                          ([],element_list)))
                               end
                         | _ => error_notification (object, "<list arity>"))
                        handle Value message => error_notification (object, "<" ^ message ^ ">")

                      else if Types.tyname_eq (tyname,Types.ml_value_tyname) then
                         shape (depth, maximum_seq_size,
				maximum_string_size, float_precision,object)

                      else if Types.tyname_eq (tyname,Types.exn_tyname) then
                        let
                          val s = MLWorks.Internal.Value.exn_name (exn object)
                        in
                          if print_exn_details then s
                          else find_end_of_name s
                        end

                      else if Types.tyname_eq (tyname,Types.ref_tyname) then 
                         if ref_depth <= 0 then
                           generate_underbar("ref_depth")
                         else
                           (case (tys, convert_ref object) of
                              ([ty], ref object) =>
                                concat ["ref(",
                                         value_to_string' (object,ty,env,ref_depth-1,depth-1),
                                         ")"]
                            | _ => error_notification (object, "<ref arity>"))
                           handle Value message => error_notification (object, "<" ^ message ^ ">")

                      else if Types.tyname_eq (tyname,Types.array_tyname) then
                        if ref_depth <= 0 then
                          generate_underbar("ref depth")
                        else
                          case tys of
                            [ty] => 
                              if MLWorks.Internal.Value.primary object = Tags.REFPTR
                                then
                                  let
				    val (secondary,length) =
				      MLWorks.Internal.Value.header object
                                  in
                                    if secondary = Tags.ARRAY then
				      let
					val element_list =
                                          array_map
                                            (object,
					     max_len (maximum_seq_size, length))
                                            (fn x => x)
					val tail = 
					  if length > maximum_seq_size andalso
					     maximum_seq_size > 0 then
                                             list_ellipsis
					  else
					    "]"
				      in
					concat
					("#A[" ::
					 rev (tail :: 
					      Lists.reducel
					      (fn (list, object') =>
					       value_to_string' (object', ty, env, ref_depth, depth-1) ::
					       (case list of
						  [] => []
						| list => ", " :: list))
					      ([],element_list)))
				      end
				    else
				      error_notification (object,"<Array not an array>")
                                  end
                              else
                                error_notification(object,"<Array not a ref pointer>")
                             | _ => error_notification (object,"<Bad array type>")
                        
                      else if Types.tyname_eq (tyname,Types.bytearray_tyname) then
                        if ref_depth <= 0 then
                          generate_underbar("ref depth")
                        else
                          if MLWorks.Internal.Value.primary object = Tags.REFPTR then
			    let
			      val (secondary,length) =
				MLWorks.Internal.Value.header object
			    in
			      if secondary = Tags.BYTEARRAY then
				let
				  val element_list =
				    bytearray_map
				      (object,
  				       max_len (maximum_seq_size, length))
				      (fn x => x)

				  val tail = 
                                    if length > maximum_seq_size andalso
				       maximum_seq_size > 0 then
                                       list_ellipsis
                                    else
                                      "]"
				in
				  concat
				  ("#B[" ::
				   rev (tail :: 
					Lists.reducel
					(fn (list, object') =>
					 value_to_string'
					 (cast object',
					  Types.int_type, env, ref_depth, depth-1) ::
					 (case list of
					    [] => []
					  | list => ", " :: list))
					([],element_list)))
				end
			      else
				error_notification
                                  (object,"<Bytearray not a bytearray>")
			    end
                          else
                            error_notification(object,"<Byte array not a ref>")


                      else if Types.tyname_eq (tyname,Types.floatarray_tyname)
                             then
                        if ref_depth <= 0 then
                          generate_underbar("ref depth")
                        else
                          if MLWorks.Internal.Value.primary object 
                                                       = Tags.REFPTR then
			    let
                              (* floatarray is implemented as a bytearray.
                                 each float is 8 bytes long *)

			      val (secondary,length) =
				MLWorks.Internal.Value.header object
                              val length = length div 8
			    in
			      if secondary = Tags.BYTEARRAY then
				let
				  val element_list =
				    floatarray_map
				      (cast object,
  				       max_len (maximum_seq_size, length))
				      (fn x => x)

				  val tail = 
                                    if length > maximum_seq_size andalso
				       maximum_seq_size > 0 then
                                       list_ellipsis
                                    else
                                      "]"
				in
				  concat
				  ("#F[" ::
				   rev (tail :: 
					Lists.reducel
					(fn (list, object') =>
					 value_to_string'
					 (cast object',
					  Types.real_type, env, ref_depth, depth-1) ::
					 (case list of
					    [] => []
					  | list => ", " :: list))
					([],element_list)))
				end
			      else
				error_notification
                                  (object,"<Floatarray not a floatarray>")
			    end
                          else
                            error_notification(object,"<Float array not a ref>")


		      else if Types.tyname_eq(tyname, Types.vector_tyname) then
                        if ref_depth <= 0 then
                          generate_underbar("ref depth")
                        else
                          case tys of
                            [ty] =>
			      let
				val primary = MLWorks.Internal.Value.primary object
				val (secondary, length) =
				  if primary = Tags.POINTER then
				    MLWorks.Internal.Value.header object
				  else
				    if primary = Tags.PAIRPTR then
				      (Tags.RECORD, 2)
				    else
				      (Tags.MLERROR, 0)
			      in
				if secondary = Tags.RECORD then
				  let
				    val element_list =
				      vector_map
				      (object, max_len(maximum_seq_size, length))
				      (fn x => x)
				    val tail = 
				      if length > maximum_seq_size then
                                        list_ellipsis
				      else
				        "]"
				  in
				    concat
				    ("#V[" ::
				     rev (tail :: 
					  Lists.reducel
					  (fn (list, object') =>
					   value_to_string' (object', ty, env, ref_depth, depth-1) ::
					   (case list of
					      [] => []
					    | list => ", " :: list))
					  ([],element_list)))
				  end
				else
				  if secondary = Tags.MLERROR then
				    error_notification(object,"<Vector not a pointer>")
				  else
				    error_notification (object,"<Vector not a record>")
			      end
			  | _ => error_notification (object,"<Bad vector type>")
                      else
                        let
                          fun do_it (ty_name,val_map as Datatypes.VE(_,constructor_map),is_abs) =
                             if (is_abs andalso not debugger_print)
                               orelse NewMap.is_empty constructor_map then
                               (* This probably means that we have a functor parameter type *)
                               generate_underbar("empty constructor map:"^ty_name)
                             else
                               let
                                 val (domain,range) = 
                                   Lists.unzip(NewMap.to_list_ordered constructor_map)
                                 val is_a_single_constructor = (length domain = 1)
                                 fun test_scheme (Datatypes.SCHEME(_,
                                                  (Datatypes.FUNTYPE _,_))) = true
                                   | test_scheme (Datatypes.UNBOUND_SCHEME(
                                                                Datatypes.FUNTYPE _,_)) = true
                                   | test_scheme _ = false
                                 val is_a_single_vcc = 
                                   case range of
                                     [x] => test_scheme x
                                   | _ => false
                               in
                                 if is_a_single_constructor andalso not is_a_single_vcc then
                                   case domain of
                                     [Ident.CON name] => Ident.Symbol.symbol_name name
                                   | _ => error_notification(object,
                                                            "(single non-vcc problem with name)")
                                 else 
                                   if is_a_single_vcc then
                                     case domain of 
                                       [name' as Ident.CON name] => 
                                         let
                                           val name = Ident.Symbol.symbol_name name
                                           val scheme = Valenv.lookup(name',val_map)

                                           val (ty,env') =
                                             (case scheme of
                                                Datatypes.SCHEME(_,(ty',_)) => 
                                                  (ty',ENTRY(tys,env))
                                              | Datatypes.UNBOUND_SCHEME(ty',_) => (ty',env)
					      | Datatypes.OVERLOADED_SCHEME _ =>
                                                  (Datatypes.NULLTYPE,env))
                                           val arg_type = get_arg_type ty
                                           val brackets = needs_brackets arg_type
                                         in
                                           concat [name,
                                                    (if brackets then "(" else " "),
                                                    value_to_string'(object,
                                                                     arg_type,
                                                                     env',ref_depth,depth-1),
                                                    (if brackets then ")" else "")]
                                         end
                                     | _ => error_notification(object,"(Problems in vcc code)")
                                   else
                                     if primary = Tags.INTEGER0 orelse primary = Tags.INTEGER1 then
                                       (case Lists.nth(cast(object),domain) of
                                          name' as Ident.CON name =>
					    (if test_scheme(NewMap.apply'(constructor_map, name')) then
					       error_notification(object,"(should carry value)")
					     else
					       Ident.Symbol.symbol_name name)
                                        | _ => error_notification(object,"(Not a CONS in a datatype)"))
                                          handle Lists.Nth =>
                                            (debug ("Yargh: " ^
                                                    Int.toString (cast object));
                                            generate_underbar("lists.nth 1"))
                                     else
				       if primary = Tags.PAIRPTR then
					 let
					   val (code, packet) =
					     (MLWorks.Internal.Value.sub (object,0),
					      MLWorks.Internal.Value.sub (object,1))
					   val code_primary =
					     MLWorks.Internal.Value.primary code
					 in
					   if code_primary = Tags.INTEGER0 orelse
					     code_primary = Tags.INTEGER1 then
					     let
					       val name' = Lists.nth(cast(code),domain)
					       val name =
						 case name' of
						   Ident.CON x => Ident.Symbol.symbol_name x
						 | _ => "CantFigureNameOut"
					       val scheme = Valenv.lookup(name',val_map)
					       val (ty,env') =
						 (case scheme of
						    Datatypes.SCHEME(_,(ty',_)) => 
						      (ty',ENTRY(tys,env))
						  | Datatypes.UNBOUND_SCHEME(ty',_) => (ty',env)
						  | Datatypes.OVERLOADED_SCHEME _ =>
						      (Datatypes.NULLTYPE,env))
					       val arg_type = get_arg_type ty
					       val brackets = needs_brackets arg_type
					     in
					       if test_scheme scheme then
						 concat [name,
							  (if brackets then "(" else " "),
							     value_to_string'(packet,
									      arg_type,
									      env',ref_depth,depth-1),
							     if brackets then ")" else ""]
					       else
						 error_notification(object,"(should not carry value)")
					     end
					   handle Lists.Nth => generate_underbar("lists.nth 2")
					   else
					     error_notification
					     (object, 
					      "(Constructor tag not integer in expected datatype case)")
					 end
				       else 
					 error_notification
					 (object, 
					  "(Not INTEGER or PAIR in expected datatype case)")
                               end
                        in
                          case tyname of
                            Datatypes.TYNAME (_,name,_,_,ref valenv,_,
                                              ref is_abs,_,_) =>
                              do_it (name,valenv,is_abs)
                          | Datatypes.METATYNAME (_,name,_,_,ref valenv,
                                                  ref is_abs) =>
                              do_it (name,valenv,is_abs)
                        end
                  end

                | value_to_string'(object,Datatypes.DEBRUIJN(level,_,_,_),env,ref_depth,depth) =
                  (case env of
                      ENTRY(env,old_env) =>
                        let
                          exception DeBruijn_In_ValuePrinter
                          fun find_it (level) =
                            let
                              fun find_it'(0,h::t) = h
                                | find_it'(n,h::t) = find_it'(n-1,t)
                                | find_it'(_,[]) = raise DeBruijn_In_ValuePrinter
                            in
                              find_it'(level,env)
                            end
                          val ty = find_it(level)
                        in
                          (* Print the value with the actual type at the same depth *)
                          value_to_string'(object,ty,old_env,ref_depth,depth)
                        end
                    (* Dynamic values can contain types with unbound debruijns *)
                    (* One day the debruijns will be filled in with recipe information *)
                    | _ => generate_underbar("Unbound debruijn"))

                | value_to_string'(_,Datatypes.NULLTYPE,env,ref_depth,depth) = generate_underbar("nulltype")
            in
              value_to_string'(object,ty,env,maximum_ref_depth,maximum_depth) 
            end
      in
        value_to_string(object,ty,EMPTY)
      end

    (* Why is this here? *)
    fun function_name f =
      let val object = cast f
      in MLWorks.String.ml_string (code_name (select 0 object), ~1)
	 handle Value _ => Crash.impossible "Error in function_name"
      end
  end
