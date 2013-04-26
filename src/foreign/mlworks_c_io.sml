(* Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 *
 * An interface to <stdio.h> in C and some utility functions.
 *
 * The sprintf, fprintf, fprintf, scanf and sscanf functions are not supported.
 *
 * Any type, function or value without a comment behaves like the
 * corresponding C type, function or value.
 *

 * Revision Log
 * ------------
 * $Log: mlworks_c_io.sml,v $
 * Revision 1.2  1997/07/03 09:39:40  stephenb
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 *
 *)

require "^.basis.__char_array";
require "^.basis.__char_vector";
require "^.basis.__real_array";
require "^.basis.__real_vector";
require "__mlworks_c_interface";

signature MLWORKS_C_IO =
  sig
    type FILE

    type size_t = MLWorksCInterface.Uint.word

    type c_char = MLWorksCInterface.Char.char
    type c_int = MLWorksCInterface.Int.int
    type void = MLWorksCInterface.void

    type 'a ptr = 'a MLWorksCInterface.ptr

    val EOF : c_int

    val clearerr : FILE ptr -> unit

    val fclose : FILE ptr -> int

    val ferror : FILE ptr -> c_int

    val feof : FILE ptr -> c_int

    val fgetc : FILE ptr -> c_int

    val fopen : string * string -> FILE ptr 

    val fputc : FILE ptr * c_char -> c_int

    val fputs : FILE ptr * c_char ptr -> c_int

    val fputString : FILE ptr * string -> c_int

    val fflush : FILE ptr -> c_int

    val fread : void ptr * size_t * size_t * FILE ptr -> size_t


    (* freadCharArray array offset n stream
     *
     * read n characters from the input stream and place them starting at
     * the given offset into the char array.  Returns the number of
     * characters actually read.
     * 
     * Raises Overflow if offset+n-1 is larger than Int.maxInt
     * Raises Subcript if [offset..offset+n-1] is not a subrange of
     * [0..length(vector)-1]
     *)
    val freadCharArray : CharArray.array * int * int * FILE ptr -> int



    (* freadRealArray array offset n stream
     *
     * read n reals from the input stream and place them starting at
     * the given offset into the real array.  Returns the number of
     * reals actually read.
     *
     * Raises Overflow if offset+n-1 is larger than Int.maxInt
     * Raises Subcript if [offset..offset+n-1] is not a subrange of
     * [0..length(vector)-1]
     *)
    val freadRealArray : RealArray.array * int * int * FILE ptr -> int


    (* Add IntVector, Int32Vector, ... etc. when MLWorks supports them *)


    val freopen : string * string * FILE ptr -> FILE ptr

    val fseek : FILE ptr * MLWorksCInterface.Long.int * c_int -> c_int

    val ftell : FILE ptr -> MLWorksCInterface.Long.int

    val fwrite : void ptr * size_t * size_t * FILE ptr -> size_t



    (* fwriteCharArray array offset n stream
     *
     * write n characters starting at the given offset from the start of 
     * the array to the output stream.  Returns the number of characters
     * written.
     *
     * Raises Overflow if offset+n-1 is larger than Int.maxInt
     * Raises Subcript if [offset..offset+n-1] is not a subrange of
     * [0..length(vector)-1]
     *)
    val fwriteCharArray : CharArray.array * int * int * FILE ptr -> int



    (* fwriteCharVector vector offset n stream
     *
     * write n characters starting at the given offset from the start of 
     * the vector to the output stream.  Returns the number of characters
     * written.
     *
     * Raises Overflow if offset+n-1 is larger than Int.maxInt
     * Raises Subcript if [offset..offset+n-1] is not a subrange of
     * [0..length(vector)-1]
     *)
    val fwriteCharVector : CharVector.vector * int * int * FILE ptr -> int



    (* fwriteRealArray array offset n stream
     *
     * write n reals starting at the given offset from the start of the
     * array to the output stream.  Returns the number of reals written.
     *
     * Raises Overflow if offset+n-1 is larger than Int.maxInt
     * Raises Subcript if [offset..offset+n-1] is not a subrange of
     * [0..length(vector)-1]
     *)
    val fwriteRealArray : RealArray.array * int * int * FILE ptr -> int



    (* fwriteRealVector vector offset n stream
     *
     * write n reals starting at the given offset from the start of the
     * vector to the output stream.  Returns the number of reals written.
     *
     * Raises Overflow if offset+n-1 is larger than Int.maxInt
     * Raises Subcript if [offset..offset+n-1] is not a subrange of
     * [0..length(vector)-1]
     *)
    val fwriteRealVector : RealVector.vector * int * int * FILE ptr -> int



    (* fwriteString vector offset n stream
     *
     * write n characters starting at the given offset from the start of 
     * the string to the output stream.  Returns the number of characters
     * written.
     *
     * Unless n is 0, raises Overflow if offset+n-1 is larger than Int.maxInt
     * and raises Subcript if [offset..offset+n-1] is not a subrange of
     * [0..length(vector)-1]
     *)
    val fwriteString : string * int * int * FILE ptr -> int


    (* Add IntVector Int32Vector, ... etc. when MLWorks supports them *)


    val perror : c_char ptr -> unit


    (*
     * Like perror, except that it takes an ML string rather than
     * a C string.
     *)
    val perrorString : string -> unit


    val setvbuff : FILE ptr * c_char ptr * c_int * size_t -> c_int

    val setbuff : 
      FILE ptr * c_char -> unit


    (*
     * stdin, stdout and stderr each returns a file associated with
     * the standard input, standard output and standard error respectively.
     *)
    val stdin  : unit -> FILE ptr
    val stdout : unit -> FILE ptr
    val stderr : unit -> FILE ptr


    val ungetc : FILE ptr * c_int -> c_int
  end
