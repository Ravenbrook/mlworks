(*  ==== Project workspace demo file ====
 *
 *  Copyright (C) 1998  Harlequin Group plc. All rights reserved.
 *
 * $Log: fac.sml,v $
 * Revision 1.2  1998/05/12 10:49:05  jkbrook
 * Automatic checkin:
 * changed attribute _comment to ' *  '
 * 
 *)

fun fac 0 = 1 | fac n = n * fac (n-1);

