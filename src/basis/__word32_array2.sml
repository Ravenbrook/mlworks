(*  ==== INITIAL BASIS : WORD 32 ARRAY ====
 *
 *  Copyright (C) 1997 The Harlequin Group PLC.  All rights reserved.
 *
 *  Implementation
 *  --------------
 *  Word 32 arrays are instances of generic MonoArrays
 *
 *  Revision Log
 *  ------------
 *  $Log: __word32_array2.sml,v $
 *  Revision 1.2  1997/11/26 17:59:35  daveb
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *
 *)


require "_mono_array2";

structure Word32Array2 = MonoArray2 (type elem = MLWorks.Internal.Types.word32)
