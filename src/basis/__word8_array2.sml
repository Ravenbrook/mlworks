(*  ==== INITIAL BASIS : WORD 8 ARRAY2 ====
 *
 *  Copyright (C) 1997 The Harlequin Group Ltd.  All rights reserved.
 *
 *  Implementation
 *  --------------
 *  Word 8 array2s are instances of generic MonoArrays.
 *  This should be improved.
 *
 *  Revision Log
 *  ------------
 *  $Log: __word8_array2.sml,v $
 *  Revision 1.2  1997/11/26 18:01:42  daveb
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *
 *
 *)

require "_mono_array2";

structure Word8Array2 = MonoArray2 (type elem = MLWorks.Internal.Types.word8)
