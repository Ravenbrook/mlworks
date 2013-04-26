(*  ==== Testing ====
 *
 *  Result: OK
 *
 *  Copyright (C) 1998 Harlequin Group plc.
 *
 *  Revision Log
 *  ------------
 *  $Log: pack_words.sml,v $
 *  Revision 1.2  1998/08/17 16:34:26  jont
 *  Automatic checkin:
 *  changed attribute _comment to ' *  '
 *
 *
 *)

val u = Word8Vector.fromList (map Word8.fromInt  [0,0,0,1]);
val x1 = Pack32Little.subVec(u, 0) = 0w16777216;
val x2 = Pack32Big.subVec(u, 0) = 0w1;
val v = Word8Vector.fromList (map Word8.fromInt  [1,0,0,0]);
val x3 = Pack32Little.subVec(v, 0) = 0w1;
val x4 = Pack32Big.subVec(v, 0) = 0w16777216;
val w = Word8Vector.fromList (map Word8.fromInt  [0,1]);
val y1 = Pack16Little.subVec(w, 0) = 0w256;
val y2 = Pack16Big.subVec(w, 0) = 0w1;
val x = Word8Vector.fromList (map Word8.fromInt  [1,0]);
val y3 = Pack16Little.subVec(x, 0) = 0w1;
val y4 = Pack16Big.subVec(x, 0) = 0w256;
