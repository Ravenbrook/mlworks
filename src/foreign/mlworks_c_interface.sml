(* Copyright (C) 1997 The Harlequin Group Limited.  All rights reserved.
 *
 * MLWORKS_C_INTERFACE defines an interface between SML and C.
 * 
 * It defines various low level features that are mainly used to build
 * higher level abstractions.  Many of the operations provided here subvert
 * the strong static typing of SML and also allow direct access to machine
 * memory.  As such any errors in using these operations are unlikely to be
 * detected by the SML type checker and will possibly result in memory and
 * hence MLWorks being corrupted.  If at all possible do not use these
 * operations directly and if you do need to use them, take extreme care.
 * 
 * MLWORKS_C_INTERFACE also provdies SML equivalents of the C scalar types
 * and pointers to scalar types.
 *
 * Revision Log
 * ------------
 * $Log: mlworks_c_interface.sml,v $
 * Revision 1.3  1998/02/19 15:08:09  jont
 * [Bug #30341]
 * Fix where type ... and syntax
 *
 *  Revision 1.2  1997/07/03  09:38:14  stephenb
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *)

require "$.basis.__real";
require "$.basis.__word";
require "$.basis.__word8";
require "$.basis.__word16";
require "$.basis.__word32";
require "$.basis.char";
require "$.basis.integer";
require "$.basis.word";
require "$.basis.real";
require "mlworks_c_pointer";


signature MLWORKS_C_INTERFACE =
  sig

    (* 
     * The generic pointer type -- all pointers are built from this type.
     * 
     *)
    eqtype 'a ptr



    (*
     * void is only used in the construction of void pointers.  For 
     * example :-
     *
     *     C               ML
     *
     *   void *          void ptr
     *   void **         void ptr ptr
     *
     * The SML void type is not used to represent the C void type indicating
     * no arguments to a function or no result type.  The SML unit type
     * is used in this case.  For example, the following C function
     * declaration :-
     *
     *   void foo(void)         
     *
     * is represented as :-
     *
     *   foo : unit -> unit
     *
     * in SML and *NOT* as :-
     *
     *   foo : void -> void
     *)
    eqtype void



    (*
     * null is the generic null pointer.  It is equivalent to NULL in C.
     *)
    val null : 'a ptr



    (*
     * fromVoidPtr and toVoidPtr convert from a void pointer to a generic
     * pointer and from a generic pointer to a void pointer respectively.
     * These are equivalent to a cast in C and so should be used with
     * care since it is possible to defeat the type system.
     *)
    val fromVoidPtr : void ptr -> 'a ptr
    val toVoidPtr : 'a ptr -> void ptr



    (*
     * deRef8, deRef16, deRef32, deRefReal dereference a void pointer and
     * return a Word8.word, Word16.word, Word32.word and Real.real
     * respectively.  The pointers must be aligned according to the alignment
     * requirements of the underlying machine.  If the alignment requirements
     * are not met, then the result is undefined (it will typically result
     * in a SIGBUS under Unix or read exception under Windows 95/NT.
     *)
    val deRef8    : void ptr -> Word8.word
    val deRef16   : void ptr -> Word16.word
    val deRef32   : void ptr -> Word32.word
    val deRefReal : void ptr -> Real.real


    (*
     * update8, update16, update32 and updateReal update a void pointer with a
     * Word8.word, Word16.word, Word32.word and Real.real respectively.
     * The pointers must be aligned according to the alignment requirements
     * of the underlying machine.  If the alignment requirements are not met, 
     * then the result is undefined (it will typically result in a 
     * SIGBUS under Unix or write exception under Windows 95/NT.
     *)
    val update8    : void ptr * Word8.word  -> unit
    val update16   : void ptr * Word16.word -> unit
    val update32   : void ptr * Word32.word -> unit
    val updateReal : void ptr * Real.real   -> unit



    (*
     * malloc and free are bound to malloc and free in the underlying
     * C library and so behave identically.
     *)
    val malloc : Word.word -> void ptr
    val free   : void ptr -> unit



    (*
     * memcpy is bound to memcpy in the C library and copies size bytes
     * from source to dest.
     *)
    val memcpy : {source: void ptr, dest: void ptr, size: Word.word} -> unit



    (*
     * ptrSize specifies the size of a pointer in bytes.
     *)
    val ptrSize : Word.word



    (*
     * Convert a void pointer to and from an integral value.
     * That is, given the following C declarations :-
     *
     *   unsigned int x;
     *   void * p;
     * 
     * then toSysWord is equivalent to doing :-
     *
     *   x= (unsigned int)p;
     *
     * and fromSysWord is equivalent to doing :-
     *
     *   p= (void * )x;
     *
     * Note that this is not guaranteed by the C standard, but it is
     * guaranteed to work on the platforms that MLWorks runs on.
     *)
    val toSysWord : void ptr -> SysWord.word
    val fromSysWord : SysWord.word -> void ptr



    (* next p n
     * prev p n
     *
     * next and prev provide a limited form of pointer arithmetic.
     * They allow a new pointer to be constructed that points to n bytes
     * after (before) p.
     *)
    val next : void ptr * Word.word -> void ptr
    val prev : void ptr * Word.word -> void ptr



    (*
     * syerror and SysErr are the same type and exception that are
     * defined in the OS and MLWORKS_DYNAMIC_LIBRARY signatures.
     *)
    type syserror
    exception SysErr of (string * syserror option)



    structure Char   : CHAR       (* equvalent to signed char  in C *)
    structure Short  : INTEGER    (* equvalent to signed short in C *)
    structure Int    : INTEGER    (* equvalent to signed int   in C *)
    structure Long   : INTEGER    (* equvalent to signed long  in C *)

    structure Uchar  : WORD       (* equvalent to unsigned char  in C *)
    structure Ushort : WORD       (* equvalent to unsigned short in C *)
    structure Uint   : WORD       (* equvalent to unsigned int   in C *)
    structure Ulong  : WORD       (* equvalent to unsigned long  in C *)

    structure Double : REAL       (* equivalent to double in C *)

    structure CharPtr :           (* equivalent to char * in C *)
      sig
        include MLWORKS_C_POINTER

        (* fromString string
         *
         * fromString converts an SML string into a C char *.
         * This is done by using malloc to create the space for the string
         * and copying the SML string to the allocated space.  If malloc
         * cannot allocate sufficient space, then a null pointer is returned.
         *)
        val fromString : string -> Char.char ptr


        (* copySubString Cstring size
         *
         * copySubString copies size bytes of Cstring to create a new
         * SML string.
         *)
        val copySubString : Char.char ptr * Word.word -> string

      end where type value = Char.char
      where type  'a ptr = 'a ptr



    structure ShortPtr  : MLWORKS_C_POINTER
       where type value = Short.int
       where type  'a ptr = 'a ptr

    structure IntPtr    : MLWORKS_C_POINTER
       where type value = Int.int
       where type  'a ptr = 'a ptr

    structure LongPtr   : MLWORKS_C_POINTER
      where type value = Long.int
      where type  'a ptr = 'a ptr

    structure UcharPtr  : MLWORKS_C_POINTER
      where type value = Uchar.word
      where type  'a ptr = 'a ptr

    structure UshortPtr : MLWORKS_C_POINTER
       where type value = Ushort.word
       where type  'a ptr = 'a ptr

    structure UintPtr   : MLWORKS_C_POINTER
       where type value = Uint.word
       where type  'a ptr = 'a ptr

    structure UlongPtr  : MLWORKS_C_POINTER
      where type value = Ulong.word
      where type  'a ptr = 'a ptr


    structure DoublePtr  : MLWORKS_C_POINTER
      where type value = Double.real
      where type  'a ptr = 'a ptr


    (*
     * For all the machines that MLWorks runs on, all pointers to pointers
     * share the same representation.  Therefore, in various cases it
     * is not necessary to instantiate MLWorksCPointer if all you need
     * is the ability to dereference or update a pointer pointer.
     *)
    structure PtrPtr :
      sig
        val := : 'a ptr ptr * 'a ptr -> unit
        val ! : 'a ptr ptr -> 'a ptr
      end

  end
