(*

Result: OK
 
$Log: shift.sml,v $
Revision 1.2  1996/05/20 10:11:53  jont
Bits moved to MLWorks.Internal

 * Revision 1.1  1994/05/25  11:13:04  jont
 * new file
 *
Copyright (c) 1994 Harlequin Ltd.
*)

fun exp2 n = MLWorks.Internal.Bits.lshift (1,n) val two16 = exp2 16
