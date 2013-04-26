(*  ==== INITIAL BASIS : WORD 16 ARRAY ====
 *
 *  Copyright (C) 1997 The Harlequin Group Ltd.  All rights reserved.
 *
 *  Implementation
 *  --------------
 *  Word 16 arrays are instances of generic MonoArrays
 *
 *  Revision Log
 *  ------------
 *  $Log: __word16_array2.sml,v $
 *  Revision 1.2  1997/11/26 17:57:44  daveb
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *
 *
 *)

require "_mono_array2";

structure Word16Array2 = MonoArray2 (type elem = MLWorks.Internal.Types.word16)
