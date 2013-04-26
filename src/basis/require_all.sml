(*
 * A file to ensure all the basis gets compiled
 * and to ensure that those items that should be visible at top level are
 *
 * Copyright (C) 1996 Harlequin Ltd.
 *
 * $Log: require_all.sml,v $
 * Revision 1.48  1999/03/20 22:14:05  daveb
 * [Bug #20125]
 * Replaced substructure with type.
 *
 *  Revision 1.47  1999/02/18  15:09:36  mitchell
 *  [Bug #190507]
 *  Modify to satisfy CM constraints.
 *
 *  Revision 1.46  1999/02/15  14:30:36  mitchell
 *  [Bug #190508]
 *  Export sockets structures from project
 *
 *  Revision 1.45  1999/02/03  23:18:19  mitchell
 *  [Bug #50108]
 *  Change ModuleId from an equality type
 *
 *  Revision 1.44  1998/04/06  10:19:33  jont
 *  [Bug #70089]
 *  Add __sys_word to list of basis files
 *
 *  Revision 1.43  1998/03/17  17:19:22  jkbrook
 *  [Bug #50052]
 *  Include command_line structure
 *
 *  Revision 1.42  1997/11/26  17:20:08  daveb
 *  [Bug #30329]
 *  Added WordNArray2.
 *
 *  Revision 1.41  1997/11/25  18:02:18  daveb
 *  [Bug #30329]
 *  Added functor declarations.
 *  Removed requires of internal functors.
 *
 *  Revision 1.40  1997/11/24  12:13:59  daveb
 *  [Bug #30304]
 *  Added SML90.
 *
 *  Revision 1.39  1997/08/04  12:00:01  brucem
 *  [Bug #30004]
 *  Add signature OPTION and structure Option.
 *
 *  Revision 1.38  1997/05/27  13:15:55  jkbrook
 *  [Bug #01749]
 *  Added synonym structure files: __large_{int,real,word} and __sys_word
 *
 *  Revision 1.37  1997/03/06  16:04:07  jont
 *  [Bug #1938]
 *  Remove __pre_basis from require list
 *
 *  Revision 1.36  1997/03/05  10:44:23  matthew
 *  Adding array2
 *
 *  Revision 1.35  1997/02/26  11:21:54  andreww
 *  [Bug #1759]
 *  adding new TEXT_STREAM_IO sig.
 *
 *  Revision 1.34  1997/01/31  12:23:33  andreww
 *  [Bug #1901]
 *  Adding RealArray and RealVector structures.
 *
 *  Revision 1.33  1997/01/15  11:46:07  io
 *  [Bug #1757]
 *  rename __prereal to __pre_real
 *         __preint32 to __pre_int32
 *          __preinteger to __pre_int
 *         __preword to __pre_word
 *         __preword32 to __pre_word32
 *  and changes for Bug 1892
 *
 *  Revision 1.32  1997/01/08  11:32:11  io
 *  [Bug #1757]
 *  renamed __ieeereal to __ieee_real
 *          __char{array,vector} to __char_{array,vector}
 *
 *  Revision 1.31  1996/12/19  12:34:02  jont
 *  [Bug #1764]
 *  Remove old and __old
 *
 *  Revision 1.30  1996/11/06  14:02:17  matthew
 *  [Bug #1726]
 *  Adding __old.sml
 *
 *  Revision 1.29  1996/11/06  10:49:22  matthew
 *  Renamed __integer to __int
 *
 *  Revision 1.28  1996/10/21  16:30:10  andreww
 *  [Bug #1682]
 *  Remove structure General.
 *
 *  Revision 1.27  1996/10/21  15:11:02  jont
 *  Remove references to toplevel
 *
 *  Revision 1.26  1996/10/09  13:54:23  jont
 *  Ensure all structures are provided at top level where necessary
 *
 *  Revision 1.25  1996/07/18  14:55:26  andreww
 *  [Bug #1453]
 *  updating and renaming IO structures to bring them inline with
 *  May 30 basis document.
 *
 *  Revision 1.24  1996/06/27  14:57:20  andreww
 *  Adding IO structure to make it visible in guib.img
 *
 *  Revision 1.23  1996/06/24  11:55:14  io
 *  constrain __char for Char.scanc
 *
 *  Revision 1.22  1996/06/04  20:01:28  io
 *  stringcvt -> string_cvt
 *
 *  Revision 1.21  1996/06/03  15:22:03  andreww
 *  Add text_ and bin_ io structures.
 *
 *  Revision 1.20  1996/05/24  12:17:40  andreww
 *  add TextPrimIO and BinPrimIO structures.
 *
 *  Revision 1.19  1996/05/22  14:04:29  io
 *  add substring
 *
 *  Revision 1.18  1996/05/21  16:27:47  jont
 *  Remove OS_PRIM_IO from list of exported signatures, it is merely internal
 *
 *  Revision 1.17  1996/05/21  12:21:58  stephenb
 *  Replace path with os_path, the new revised basis conformant path.
 *
 *  Revision 1.16  1996/05/21  11:42:35  jont
 *  signature changes
 *
 *  Revision 1.15  1996/05/17  09:35:30  stephenb
 *  Change filesys -> file_sys in accordance with latest file naming conventions.
 *
 *  Revision 1.14  1996/05/16  14:52:17  io
 *  add string
 *
 *  Revision 1.13  1996/05/15  16:27:54  jont
 *  Make LargeWord visible at top level
 *
 *)
require "option";
require "__option";
require "array";
require "array2";
require "bool";
require "__bool";
require "string_cvt";
require "__string_cvt";
require "char";
require "__char";
require "word";
require "__word";
require "__word8";
require "mono_array";
require "mono_array2";
require "mono_vector";
require "__word8_vector";
require "__word8_array";
require "__word8_array2";
require "__real_vector";
require "__real_array";
require "__real_array2";
require "byte";
require "time";
require "../system/__time";
require "date";
require "real";
require "__date";
require "integer";
require "prim_io";
require "stream_io";
require "text_stream_io";
require "io";
require "__io";
require "list_pair";
require "list";
require "math";
require "ieee_real";
require "__ieee_real";
require "__sys_word";
require "os_path";
require "os_file_sys";
require "os_process";
require "os";
require "os_io";
require "pack_word";
require "string";
require "__string";
require "substring";
require "__substring";
require "timer";
require "vector";
require "imperative_io";
require "bin_io";
require "text_io";
require "__text_prim_io";
require "__bin_prim_io";
require "__text_io";
require "__bin_io";
require "__char_vector";
require "__char_array";
require "__int";
require "__position";
require "_prim_io";
require "_stream_io";
require "_imperative_io";
require "__byte";
require "__word32";
require "__word16";
require "__list";
require "__list_pair";
require "__math";

require "../system/__os";
require "__pack16_big";
require "__pack16_little";
require "__pack32_big";
require "__pack32_little";
require "__pack8_big";
require "__pack8_little";
require "__real";
require "__timer";
require "__word16_vector";
require "__word16_array";
require "__word16_array2";
require "__word32_vector";
require "__word32_array";
require "__word32_array2";
require "__int8";
require "__int16";
require "__int32";
require "__large_int";
require "__large_real";
require "__large_word";
require "__array";
require "__vector";
require "__array2";
require "sml90";
require "__sml90";
require "command_line";
require "__command_line";
require "__sys_word";
require "__general";  
require "general";  

require "__net_db";
require "__serv_db";
require "__prot_db";
require "__host_db";
require "__socket";
require "__inet_sock";
require "__unix_sock";

signature ARRAY=ARRAY
signature ARRAY2=ARRAY2
signature BOOL=BOOL
signature STRING_CVT=STRING_CVT
signature CHAR=CHAR
signature WORD=WORD
signature MONO_ARRAY=MONO_ARRAY
signature MONO_ARRAY2=MONO_ARRAY2
signature MONO_VECTOR=MONO_VECTOR
signature BYTE=BYTE
signature TIME=TIME
signature DATE=DATE
signature REAL=REAL
signature INTEGER=INTEGER
signature PRIM_IO=PRIM_IO
signature STREAM_IO=STREAM_IO
signature IO=IO
signature LIST_PAIR=LIST_PAIR
signature LIST=LIST
signature MATH=MATH
signature IEEE_REAL=IEEE_REAL
signature OPTION=OPTION
signature OS_PATH=OS_PATH
signature OS_FILE_SYS=OS_FILE_SYS
signature OS_PROCESS=OS_PROCESS
signature OS=OS
signature OS_IO=OS_IO
signature PACK_WORD=PACK_WORD
signature STRING=STRING
signature SUBSTRING=SUBSTRING
signature TIMER=TIMER
signature VECTOR=VECTOR
signature BIN_IO=BIN_IO
signature TEXT_IO=TEXT_IO
signature TEXT_STREAM_IO=TEXT_STREAM_IO
signature IMPERATIVE_IO=IMPERATIVE_IO
signature SML90=SML90
signature COMMAND_LINE=COMMAND_LINE
signature GENERAL=GENERAL

structure Array=Array
structure Array2=Array2
structure BinIO=BinIO
structure BinPrimIO=BinPrimIO
structure Bool=Bool
structure Byte=Byte
structure Char=Char
structure CharArray=CharArray
structure CharVector=CharVector
structure Date=Date
structure General=General
structure IEEEReal=IEEEReal
structure Int=Int
structure Int8=Int8
structure Int16=Int16
structure Int32=Int32
structure IO=IO
structure LargeInt=LargeInt
structure LargeReal=LargeReal
structure LargeWord=LargeWord
structure List=List
structure ListPair=ListPair
structure Math=Math
structure Option=Option
structure OS=OS
structure Pack8Big=Pack8Big
structure Pack8Little=Pack8Little
structure Pack16Big=Pack16Big
structure Pack16Little=Pack16Little
structure Pack32Big=Pack32Big
structure Pack32Little=Pack32Little
structure Position=Position
structure Real=Real
structure String=String
structure StringCvt=StringCvt
structure Substring=Substring
structure SysWord=SysWord
structure TextIO=TextIO
structure TextPrimIO=TextPrimIO
structure Time=Time
structure Timer=Timer
structure Vector=Vector
structure Word=Word
structure Word8=Word8
structure Word16=Word16
structure Word32=Word32
structure Word8Array=Word8Array
structure Word8Array2=Word8Array2
structure Word8Vector=Word8Vector
structure Word16Array=Word16Array
structure Word16Array2=Word16Array2
structure Word16Vector=Word16Vector
structure Word32Array=Word32Array
structure Word32Array2=Word32Array2
structure Word32Vector=Word32Vector
structure RealVector=RealVector
structure RealArray=RealArray
structure RealArray2=RealArray2
structure SML90=SML90;
structure CommandLine=CommandLine;
structure SysWord = SysWord;

structure NetDB = NetDB;
structure NetServDB = NetServDB;
structure NetProtDB = NetProtDB;
structure NetHostDB = NetHostDB;
structure Socket = Socket;
structure INetSock = INetSock;
structure UnixSock = UnixSock;

functor ImperativeIO (
          structure StreamIO : STREAM_IO
          structure Vector: MONO_VECTOR
          structure Array: MONO_ARRAY
          sharing type StreamIO.elem = Vector.elem = Array.elem
          sharing type StreamIO.vector = Vector.vector = Array.vector
        ) : IMPERATIVE_IO = 
  ImperativeIO
    (structure StreamIO = StreamIO
     structure Vector = Vector
     structure Array = Array);

functor PrimIO (
          include sig
            structure A : MONO_ARRAY
            structure V : MONO_VECTOR
          end
          sharing type A.vector = V.vector
          sharing type A.elem = V.elem
          val someElem : A.elem
          type pos
          val compare : pos * pos -> order
        ) : PRIM_IO =
  PrimIO (
    structure A = A
    structure V = V
    val someElem = someElem
    type pos = pos
    val compare = compare);

functor StreamIO (
          structure PrimIO : PRIM_IO
          structure Vector : MONO_VECTOR
          structure Array: MONO_ARRAY
          val someElem : PrimIO.elem
          sharing type PrimIO.vector = Array.vector = Vector.vector
          sharing type PrimIO.array = Array.array
          sharing type Array.elem = PrimIO.elem = Vector.elem
        ) : STREAM_IO =
  StreamIO (
    structure PrimIO = PrimIO
    structure Vector = Vector
    structure Array = Array
    val someElem = someElem);














